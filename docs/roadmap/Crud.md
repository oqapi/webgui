# WebGUI::Crud: default clause in crud_updateTable

Status: known issue, not fixed. Nothing in this tree triggers it (checked
2026-11-11). Fix it when a Crud subclass needs it.

## The change

Commit d7e07b8e0 (7.10.33, "MySQL 8.0 support") removed the condition on
the default clause in `crud_updateTable` (`lib/WebGUI/Crud.pm`):

```diff
-            $defaultClause = "default ".$dbh->quote($defaultValue) if ($defaultValue ne "");
+            $defaultClause = "default ".$dbh->quote($defaultValue);
```

Current code:

```perl
my $notNullClause = ($isKey || $defaultValue ne "") ? "not null" : "";
my $defaultClause = '';
if ($fieldType !~ /(?:text|blob)$/i) {
    $defaultClause = "default ".$dbh->quote($defaultValue);
}
```

The clause ends up in `alter table ... add column` / `change column`, with
the type from the form control's `getDatabaseFieldType` (`BIGINT` for
integer, date and DateTime; `BOOLEAN` for yesNo; `CHAR(255)` for most
others).

## Effect

Every non-TEXT/BLOB column now always gets a default clause:

| `defaultValue` | `isQueryKey` | generated SQL                    | result |
|----------------|--------------|----------------------------------|--------|
| `undef`        | no           | `BIGINT default NULL`            | fine: DBI `quote(undef)` is an unquoted `NULL` |
| `''`           | no           | `BIGINT default ''`              | error 1067 (Invalid default value) in strict mode on numeric/date/boolean types |
| `undef`        | yes          | `CHAR(22) not null default NULL` | error 1067, strict mode or not |
| `'x'`, `0`     | any          | `... not null default '0'`       | same as before d7e07b8e0 |

The third row is the example in the POD of `crud_definition` in the same
file (`presidentUserId`, guid, `defaultValue => undef`, `isQueryKey => 1`):
a class written from that example fails on `crud_createTable`.

(The 1067 results follow from MySQL/MariaDB rules; not reproduced here.)

## Who is affected

None of the Crud subclasses in the tree: `AssetCollateral/Sku/Ad/Ad.pm`,
`AssetCollateral/Sku/ThingyRecord/Record.pm`, `PassiveAnalytics/Rule.pm`,
`Asset/Wobject/Survey/Test.pm`, `FilePump/Bundle.pm`. None uses
`isQueryKey`, and every `''` default is on a text/textarea field.

At risk: custom or third-party Crud subclasses. Check these when custom
modules move to webgui-compose.

## Proposed fix

Keep `default ''` for CHAR columns (what d7e07b8e0 presumably wanted for
MySQL 8 strict mode), drop `default NULL` and `default ''` on other types:

```perl
if ($fieldType !~ /(?:text|blob)$/i && defined $defaultValue
    && ($defaultValue ne '' || $fieldType =~ /char/i)) {
    $defaultClause = "default ".$dbh->quote($defaultValue);
}
```

Test: a throwaway Crud subclass with an integer field with `''`, a guid
with `isQueryKey` and undef, a yesNo with `0` and a char with `''`; run
`crud_createTable` and `crud_updateTable` in a `webgui-app` Podman
container against MariaDB in strict mode, before and after the fix; then
`t/Crud.t` and `t/Crud/*.t`.
