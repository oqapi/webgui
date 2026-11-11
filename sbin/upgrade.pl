#!/usr/bin/env perl

#-------------------------------------------------------------------
# WebGUI is Copyright 2001-2009 Plain Black Corporation.
#-------------------------------------------------------------------
# Please read the legal notices (docs/legal.txt) and the license
# (docs/license.txt) that came with this distribution before using
# this software.
#-------------------------------------------------------------------
# http://www.plainblack.com                     info@plainblack.com
#-------------------------------------------------------------------

use strict;
use File::Basename ();
use File::Spec;

my $webguiRoot;
BEGIN {
    $webguiRoot = File::Spec->rel2abs(File::Spec->catdir(File::Basename::dirname(__FILE__), File::Spec->updir));
    unshift @INC, File::Spec->catdir($webguiRoot, 'lib');
}

use Cwd ();
use File::Path ();
use Getopt::Long ();
use Pod::Usage ();

foreach my $libDir ( readLines( "$webguiRoot/sbin/preload.custom" ) ) {
    if ( !-d $libDir ) {
        warn "WARNING: Not adding lib directory '$libDir' from $webguiRoot/sbin/preload.custom: Directory does not exist.\n";
        next;
    }
    unshift @INC, $libDir;
}

require WebGUI::Config;
require WebGUI::Session;

my $help;
my $history;
my $override;
my $quiet;
my $mysql = "mysql";
my $mysqldump = "mysqldump";
my $backupDir = "/tmp/backups";
my $skipBackup;
my $skipDelete;
my $skipMaintenance;
# upgrade steps that end at or before this version run without strict mode
my $lastLaxVersion = "7.10.32";
my $doit;

Getopt::Long::GetOptions(
        'help'=>\$help,
        'history'=>\$history,
        'override'=>\$override,
        'quiet'=>\$quiet,
	'mysql=s'=>\$mysql,
	'doit'=>\$doit,
	'skipDelete' =>\$skipDelete,
	'skipMaintenance' =>\$skipMaintenance,
	'mysqldump=s'=>\$mysqldump,
	'backupDir=s'=>\$backupDir,
	'skipbackup'=>\$skipBackup
);

Pod::Usage::pod2usage( verbose => 2 ) if $help;
Pod::Usage::pod2usage() unless $doit;

unless ($doit) {
	print <<STOP;

+--------------------------------------------------------------------+
|                                                                    |
|                         W  A  R  N  I  N  G                        |
|                                                                    |
| There are no guarantees of any kind provided with this software.   |
| This utility has been tested rigorously, and has performed without |
| error or consequence in our labs, and on our production servers    |
| for many years. However, there is no substitute for a good backup  |
| of your software and data before performing any kind of upgrade.   |
|                                                                    |
| BEFORE YOU UPGRADE you should definitely read docs/gotcha.txt to   |
| find out what things you should know about that will affect your   |
| upgrade.                                                           |
|                                                                    |
+--------------------------------------------------------------------+
|                                                                    |
| For more information about this utility type:                      |
|                                                                    |
| perl upgrade.pl --help                                             |
|                                                                    |
+--------------------------------------------------------------------+

STOP
	exit;
}


if (!($^O =~ /^Win/i) && $> != 0 && !$override) {
	print "You must be the super user to use this utility.\n";
	exit;
}

## Globals

$| = 1;
our $perl = $^X;
our $slash;
if ($^O =~ /^Win/i) {
	$slash = "\\";
} else {
	$slash = "/";
}
our $upgradesPath = $webguiRoot.$slash."docs".$slash."upgrades".$slash;
our (%upgrade, %config);


## Find site configs.

print "\nGetting site configs...\n" unless ($quiet);
my $configs = WebGUI::Config->readAllConfigs($webguiRoot);
foreach my $filename (keys %{$configs}) {
	print "\tProcessing $filename.\n" unless ($quiet);
	$config{$filename}{configFile} = $filename;
	$config{$filename}{dsn} = $configs->{$filename}->get("dsn");
	my $temp = _parseDSN($config{$filename}{dsn}, ['database', 'host', 'port']);
	if ($temp->{'driver'} eq "mysql") {
		$config{$filename}{db} = $temp->{'database'};
		$config{$filename}{host} = $temp->{'host'};
		$config{$filename}{port} = $temp->{'port'};
		$config{$filename}{dbuser} = $configs->{$filename}->get("dbuser");
		$config{$filename}{dbpass} = $configs->{$filename}->get("dbpass");
		$config{$filename}{mysqlCLI} = $configs->{$filename}->get("mysqlCLI");
		$config{$filename}{mysqlDump} = $configs->{$filename}->get("mysqlDump");
		$config{$filename}{backupPath} = $configs->{$filename}->get("backupPath");
        # Opening a session inserts a row in userSession. MySQL >= 5.7 and
        # MariaDB >= 10.2.4 run in strict mode, and before 7.10.33 the column
        # userSession.userId has no default, so that insert fails before the
        # upgrade that adds the default can run. Set it first, with a plain
        # database connection, but only when the column is NOT NULL without
        # a default. SET DEFAULT keeps the column type.
        {
            require DBI;
            my $dbh = DBI->connect($config{$filename}{dsn}, $config{$filename}{dbuser},
                $config{$filename}{dbpass}, { RaiseError => 1, PrintError => 0 });
            my ($needsDefault) = $dbh->selectrow_array(q{
                SELECT COUNT(*) FROM information_schema.COLUMNS
                WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'userSession'
                  AND COLUMN_NAME = 'userId' AND IS_NULLABLE = 'NO'
                  AND COLUMN_DEFAULT IS NULL
            });
            if ($needsDefault) {
                print "\tSetting a default for userSession.userId.\n" unless ($quiet);
                $dbh->do(q{ALTER TABLE userSession ALTER COLUMN userId SET DEFAULT ''});
            }
            # The sql_mode of the server without strict mode, for the upgrade
            # steps up to and including 7.10.32 (see $lastLaxVersion).
            my ($sqlMode) = $dbh->selectrow_array('SELECT @@SESSION.sql_mode');
            $config{$filename}{laxSqlMode} = join ',',
                grep { $_ ne '' && !/^STRICT_(?:TRANS|ALL)_TABLES$/ } split /,/, $sqlMode;
            $dbh->disconnect;
        }
        # Remember the id of the userSession row, so the session can be reopened
        # after the upgrade instead of inserting a second row.
        my $session = WebGUI::Session->open($webguiRoot, $filename);
        $config{$filename}{sessionId} = $session->getId;
    	($config{$filename}{version}) = $session->db->quickArray("select webguiVersion from webguiVersion order by
        dateApplied desc, length(webguiVersion) desc, webguiVersion desc limit 1");
		unless ($history) {
			print "\tPreparing site for upgrade.\n" unless ($quiet);
			unless ($skipMaintenance) {
				$session->setting->remove('specialState');
				$session->setting->add('specialState','upgrading');
			}
			unless ($skipDelete) {
				print "\tDeleting temp files.\n" unless ($quiet);
				my $path = $configs->{$filename}->get("uploadsPath").$slash."temp";
				File::Path::rmtree($path, {keep_root => 1, }) unless ($path eq "" || $path eq "/" || $path eq "/data");
				print "\tDeleting file cache.\n" unless ($quiet);
				$path = $configs->{$filename}->get("fileCacheRoot")||"/tmp/WebGUICache";
				File::Path::rmtree($path, {keep_root => 1, })  unless ($path eq "" || $path eq "/" || $path eq "/data");
			}
		}
		$session->close();
	} else {
		delete $config{$filename};
		print "\tSkipping non-MySQL database.\n" unless ($quiet);
	}
}

if ($history) {
	print "\nDisplaying upgrade history for each site.\n";
	foreach my $file (keys %config) {
		print "\n".$file."\n";
		my $session = WebGUI::Session->open($webguiRoot,$file);
		my $sth = $session->db->read("select * from webguiVersion order by dateApplied asc, webguiVersion asc");
		while (my $data = $sth->hashRef) {
			print "\t".sprintf("%-8s  %-15s  %-15s",
				$data->{webguiVersion},
				$session->datetime->epochToHuman($data->{dateApplied},"%y-%m-%d"),
				$data->{versionType})."\n";
		}
		$sth->finish;
		$session->close;
	}
	exit;
}

## Find upgrade files.

print "\nLooking for upgrade files...\n" unless ($quiet);
opendir(DIR,$upgradesPath) or die "Couldn't open $upgradesPath\n";
my @files = readdir(DIR);
closedir(DIR);
foreach my $file (@files) {
	if ($file =~ /^upgrade_(\d+\.\d+\.\d+)-(\d+\.\d+\.\d+)\.(pl|sql)$/) {
		if (checkVersion($1)) {
			if ($3 eq "sql") {
				print "\tFound upgrade script from $1 to $2.\n" unless ($quiet);
				$upgrade{$1}{sql} = $file;
			} elsif ($3 eq "pl") {
				print "\tFound upgrade executable from $1 to $2.\n" unless ($quiet);
				$upgrade{$1}{pl} = $file;
			}
			$upgrade{$1}{from} = $1;
			$upgrade{$1}{to} = $2;
		}
	}
}

print "\nREADY TO BEGIN UPGRADES\n" unless ($quiet);

my $notRun = 1;


my $currentPath  = Cwd::getcwd();
my $totalConfigs = scalar keys %config;
my $configCounter = 0;
foreach my $filename (keys %config) {
    chdir($upgradesPath);
	my $clicmd = $config{$filename}{mysqlCLI} || $mysql;
	my $dumpcmd = $config{$filename}{mysqlDump} || $mysqldump;
	my $backupTo = $config{$filename}{backupPath} || $backupDir;
	mkdir($backupTo);
    ++$configCounter;
	while ($upgrade{$config{$filename}{version}}{sql} ne "" || $upgrade{$config{$filename}{version}}{pl} ne "") {
		my $upgrade = $upgrade{$config{$filename}{version}}{from};
		print "\n".$config{$filename}{db}." ".$upgrade{$upgrade}{from}."-".$upgrade{$upgrade}{to}."\n" unless ($quiet);
        print "Processing $configCounter out of $totalConfigs configs\n" unless ($quiet);
		unless ($skipBackup) {
			print "\tBacking up $config{$filename}{db} ($upgrade{$upgrade}{from})..." unless ($quiet);
			my $cmd = qq!$dumpcmd -u"$config{$filename}{dbuser}" -p"$config{$filename}{dbpass}"!;
			$cmd .= " --host=".$config{$filename}{host} if ($config{$filename}{host});
			$cmd .= " --port=".$config{$filename}{port} if ($config{$filename}{port});
			$cmd .= " --add-drop-table ".$config{$filename}{db}." --result-file="
				.$backupTo.$slash.$config{$filename}{db}."_".$upgrade{$upgrade}{from}."_".time.".sql";
			unless (system($cmd)) {
				print "OK\n" unless ($quiet);
			} else {
				print "Failed!\n" unless ($quiet);
				fatalError();
			}
		}
		# Before 7.10.33 many NOT NULL columns have no default, so the steps
		# up to and including 7.10.32 fail in strict mode (MySQL >= 5.7,
		# MariaDB >= 10.2.4), for example on the version tag every upgrade
		# script creates. Run them without strict mode, as on the servers
		# they were written for. 7.10.32-7.10.33 adds the defaults first
		# (its .sql runs before its .pl) and runs in strict mode.
		my $laxSqlMode = versionCompare($upgrade{$upgrade}{to}, $lastLaxVersion) <= 0
			? $config{$filename}{laxSqlMode} : undef;
		if (defined $laxSqlMode) {
			print "\tWithout strict mode (sql_mode '$laxSqlMode').\n" unless ($quiet);
		}
		if ($upgrade{$upgrade}{sql} ne "") {
			print "\tUpgrading to ".$upgrade{$upgrade}{to}."..." unless ($quiet);
			my $cmd = qq!$clicmd -u"$config{$filename}{dbuser}" -p"$config{$filename}{dbpass}"!;
			$cmd .= qq! --init-command="SET SESSION sql_mode='$laxSqlMode'"! if (defined $laxSqlMode);
			$cmd .= " --host=".$config{$filename}{host} if ($config{$filename}{host});
			$cmd .= " --port=".$config{$filename}{port} if ($config{$filename}{port});
			$cmd .= " --database=".$config{$filename}{db}." < ".$upgrade{$upgrade}{sql};
			unless (system($cmd)) {
				print "OK\n" unless ($quiet);
			} else {
                		print "Failed!\n" unless ($quiet);
				fatalError();
                	}
		}
		if ($upgrade{$upgrade}{pl} ne "") {
            my $pid = fork;
            if (!$pid) {
                local @ARGV = ("--configFile=$filename", $quiet ? ('--quiet') : ());
                # "./": do() with a bare file name searches @INC, and since
                # Perl 5.26 '.' is no longer in @INC. Without it the upgrade
                # script is not run: Perl only warns, $@ stays empty, so it
                # counts as a success. We are in $upgradesPath here.
                local $0 = "./" . $upgrade{$upgrade}{pl};
                # Only in this child process: every database connection of
                # the upgrade script runs without strict mode.
                if (defined $laxSqlMode) {
                    my $connect = \&WebGUI::SQL::connect;
                    no warnings 'redefine';
                    *WebGUI::SQL::connect = sub {
                        my $db = $connect->(@_);
                        $db->dbh->do("SET SESSION sql_mode = ?", undef, $laxSqlMode) if $db;
                        return $db;
                    };
                }
                local $@;
                do $0;
                if ($@) {
                    warn $@;
                    exit 255;
                };
                exit;
            }
            waitpid $pid, 0;
            if ($?) {
                print "\tProcessing upgrade executable failed!\n";
                fatalError();
            }
            ##Do a dummy load of the config
            WebGUI::Config->clearCache();
		}
		$config{$filename}{version} = $upgrade{$upgrade}{to};
		$notRun = 0;
        sleep 1; # Sleep a second to avoid adding asset revisions too quickly
	}
    chdir($currentPath);
	# Reopen the userSession row of the start (noFuss: do not update or
	# expire it, this is the 1 at the end), and remove it when done.
	my $session = WebGUI::Session->open($webguiRoot, $filename, undef, undef,
		$config{$filename}{sessionId}, 1);
	print "\tSetting site upgrade completed..." unless ($quiet);
    unless ($skipMaintenance) {
        $session->setting->remove('specialState');
    }
	$session->var->end;
	$session->close();
	print "OK\n" unless ($quiet);
}

if ($notRun) {
	print "\nNO UPGRADES NECESSARY\n\n" unless ($quiet);
} else {
	unless ($quiet) {
		print <<STOP;

UPGRADES COMPLETE
Please restart your web server and test your sites.

WARNING: If you saw any errors in the output during the upgrade, restore 
your install and databases from backup immediately. Do not continue using 
your site EVEN IF IT SEEMS TO WORK.

NOTE: If you have not already done so, please consult
docs/gotcha.txt for possible upgrade complications.

STOP
	}
}




#-----------------------------------------
# versionCompare($a, $b): <0, 0 or >0, like <=>
#-----------------------------------------
sub versionCompare {
    my @a = split /\./, shift;
    my @b = split /\./, shift;
    for my $i (0 .. 2) {
        my $cmp = ($a[$i] // 0) <=> ($b[$i] // 0);
        return $cmp if $cmp;
    }
    return 0;
}

#-----------------------------------------
# checkVersion($versionNumber)
#-----------------------------------------
# Version number must be 7.3.22 or greater
# in order to be upgraded by this utility.
#-----------------------------------------
sub checkVersion {
    $_[0] =~ /(\d+)\.(\d+)\.(\d+)/;
    my $goal = 7;
    my $feature = 3;
    my $fix = 22;
    if ($1 > $goal) {
        return 1;
    }
    elsif ($1 == $goal) {
        if ($2 > $feature) {
            return 1;
        }
        elsif ($2 == $feature) {
            if ($3 >= $fix) {
                return 1;
            }
        }
    }
    return 0;
}

#-----------------------------------------
sub fatalError {
	print <<STOP;

The upgrade process failed and has stopped so you can either restore
from backup, or attempt to fix the problem and continue.

STOP
    exit 1;
}


#-----------------------------------------
sub _parseDSN {
    my($dsn, $args) = @_;
    my($var, $val, $hash);
    $hash = {};

    if (!defined($dsn)) {
        return;
    }

    $dsn =~ s/^dbi:(\w*?)(?:\((.*?)\))?://i
                        or '' =~ /()/; # ensure $1 etc are empty if match fails
    $hash->{driver} = $1;

    while (length($dsn)) {
        if ($dsn =~ /([^:;]*)[:;](.*)/) {
            $val = $1;
            $dsn = $2;
        } else {
            $val = $dsn;
            $dsn = '';
        }
        if ($val =~ /([^=]*)=(.*)/) {
            $var = $1;
            $val = $2;
            if ($var eq 'hostname'  ||  $var eq 'host') {
                $hash->{'host'} = $val;
            } elsif ($var eq 'db'  ||  $var eq 'dbname') {
                $hash->{'database'} = $val;
            } else {
                $hash->{$var} = $val;
            }
        } else {
            foreach $var (@$args) {
                if (!defined($hash->{$var})) {
                    $hash->{$var} = $val;
                    last;
                }
            }
        }

     }
     return $hash;
}

sub readLines {
    my $file = shift;
    my @lines;
    if (open(my $fh, '<', $file)) {
        while (my $line = <$fh>) {
            $line =~ s/#.*//;
            $line =~ s/^\s+//;
            $line =~ s/\s+$//;
            next if !$line;
            push @lines, $line;
        }
        close $fh;
    }
    return @lines;
}

__END__

=head1 NAME

upgrade - Upgrade WebGUI database to the latest revision.

=head1 SYNOPSIS

 upgrade --doit
         [--backupDir path]
         [--history]
         [--mysql pathname]
         [--mysqldump pathname]
         [--override]
         [--skipBackup]
         [--skipDelete]
         [--skipMaintenance]
         [--quiet]

 upgrade --help

=head1 DESCRIPTION

This WebGUI utility script is able to upgrade B<any> WebGUI database
from 7.3.22 upward to the currently installed version. The WebGUI
software distribution includes a set of upgrade scripts that
perform the necessary database changes (schema and data) to bring
the database up-to-date in order to match the currently installed
WebGUI libraries and programs.

This utility is designed to be run as a superuser on Linux systems,
since it needs to be able to access several system directories
and change ownership of files. If you want to run this utility without
superuser privileges, use the B<--override> option described below.

=head1 WARNING

There are B<NO> guarantees of any kind provided with this software.
This utility has been tested rigorously, and has performed without
error or consequences in our labs, and on our production servers
for many years. However, there is no substitute for a good backup
of your software and data before performing any kind of upgrade.

B<BEFORE YOU UPGRADE> you should definitely read docs/gotcha.txt to
find out what things you should know about that will affect your
upgrade.

=over

=item B<--doit>

You B<MUST> include this flag in the command line or the script
will refuse to run. This is to force you to read this documentation
at least once and be sure that you B<REALLY> want to perform the
upgrade.

=item B<--backupDir path>

Specify a path where database backups should be created during the
upgrade procedure. If left unspecified, it defaults to B</tmp/backups>.

=item B<--history>

Displays the upgrade history for each of your sites. Running with this
flag will B<NOT> perform the upgrade.

=item B<--mysql pathname>

The full pathname to your mysql client executable. If left unspecified,
it defaults to B</usr/bin/mysql>.

=item B<--mysqldump pathname>

The full pathname to your mysqldump executable. If left unspecified,
it defaults to B</usr/bin/mysqldump>.

=item B<--override>

This flag will allow you to run this utility without being the super user,
but note that it may not work as intended.

=item B<--skipBackup>

Use this if you B<DO NOT> want database backups to be performed
during the upgrade procedure.

=item B<--skipDelete>

The upgrade procedure normally deletes WebGUI's cache and temporary files
created as part of the upgrade. This cleanup is very important during
large upgrades, but can make the procedure quite slow. This option
skips the deletion of these files.

=item B<--skipMaintenance>

The upgrade procedure normally puts up a simple maintenance page on all
the sites while running, but this option will skip that step.

=item B<--quiet>

Disable all output unless there's an error.

=item B<--help>

Shows this documentation, then exits.

=back

=head1 AUTHOR

Copyright 2001-2009 Plain Black Corporation.

=cut
