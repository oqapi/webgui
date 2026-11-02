SET @OLD_CHARACTER_SET_CLIENT       = @@CHARACTER_SET_CLIENT;
SET @OLD_CHARACTER_SET_RESULTS      = @@CHARACTER_SET_RESULTS;
SET @OLD_CHARACTER_SET_CONNECTION   = @@CHARACTER_SET_CONNECTION;
SET @OLD_COLLATION_CONNECTION       = @@COLLATION_CONNECTION;
SET @OLD_TIME_ZONE                  = @@TIME_ZONE;
SET @OLD_UNIQUE_CHECKS              = @@UNIQUE_CHECKS;
SET @OLD_FOREIGN_KEY_CHECKS         = @@FOREIGN_KEY_CHECKS;
SET @OLD_SQL_MODE                   = @@SQL_MODE;
SET @OLD_SQL_NOTES                  = @@SQL_NOTES;

SET CHARACTER_SET_CLIENT            = 'utf8';
SET CHARACTER_SET_RESULTS           = 'utf8';
SET CHARACTER_SET_CONNECTION        = 'utf8';
SET TIME_ZONE                       = '+00:00';
SET UNIQUE_CHECKS                   = 0;
SET FOREIGN_KEY_CHECKS              = 0;
SET SQL_MODE                        = 'NO_AUTO_VALUE_ON_ZERO';
SET SQL_NOTES                       = 0;
/*M!999999\- enable the sandbox mode */ 
CREATE TABLE `AdSku` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `purchaseTemplate` char(22) binary NOT NULL,
  `manageTemplate` char(22) binary NOT NULL,
  `adSpace` char(22) binary NOT NULL,
  `priority` int(11) DEFAULT 1,
  `pricePerClick` float DEFAULT 0,
  `pricePerImpression` float DEFAULT 0,
  `clickDiscounts` char(22) DEFAULT NULL,
  `impressionDiscounts` char(22) DEFAULT NULL,
  `karma` int(11) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Article` (
  `linkTitle` char(255) DEFAULT NULL,
  `linkURL` text DEFAULT NULL,
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `cacheTimeout` int(11) NOT NULL DEFAULT 3600,
  `storageId` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `AssetReport` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `settings` mediumtext DEFAULT NULL,
  `templateId` char(22) binary DEFAULT NULL,
  `paginateAfter` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Calendar` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `defaultDate` enum('current','first','last') DEFAULT 'current',
  `defaultView` enum('month','week','day','list') DEFAULT 'month',
  `visitorCacheTimeout` int(11) unsigned DEFAULT NULL,
  `templateIdMonth` char(22) binary DEFAULT 'CalendarMonth000000001',
  `templateIdWeek` char(22) binary DEFAULT 'CalendarWeek0000000001',
  `templateIdDay` char(22) binary DEFAULT 'CalendarDay00000000001',
  `templateIdEvent` char(22) binary DEFAULT 'CalendarEvent000000001',
  `templateIdEventEdit` char(22) binary DEFAULT 'CalendarEventEdit00001',
  `templateIdSearch` char(22) binary DEFAULT 'CalendarSearch00000001',
  `templateIdPrintMonth` char(22) binary DEFAULT 'CalendarPrintMonth0001',
  `templateIdPrintWeek` char(22) binary DEFAULT 'CalendarPrintWeek00001',
  `templateIdPrintDay` char(22) binary DEFAULT 'CalendarPrintDay000001',
  `templateIdPrintEvent` char(22) binary DEFAULT 'CalendarPrintEvent0001',
  `groupIdEventEdit` char(22) binary DEFAULT '3',
  `groupIdSubscribed` char(22) binary DEFAULT NULL,
  `subscriberNotifyOffset` int(11) DEFAULT NULL,
  `sortEventsBy` enum('time','sequencenumber') DEFAULT 'time',
  `listViewPageInterval` bigint(20) DEFAULT NULL,
  `templateIdList` char(22) binary DEFAULT NULL,
  `templateIdPrintList` char(22) binary DEFAULT NULL,
  `icalInterval` bigint(20) DEFAULT NULL,
  `workflowIdCommit` char(22) binary DEFAULT NULL,
  `icalFeeds` longtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Carousel` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `items` mediumtext DEFAULT NULL,
  `templateId` char(22) binary DEFAULT NULL,
  `slideWidth` int(11) DEFAULT NULL,
  `slideHeight` int(11) DEFAULT NULL,
  `autoPlay` int(11) DEFAULT NULL,
  `autoPlayInterval` int(11) DEFAULT NULL,
  `richEditor` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Collaboration` (
  `assetId` char(22) binary NOT NULL,
  `postGroupId` char(22) binary NOT NULL DEFAULT '2',
  `canStartThreadGroupId` char(22) binary NOT NULL DEFAULT '2',
  `karmaPerPost` int(11) NOT NULL DEFAULT 0,
  `collaborationTemplateId` char(22) binary NOT NULL,
  `threadTemplateId` char(22) binary NOT NULL,
  `postFormTemplateId` char(22) binary NOT NULL,
  `searchTemplateId` char(22) binary NOT NULL,
  `notificationTemplateId` char(22) binary NOT NULL,
  `sortBy` char(35) NOT NULL DEFAULT 'assetData.revisionDate',
  `sortOrder` char(4) NOT NULL DEFAULT 'desc',
  `usePreview` int(11) NOT NULL DEFAULT 1,
  `addEditStampToPosts` int(11) NOT NULL DEFAULT 0,
  `editTimeout` int(11) NOT NULL DEFAULT 3600,
  `attachmentsPerPost` int(11) NOT NULL DEFAULT 0,
  `filterCode` char(30) NOT NULL DEFAULT 'javascript',
  `useContentFilter` int(11) NOT NULL DEFAULT 1,
  `threads` int(11) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  `replies` int(11) NOT NULL DEFAULT 0,
  `rating` int(11) NOT NULL DEFAULT 0,
  `lastPostId` char(22) binary DEFAULT NULL,
  `lastPostDate` bigint(20) DEFAULT NULL,
  `archiveAfter` int(11) NOT NULL DEFAULT 31536000,
  `postsPerPage` int(11) NOT NULL DEFAULT 10,
  `threadsPerPage` int(11) NOT NULL DEFAULT 30,
  `subscriptionGroupId` char(22) binary DEFAULT NULL,
  `allowReplies` int(11) NOT NULL DEFAULT 0,
  `displayLastReply` int(11) NOT NULL DEFAULT 0,
  `richEditor` char(22) binary NOT NULL DEFAULT 'PBrichedit000000000002',
  `karmaRatingMultiplier` int(11) NOT NULL DEFAULT 0,
  `karmaSpentToRate` int(11) NOT NULL DEFAULT 0,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `avatarsEnabled` int(11) NOT NULL DEFAULT 0,
  `approvalWorkflow` char(22) binary NOT NULL DEFAULT 'pbworkflow000000000003',
  `threadApprovalWorkflow` char(22) binary NOT NULL DEFAULT 'pbworkflow000000000003',
  `defaultKarmaScale` int(11) NOT NULL DEFAULT 1,
  `mailServer` char(255) DEFAULT NULL,
  `mailAccount` char(255) DEFAULT NULL,
  `mailPassword` char(255) DEFAULT NULL,
  `mailAddress` char(255) DEFAULT NULL,
  `mailPrefix` char(255) DEFAULT NULL,
  `getMail` int(11) NOT NULL DEFAULT 0,
  `getMailInterval` char(64) DEFAULT NULL,
  `getMailCronId` char(22) binary DEFAULT NULL,
  `visitorCacheTimeout` int(11) NOT NULL DEFAULT 3600,
  `autoSubscribeToThread` int(11) NOT NULL DEFAULT 1,
  `requireSubscriptionForEmailPosting` int(11) NOT NULL DEFAULT 1,
  `thumbnailSize` int(11) NOT NULL DEFAULT 0,
  `maxImageSize` int(11) NOT NULL DEFAULT 0,
  `enablePostMetaData` int(11) NOT NULL DEFAULT 0,
  `useCaptcha` int(11) NOT NULL DEFAULT 0,
  `groupToEditPost` char(22) binary NOT NULL,
  `archiveEnabled` int(1) DEFAULT 1,
  `postReceivedTemplateId` char(22) binary DEFAULT 'default_post_received1',
  `replyRichEditor` char(22) binary DEFAULT 'PBrichedit000000000002',
  `replyFilterCode` char(30) binary DEFAULT 'javascript',
  `unsubscribeTemplateId` char(22) NOT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Dashboard` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `adminsGroupId` char(22) binary NOT NULL DEFAULT '4',
  `usersGroupId` char(22) binary NOT NULL DEFAULT '2',
  `templateId` char(22) binary NOT NULL DEFAULT 'DashboardViewTmpl00001',
  `isInitialized` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `assetsToHide` text DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Dashboard_dashlets` (
  `dashboardAssetId` char(22) binary NOT NULL DEFAULT '',
  `dashletAssetId` char(22) binary NOT NULL DEFAULT '',
  `isStatic` tinyint(1) DEFAULT NULL,
  `isRequired` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`dashboardAssetId`,`dashletAssetId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Dashboard_userPrefs` (
  `dashboardAssetId` char(22) binary NOT NULL DEFAULT '',
  `dashletAssetId` char(22) binary NOT NULL DEFAULT '',
  `userId` char(22) binary NOT NULL DEFAULT '',
  `isMinimized` tinyint(1) DEFAULT NULL,
  `properties` longtext DEFAULT NULL,
  PRIMARY KEY (`dashboardAssetId`,`dashletAssetId`,`userId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `DataForm` (
  `acknowledgement` text DEFAULT NULL,
  `mailData` int(11) NOT NULL DEFAULT 1,
  `emailTemplateId` char(22) binary NOT NULL,
  `acknowlegementTemplateId` char(22) binary NOT NULL,
  `listTemplateId` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `defaultView` int(11) NOT NULL DEFAULT 0,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `groupToViewEntries` char(22) binary NOT NULL DEFAULT '7',
  `mailAttachments` int(11) DEFAULT 0,
  `useCaptcha` int(1) DEFAULT 0,
  `storeData` int(1) DEFAULT 1,
  `fieldConfiguration` longtext DEFAULT NULL,
  `tabConfiguration` longtext DEFAULT NULL,
  `workflowIdAddEntry` char(22) binary DEFAULT NULL,
  `htmlAreaRichEditor` char(22) binary DEFAULT '**Use_Default_Editor**',
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `DataForm_entry` (
  `DataForm_entryId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  `username` char(255) DEFAULT NULL,
  `ipAddress` char(255) DEFAULT NULL,
  `assetId` char(22) binary NOT NULL,
  `entryData` longtext DEFAULT NULL,
  `submissionDate` datetime DEFAULT NULL,
  PRIMARY KEY (`DataForm_entryId`),
  KEY `assetId` (`assetId`),
  KEY `assetId_submissionDate` (`assetId`,`submissionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `DataTable` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `data` longtext DEFAULT NULL,
  `templateId` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSBadge` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `price` float NOT NULL DEFAULT 0,
  `seatsAvailable` int(11) NOT NULL DEFAULT 100,
  `relatedBadgeGroups` mediumtext DEFAULT NULL,
  `templateId` char(22) binary NOT NULL,
  `earlyBirdPrice` float NOT NULL DEFAULT 0,
  `earlyBirdPriceEndDate` bigint(20) DEFAULT NULL,
  `preRegistrationPrice` float NOT NULL DEFAULT 0,
  `preRegistrationPriceEndDate` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSBadgeGroup` (
  `badgeGroupId` char(22) binary NOT NULL,
  `emsAssetId` char(22) binary NOT NULL,
  `name` char(100) DEFAULT NULL,
  `ticketsPerBadge` int(11) DEFAULT NULL,
  PRIMARY KEY (`badgeGroupId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSEventMetaField` (
  `fieldId` char(22) binary NOT NULL,
  `assetId` char(22) binary DEFAULT NULL,
  `label` char(100) DEFAULT NULL,
  `dataType` char(20) DEFAULT NULL,
  `visible` tinyint(4) DEFAULT 0,
  `required` tinyint(4) DEFAULT 0,
  `possibleValues` text DEFAULT NULL,
  `defaultValues` text DEFAULT NULL,
  `sequenceNumber` int(5) DEFAULT NULL,
  `helpText` mediumtext DEFAULT NULL,
  PRIMARY KEY (`fieldId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSRegistrant` (
  `badgeId` char(22) binary NOT NULL,
  `userId` char(22) binary DEFAULT NULL,
  `badgeNumber` int(11) NOT NULL AUTO_INCREMENT,
  `badgeAssetId` char(22) binary NOT NULL,
  `emsAssetId` char(22) binary NOT NULL,
  `name` char(35) NOT NULL,
  `address1` char(35) DEFAULT NULL,
  `address2` char(35) DEFAULT NULL,
  `address3` char(35) DEFAULT NULL,
  `city` char(35) DEFAULT NULL,
  `state` char(35) DEFAULT NULL,
  `zipcode` char(35) DEFAULT NULL,
  `country` char(35) DEFAULT NULL,
  `phoneNumber` char(35) DEFAULT NULL,
  `organization` char(35) DEFAULT NULL,
  `email` char(255) DEFAULT NULL,
  `notes` mediumtext DEFAULT NULL,
  `purchaseComplete` tinyint(1) DEFAULT NULL,
  `hasCheckedIn` tinyint(1) DEFAULT NULL,
  `transactionItemId` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`badgeId`),
  UNIQUE KEY `badgeNumber` (`badgeNumber`),
  KEY `badgeAssetId_purchaseComplete` (`badgeAssetId`,`purchaseComplete`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSRegistrantRibbon` (
  `badgeId` char(22) binary NOT NULL,
  `ribbonAssetId` char(22) binary NOT NULL,
  `transactionItemId` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`badgeId`,`ribbonAssetId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSRegistrantTicket` (
  `badgeId` char(22) binary NOT NULL,
  `ticketAssetId` char(22) binary NOT NULL,
  `purchaseComplete` tinyint(1) DEFAULT NULL,
  `transactionItemId` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`badgeId`,`ticketAssetId`),
  KEY `ticketAssetId_purchaseComplete` (`ticketAssetId`,`purchaseComplete`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSRegistrantToken` (
  `badgeId` char(22) binary NOT NULL,
  `tokenAssetId` char(22) binary NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `transactionItemIds` text DEFAULT NULL,
  PRIMARY KEY (`badgeId`,`tokenAssetId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSRibbon` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `percentageDiscount` float NOT NULL DEFAULT 10,
  `price` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSSubmission` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `submissionId` int(11) NOT NULL,
  `submissionStatus` char(30) DEFAULT NULL,
  `ticketId` char(22) binary DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `sku` char(35) DEFAULT NULL,
  `vendorId` char(22) binary DEFAULT NULL,
  `displayTitle` tinyint(1) DEFAULT NULL,
  `shipsSeparately` tinyint(1) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `seatsAvailable` int(11) DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `eventNumber` int(11) DEFAULT NULL,
  `location` char(100) DEFAULT NULL,
  `relatedBadgeGroups` mediumtext DEFAULT NULL,
  `relatedRibbons` mediumtext DEFAULT NULL,
  `eventMetaData` mediumtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSSubmissionForm` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `canSubmitGroupId` char(22) binary DEFAULT NULL,
  `daysBeforeCleanup` int(11) DEFAULT NULL,
  `deleteCreatedItems` int(1) DEFAULT NULL,
  `formDescription` text DEFAULT NULL,
  `submissionDeadline` date DEFAULT NULL,
  `pastDeadlineMessage` text DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSTicket` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `price` float NOT NULL DEFAULT 0,
  `seatsAvailable` int(11) NOT NULL DEFAULT 100,
  `startDate` datetime DEFAULT NULL,
  `duration` float NOT NULL DEFAULT 1,
  `eventNumber` int(11) DEFAULT NULL,
  `location` char(100) DEFAULT NULL,
  `relatedBadgeGroups` mediumtext DEFAULT NULL,
  `relatedRibbons` mediumtext DEFAULT NULL,
  `eventMetaData` mediumtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EMSToken` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `price` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Event` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `feedId` char(22) binary DEFAULT NULL,
  `feedUid` char(255) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `userDefined1` text DEFAULT NULL,
  `userDefined2` text DEFAULT NULL,
  `userDefined3` text DEFAULT NULL,
  `userDefined4` text DEFAULT NULL,
  `userDefined5` text DEFAULT NULL,
  `recurId` char(22) binary DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `relatedLinks` longtext DEFAULT NULL,
  `location` char(255) DEFAULT NULL,
  `storageId` char(22) binary NOT NULL,
  `timeZone` char(255) DEFAULT 'America/Chicago',
  `sequenceNumber` bigint(20) DEFAULT NULL,
  `iCalSequenceNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `EventManagementSystem` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `timezone` char(30) NOT NULL DEFAULT 'America/Chicago',
  `templateId` char(22) binary NOT NULL DEFAULT '2rC4ErZ3c77OJzJm7O5s3w',
  `badgeBuilderTemplateId` char(22) binary NOT NULL DEFAULT 'BMybD3cEnmXVk2wQ_qEsRQ',
  `lookupRegistrantTemplateId` char(22) binary NOT NULL DEFAULT 'OOyMH33plAy6oCj_QWrxtg',
  `printBadgeTemplateId` char(22) binary NOT NULL DEFAULT 'PsFn7dJt4wMwBa8hiE3hOA',
  `printTicketTemplateId` char(22) binary NOT NULL DEFAULT 'yBwydfooiLvhEFawJb0VTQ',
  `printRemainingTicketsTemplateId` char(22) NOT NULL DEFAULT 'hreA_bgxiTX-EzWCSZCZJw',
  `badgeInstructions` mediumtext DEFAULT NULL,
  `ribbonInstructions` mediumtext DEFAULT NULL,
  `ticketInstructions` mediumtext DEFAULT NULL,
  `tokenInstructions` mediumtext DEFAULT NULL,
  `registrationStaffGroupId` char(22) binary NOT NULL,
  `scheduleTemplateId` char(22) binary DEFAULT NULL,
  `scheduleColumnsPerPage` int(11) DEFAULT NULL,
  `eventSubmissionTemplateId` char(22) binary DEFAULT NULL,
  `eventSubmissionQueueTemplateId` char(22) binary DEFAULT NULL,
  `eventSubmissionMainTemplateId` char(22) binary DEFAULT NULL,
  `eventSubmissionGroups` mediumtext DEFAULT NULL,
  `submittedLocationsList` mediumtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Event_recur` (
  `recurId` char(22) binary NOT NULL,
  `recurType` char(16) DEFAULT NULL,
  `pattern` char(255) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  PRIMARY KEY (`recurId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Event_relatedlink` (
  `eventlinkId` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `linkURL` tinytext DEFAULT NULL,
  `linktext` char(80) DEFAULT NULL,
  `groupIdView` char(22) binary NOT NULL,
  `sequenceNumber` bigint(20) DEFAULT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `FileAsset` (
  `assetId` char(22) binary NOT NULL,
  `storageId` char(22) binary NOT NULL,
  `filename` char(255) NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `cacheTimeout` int(11) NOT NULL DEFAULT 3600,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `FlatDiscount` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `templateId` char(22) binary NOT NULL DEFAULT '63ix2-hU0FchXGIWkG3tow',
  `mustSpend` float NOT NULL DEFAULT 0,
  `percentageDiscount` int(3) NOT NULL DEFAULT 0,
  `priceDiscount` float NOT NULL DEFAULT 0,
  `thankYouMessage` mediumtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Folder` (
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `visitorCacheTimeout` int(11) NOT NULL DEFAULT 3600,
  `sortAlphabetically` int(11) NOT NULL DEFAULT 0,
  `sortOrder` enum('ASC','DESC') DEFAULT 'ASC',
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Fork` (
  `id` char(22) NOT NULL DEFAULT '',
  `userId` char(22) DEFAULT NULL,
  `groupId` char(22) DEFAULT NULL,
  `status` longtext DEFAULT NULL,
  `error` text DEFAULT NULL,
  `startTime` bigint(20) DEFAULT NULL,
  `endTime` bigint(20) DEFAULT NULL,
  `finished` tinyint(1) DEFAULT 0,
  `latch` tinyint(1) DEFAULT 0,
  `redirect` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Gallery` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `groupIdAddComment` char(22) binary DEFAULT NULL,
  `groupIdAddFile` char(22) binary DEFAULT NULL,
  `imageResolutions` text DEFAULT NULL,
  `imageViewSize` int(11) DEFAULT NULL,
  `imageThumbnailSize` int(11) DEFAULT NULL,
  `maxSpacePerUser` char(20) DEFAULT NULL,
  `richEditIdComment` char(22) binary DEFAULT NULL,
  `templateIdAddArchive` char(22) binary DEFAULT NULL,
  `templateIdDeleteAlbum` char(22) binary DEFAULT NULL,
  `templateIdDeleteFile` char(22) binary DEFAULT NULL,
  `templateIdEditAlbum` char(22) binary DEFAULT NULL,
  `templateIdEditFile` char(22) binary DEFAULT NULL,
  `templateIdListAlbums` char(22) binary DEFAULT NULL,
  `templateIdListAlbumsRss` char(22) binary DEFAULT NULL,
  `templateIdListFilesForUser` char(22) binary DEFAULT NULL,
  `templateIdListFilesForUserRss` char(22) binary DEFAULT NULL,
  `templateIdMakeShortcut` char(22) binary DEFAULT NULL,
  `templateIdSearch` char(22) binary DEFAULT NULL,
  `templateIdViewSlideshow` char(22) binary DEFAULT NULL,
  `templateIdViewThumbnails` char(22) binary DEFAULT NULL,
  `templateIdViewAlbum` char(22) binary DEFAULT NULL,
  `templateIdViewAlbumRss` char(22) binary DEFAULT NULL,
  `templateIdViewFile` char(22) binary DEFAULT NULL,
  `viewAlbumAssetId` char(22) binary DEFAULT NULL,
  `viewDefault` enum('album','list') DEFAULT NULL,
  `viewListOrderBy` char(40) DEFAULT NULL,
  `viewListOrderDirection` enum('ASC','DESC') DEFAULT NULL,
  `workflowIdCommit` char(22) binary DEFAULT NULL,
  `templateIdEditComment` char(22) binary DEFAULT NULL,
  `richEditIdAlbum` char(22) binary DEFAULT NULL,
  `richEditIdFile` char(22) binary DEFAULT NULL,
  `defaultFilesPerPage` int(11) DEFAULT NULL,
  `imageDensity` int(11) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `GalleryAlbum` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `allowComments` int(11) DEFAULT NULL,
  `assetIdThumbnail` char(22) binary DEFAULT NULL,
  `userDefined1` text DEFAULT NULL,
  `userDefined2` text DEFAULT NULL,
  `userDefined3` text DEFAULT NULL,
  `userDefined4` text DEFAULT NULL,
  `userDefined5` text DEFAULT NULL,
  `othersCanAdd` int(11) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `GalleryFile` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `userDefined1` longtext DEFAULT NULL,
  `userDefined2` longtext DEFAULT NULL,
  `userDefined3` longtext DEFAULT NULL,
  `userDefined4` longtext DEFAULT NULL,
  `userDefined5` longtext DEFAULT NULL,
  `views` bigint(20) DEFAULT 0,
  `friendsOnly` int(1) DEFAULT 0,
  `rating` int(1) DEFAULT 0,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `GalleryFile_comment` (
  `assetId` char(22) binary NOT NULL,
  `commentId` char(22) binary NOT NULL,
  `userId` char(22) binary DEFAULT NULL,
  `visitorIp` char(255) DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `bodyText` longtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`commentId`),
  KEY `commentId` (`commentId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `HttpProxy` (
  `proxiedUrl` text DEFAULT NULL,
  `timeout` int(11) DEFAULT NULL,
  `removeStyle` int(11) DEFAULT NULL,
  `filterHtml` char(30) DEFAULT NULL,
  `followExternal` int(11) DEFAULT NULL,
  `followRedirect` int(11) DEFAULT NULL,
  `cacheHttp` int(11) DEFAULT 0,
  `useCache` int(11) DEFAULT 0,
  `debug` int(11) DEFAULT 0,
  `rewriteUrls` int(11) DEFAULT NULL,
  `searchFor` char(255) DEFAULT NULL,
  `stopAt` char(255) DEFAULT NULL,
  `cookieJarStorageId` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `cacheTimeout` int(11) NOT NULL DEFAULT 0,
  `useAmpersand` int(11) NOT NULL DEFAULT 0,
  `urlPatternFilter` mediumtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `ImageAsset` (
  `assetId` char(22) binary NOT NULL,
  `thumbnailSize` int(11) NOT NULL DEFAULT 50,
  `parameters` text DEFAULT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `annotations` mediumtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `InOutBoard` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `statusList` text DEFAULT NULL,
  `reportViewerGroup` char(22) binary NOT NULL DEFAULT '3',
  `inOutGroup` char(22) binary NOT NULL DEFAULT '2',
  `inOutTemplateId` char(22) binary NOT NULL DEFAULT 'IOB0000000000000000001',
  `reportTemplateId` char(22) binary NOT NULL DEFAULT 'IOB0000000000000000002',
  `paginateAfter` int(11) NOT NULL DEFAULT 50,
  `reportPaginateAfter` int(11) NOT NULL DEFAULT 50,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `InOutBoard_delegates` (
  `userId` char(22) binary NOT NULL,
  `delegateUserId` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `InOutBoard_status` (
  `assetId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  `status` char(255) DEFAULT NULL,
  `dateStamp` int(11) NOT NULL,
  `message` text DEFAULT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `InOutBoard_statusLog` (
  `assetId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  `status` char(255) DEFAULT NULL,
  `dateStamp` int(11) NOT NULL,
  `message` text DEFAULT NULL,
  `createdBy` char(22) binary DEFAULT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Layout` (
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `contentPositions` text DEFAULT NULL,
  `assetsToHide` text DEFAULT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `assetOrder` char(20) DEFAULT 'asc',
  `mobileTemplateId` char(22) binary DEFAULT 'PBtmpl0000000000000054',
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Map` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `groupIdAddPoint` char(22) binary DEFAULT NULL,
  `mapApiKey` text DEFAULT NULL,
  `mapHeight` char(12) DEFAULT NULL,
  `mapWidth` char(12) DEFAULT NULL,
  `startLatitude` float DEFAULT NULL,
  `startLongitude` float DEFAULT NULL,
  `startZoom` tinyint(3) unsigned DEFAULT NULL,
  `templateIdEditPoint` char(22) binary DEFAULT NULL,
  `templateIdView` char(22) binary DEFAULT NULL,
  `templateIdViewPoint` char(22) binary DEFAULT NULL,
  `workflowIdPoint` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `MapPoint` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `website` char(255) DEFAULT NULL,
  `address1` char(255) DEFAULT NULL,
  `address2` char(255) DEFAULT NULL,
  `city` char(255) DEFAULT NULL,
  `region` char(255) DEFAULT NULL,
  `zipCode` char(255) DEFAULT NULL,
  `country` char(255) DEFAULT NULL,
  `phone` char(255) DEFAULT NULL,
  `fax` char(255) DEFAULT NULL,
  `email` char(255) DEFAULT NULL,
  `storageIdPhoto` char(22) binary DEFAULT NULL,
  `userDefined1` char(255) DEFAULT NULL,
  `userDefined2` char(255) DEFAULT NULL,
  `userDefined3` char(255) DEFAULT NULL,
  `userDefined4` char(255) DEFAULT NULL,
  `userDefined5` char(255) DEFAULT NULL,
  `isGeocoded` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Matrix` (
  `detailTemplateId` char(22) binary DEFAULT NULL,
  `compareTemplateId` char(22) binary DEFAULT NULL,
  `searchTemplateId` char(22) binary DEFAULT NULL,
  `categories` text DEFAULT NULL,
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `maxComparisons` int(11) NOT NULL DEFAULT 10,
  `maxComparisonsPrivileged` int(11) NOT NULL DEFAULT 10,
  `defaultSort` char(22) binary NOT NULL DEFAULT 'score',
  `compareColorNo` char(22) binary DEFAULT '#ffaaaa',
  `compareColorLimited` char(22) binary NOT NULL DEFAULT '#ffffaa',
  `compareColorCostsExtra` char(22) binary NOT NULL DEFAULT '#ffffaa',
  `compareColorFreeAddOn` char(22) binary NOT NULL DEFAULT '#ffffaa',
  `compareColorYes` char(22) binary NOT NULL DEFAULT '#aaffaa',
  `submissionApprovalWorkflowId` char(22) binary NOT NULL,
  `ratingsDuration` int(11) NOT NULL DEFAULT 7776000,
  `editListingTemplateId` char(22) binary DEFAULT NULL,
  `groupToAdd` char(22) binary DEFAULT '2',
  `screenshotsConfigTemplateId` char(22) binary DEFAULT NULL,
  `screenshotsTemplateId` char(22) binary DEFAULT NULL,
  `statisticsCacheTimeout` int(11) NOT NULL DEFAULT 3600,
  `maxScreenshotWidth` int(11) DEFAULT NULL,
  `maxScreenshotHeight` int(11) DEFAULT NULL,
  `listingsCacheTimeout` int(11) NOT NULL DEFAULT 3600,
  `maxComparisonsGroup` char(22) binary DEFAULT NULL,
  `maxComparisonsGroupInt` int(11) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `MatrixListing` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `screenshots` char(22) binary DEFAULT NULL,
  `description` text DEFAULT NULL,
  `version` char(255) DEFAULT NULL,
  `views` int(11) DEFAULT NULL,
  `compares` int(11) DEFAULT NULL,
  `clicks` int(11) DEFAULT NULL,
  `viewsLastIp` char(255) DEFAULT NULL,
  `comparesLastIp` char(255) DEFAULT NULL,
  `clicksLastIp` char(255) DEFAULT NULL,
  `lastUpdated` int(11) DEFAULT NULL,
  `maintainer` char(22) binary DEFAULT NULL,
  `manufacturerName` char(255) DEFAULT NULL,
  `manufacturerURL` char(255) DEFAULT NULL,
  `productURL` char(255) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `MatrixListing_attribute` (
  `matrixId` char(22) binary NOT NULL,
  `matrixListingId` char(22) binary NOT NULL,
  `attributeId` char(22) binary NOT NULL,
  `value` char(255) DEFAULT NULL,
  PRIMARY KEY (`attributeId`,`matrixListingId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `MatrixListing_rating` (
  `timeStamp` int(11) NOT NULL DEFAULT 0,
  `category` char(255) DEFAULT NULL,
  `rating` int(11) NOT NULL DEFAULT 1,
  `listingId` char(22) binary NOT NULL,
  `ipAddress` char(15) DEFAULT NULL,
  `assetId` char(22) binary NOT NULL,
  `userId` char(22) binary DEFAULT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `MatrixListing_ratingSummary` (
  `listingId` char(22) binary NOT NULL,
  `category` char(255) NOT NULL,
  `meanValue` decimal(3,2) DEFAULT NULL,
  `medianValue` int(11) DEFAULT NULL,
  `countValue` int(11) DEFAULT NULL,
  `assetId` char(22) binary NOT NULL,
  PRIMARY KEY (`listingId`,`category`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Matrix_attribute` (
  `attributeId` char(22) binary NOT NULL,
  `category` char(255) NOT NULL,
  `name` char(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `fieldType` char(255) NOT NULL DEFAULT 'MatrixCompare',
  `defaultValue` char(255) DEFAULT NULL,
  `assetId` char(22) binary NOT NULL,
  `options` text DEFAULT NULL,
  PRIMARY KEY (`attributeId`),
  KEY `categoryIndex` (`category`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `MessageBoard` (
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `visitorCacheTimeout` int(11) NOT NULL DEFAULT 3600,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `MultiSearch` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `templateId` char(22) binary NOT NULL DEFAULT 'MultiSearchTmpl0000001',
  `predefinedSearches` text DEFAULT NULL,
  `cacheTimeout` int(11) NOT NULL DEFAULT 3600,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Navigation` (
  `assetId` char(22) binary NOT NULL,
  `assetsToInclude` text DEFAULT NULL,
  `startType` char(35) DEFAULT NULL,
  `startPoint` char(255) DEFAULT NULL,
  `descendantEndPoint` int(11) NOT NULL DEFAULT 55,
  `showSystemPages` int(11) NOT NULL DEFAULT 0,
  `showHiddenPages` int(11) NOT NULL DEFAULT 0,
  `showUnprivilegedPages` int(11) NOT NULL DEFAULT 0,
  `templateId` char(22) binary NOT NULL,
  `ancestorEndPoint` int(11) NOT NULL DEFAULT 55,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `mimeType` char(50) DEFAULT 'text/html',
  `reversePageLoop` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Newsletter` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `newsletterTemplateId` char(22) binary NOT NULL DEFAULT 'newsletter000000000001',
  `mySubscriptionsTemplateId` char(22) binary NOT NULL DEFAULT 'newslettersubscrip0001',
  `newsletterHeader` mediumtext DEFAULT NULL,
  `newsletterFooter` mediumtext DEFAULT NULL,
  `newsletterCategories` text DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Newsletter_subscriptions` (
  `assetId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  `subscriptions` text DEFAULT NULL,
  `lastTimeSent` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`assetId`,`userId`),
  KEY `lastTimeSent_assetId_userId` (`lastTimeSent`,`assetId`,`userId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `PA_lastLog` (
  `userId` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `sessionId` char(22) binary NOT NULL,
  `timeStamp` bigint(20) DEFAULT NULL,
  `url` char(255) NOT NULL,
  PRIMARY KEY (`userId`,`sessionId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `PM_project` (
  `projectId` char(22) binary NOT NULL,
  `assetId` char(22) binary DEFAULT NULL,
  `name` char(255) NOT NULL,
  `description` text DEFAULT NULL,
  `startDate` bigint(20) DEFAULT NULL,
  `endDate` bigint(20) DEFAULT NULL,
  `projectManager` char(22) binary DEFAULT NULL,
  `durationUnits` enum('hours','days') DEFAULT 'hours',
  `hoursPerDay` float DEFAULT NULL,
  `targetBudget` float(15,2) DEFAULT 0.00,
  `percentComplete` float NOT NULL DEFAULT 0,
  `parentId` char(22) binary DEFAULT NULL,
  `creationDate` bigint(20) NOT NULL,
  `createdBy` char(22) binary NOT NULL,
  `lastUpdatedBy` char(22) binary NOT NULL,
  `lastUpdateDate` bigint(20) NOT NULL,
  `projectObserver` char(22) binary DEFAULT '7',
  PRIMARY KEY (`projectId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `PM_task` (
  `taskId` char(22) binary NOT NULL,
  `projectId` char(22) binary NOT NULL,
  `taskName` char(255) NOT NULL,
  `duration` float DEFAULT NULL,
  `startDate` bigint(20) DEFAULT NULL,
  `endDate` bigint(20) DEFAULT NULL,
  `dependants` char(50) DEFAULT NULL,
  `parentId` char(22) binary DEFAULT NULL,
  `percentComplete` float DEFAULT NULL,
  `sequenceNumber` int(11) NOT NULL DEFAULT 1,
  `creationDate` bigint(20) NOT NULL,
  `createdBy` char(22) binary NOT NULL,
  `lastUpdatedBy` char(22) binary NOT NULL,
  `lastUpdateDate` bigint(20) NOT NULL,
  `lagTime` bigint(20) DEFAULT 0,
  `taskType` enum('timed','progressive','milestone') NOT NULL DEFAULT 'timed',
  PRIMARY KEY (`taskId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `PM_taskResource` (
  `taskResourceId` char(22) binary NOT NULL,
  `taskId` char(22) binary NOT NULL,
  `sequenceNumber` int(11) NOT NULL,
  `resourceKind` enum('user','group') NOT NULL,
  `resourceId` char(22) binary NOT NULL,
  PRIMARY KEY (`taskResourceId`),
  UNIQUE KEY `taskId` (`taskId`,`resourceKind`,`resourceId`),
  UNIQUE KEY `taskId_2` (`taskId`,`sequenceNumber`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `PM_wobject` (
  `assetId` char(22) binary NOT NULL,
  `projectDashboardTemplateId` char(22) binary NOT NULL DEFAULT 'ProjectManagerTMPL0001',
  `projectDisplayTemplateId` char(22) binary NOT NULL DEFAULT 'ProjectManagerTMPL0002',
  `ganttChartTemplateId` char(22) binary NOT NULL DEFAULT 'ProjectManagerTMPL0003',
  `editTaskTemplateId` char(22) binary NOT NULL DEFAULT 'ProjectManagerTMPL0004',
  `groupToAdd` char(22) binary NOT NULL DEFAULT '3',
  `revisionDate` bigint(20) NOT NULL,
  `resourcePopupTemplateId` char(22) binary NOT NULL DEFAULT 'ProjectManagerTMPL0005',
  `resourceListTemplateId` char(22) binary NOT NULL DEFAULT 'ProjectManagerTMPL0006',
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Photo` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `exifData` longtext DEFAULT NULL,
  `location` char(255) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Photo_rating` (
  `assetId` char(22) binary NOT NULL,
  `userId` char(22) binary DEFAULT NULL,
  `visitorIp` char(255) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  KEY `assetId` (`assetId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Poll` (
  `active` int(11) NOT NULL DEFAULT 1,
  `graphWidth` int(11) NOT NULL DEFAULT 150,
  `voteGroup` char(22) binary DEFAULT NULL,
  `question` char(255) DEFAULT NULL,
  `a1` char(255) DEFAULT NULL,
  `a2` char(255) DEFAULT NULL,
  `a3` char(255) DEFAULT NULL,
  `a4` char(255) DEFAULT NULL,
  `a5` char(255) DEFAULT NULL,
  `a6` char(255) DEFAULT NULL,
  `a7` char(255) DEFAULT NULL,
  `a8` char(255) DEFAULT NULL,
  `a9` char(255) DEFAULT NULL,
  `a10` char(255) DEFAULT NULL,
  `a11` char(255) DEFAULT NULL,
  `a12` char(255) DEFAULT NULL,
  `a13` char(255) DEFAULT NULL,
  `a14` char(255) DEFAULT NULL,
  `a15` char(255) DEFAULT NULL,
  `a16` char(255) DEFAULT NULL,
  `a17` char(255) DEFAULT NULL,
  `a18` char(255) DEFAULT NULL,
  `a19` char(255) DEFAULT NULL,
  `a20` char(255) DEFAULT NULL,
  `karmaPerVote` int(11) NOT NULL DEFAULT 0,
  `randomizeAnswers` int(11) NOT NULL DEFAULT 0,
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `graphConfiguration` blob DEFAULT NULL,
  `generateGraph` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Poll_answer` (
  `answer` char(3) DEFAULT NULL,
  `userId` char(22) binary NOT NULL,
  `ipAddress` char(50) DEFAULT NULL,
  `assetId` char(22) binary NOT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Post` (
  `assetId` char(22) binary NOT NULL,
  `threadId` char(22) binary NOT NULL,
  `username` char(30) DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `views` int(11) NOT NULL DEFAULT 0,
  `contentType` char(35) NOT NULL DEFAULT 'mixed',
  `userDefined1` text DEFAULT NULL,
  `userDefined2` text DEFAULT NULL,
  `userDefined3` text DEFAULT NULL,
  `userDefined4` text DEFAULT NULL,
  `userDefined5` text DEFAULT NULL,
  `storageId` char(22) binary NOT NULL,
  `rating` int(11) NOT NULL DEFAULT 0,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `originalEmail` mediumtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`),
  KEY `threadId_rating` (`threadId`,`rating`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Post_rating` (
  `assetId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  `ipAddress` char(15) NOT NULL,
  `dateOfRating` bigint(20) DEFAULT NULL,
  `rating` int(11) NOT NULL DEFAULT 0,
  KEY `assetId_userId` (`assetId`,`userId`),
  KEY `assetId_ipAddress` (`assetId`,`ipAddress`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Product` (
  `image1` char(255) DEFAULT NULL,
  `image2` char(255) DEFAULT NULL,
  `image3` char(255) DEFAULT NULL,
  `brochure` char(255) DEFAULT NULL,
  `manual` char(255) DEFAULT NULL,
  `warranty` char(255) DEFAULT NULL,
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `cacheTimeout` int(11) NOT NULL DEFAULT 3600,
  `thankYouMessage` mediumtext DEFAULT NULL,
  `accessoryJSON` longtext DEFAULT NULL,
  `benefitJSON` longtext DEFAULT NULL,
  `featureJSON` longtext DEFAULT NULL,
  `relatedJSON` longtext DEFAULT NULL,
  `specificationJSON` longtext DEFAULT NULL,
  `variantsJSON` longtext DEFAULT NULL,
  `isShippingRequired` int(11) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `RichEdit` (
  `assetId` char(22) binary NOT NULL,
  `askAboutRichEdit` int(11) NOT NULL DEFAULT 0,
  `preformatted` int(11) NOT NULL DEFAULT 0,
  `editorWidth` int(11) NOT NULL DEFAULT 0,
  `editorHeight` int(11) NOT NULL DEFAULT 0,
  `sourceEditorWidth` int(11) NOT NULL DEFAULT 0,
  `sourceEditorHeight` int(11) NOT NULL DEFAULT 0,
  `useBr` int(11) NOT NULL DEFAULT 0,
  `nowrap` int(11) NOT NULL DEFAULT 0,
  `removeLineBreaks` int(11) NOT NULL DEFAULT 0,
  `npwrap` int(11) NOT NULL DEFAULT 0,
  `directionality` char(3) NOT NULL DEFAULT 'ltr',
  `toolbarLocation` char(6) NOT NULL DEFAULT 'bottom',
  `cssFile` char(255) DEFAULT NULL,
  `validElements` mediumtext DEFAULT NULL,
  `toolbarRow1` text DEFAULT NULL,
  `toolbarRow2` text DEFAULT NULL,
  `toolbarRow3` text DEFAULT NULL,
  `enableContextMenu` int(11) NOT NULL DEFAULT 0,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `disableRichEditor` int(11) DEFAULT 0,
  `inlinePopups` int(11) NOT NULL DEFAULT 0,
  `allowMedia` int(11) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `SQLReport` (
  `dbQuery1` text DEFAULT NULL,
  `paginateAfter` int(11) NOT NULL DEFAULT 50,
  `preprocessMacros1` int(11) DEFAULT 0,
  `debugMode` int(11) NOT NULL DEFAULT 0,
  `databaseLinkId1` char(22) binary NOT NULL,
  `placeholderParams1` text DEFAULT NULL,
  `preprocessMacros2` int(11) DEFAULT 0,
  `dbQuery2` text DEFAULT NULL,
  `placeholderParams2` text DEFAULT NULL,
  `databaseLinkId2` char(22) binary NOT NULL,
  `preprocessMacros3` int(11) DEFAULT 0,
  `dbQuery3` text DEFAULT NULL,
  `placeholderParams3` text DEFAULT NULL,
  `databaseLinkId3` char(22) binary NOT NULL,
  `preprocessMacros4` int(11) DEFAULT 0,
  `dbQuery4` text DEFAULT NULL,
  `placeholderParams4` text DEFAULT NULL,
  `databaseLinkId4` char(22) binary NOT NULL,
  `preprocessMacros5` int(11) DEFAULT 0,
  `dbQuery5` text DEFAULT NULL,
  `placeholderParams5` text DEFAULT NULL,
  `databaseLinkId5` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `cacheTimeout` int(11) NOT NULL DEFAULT 0,
  `prequeryStatements1` text DEFAULT NULL,
  `prequeryStatements2` text DEFAULT NULL,
  `prequeryStatements3` text DEFAULT NULL,
  `prequeryStatements4` text DEFAULT NULL,
  `prequeryStatements5` text DEFAULT NULL,
  `downloadType` char(255) DEFAULT NULL,
  `downloadFilename` char(255) DEFAULT NULL,
  `downloadTemplateId` char(22) binary DEFAULT NULL,
  `downloadMimeType` char(255) DEFAULT NULL,
  `downloadUserGroup` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Shelf` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `templateId` char(22) binary NOT NULL DEFAULT 'nFen0xjkZn8WkpM93C9ceQ',
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Shortcut` (
  `overrideTitle` int(11) NOT NULL DEFAULT 0,
  `overrideDescription` int(11) NOT NULL DEFAULT 0,
  `overrideTemplate` int(11) NOT NULL DEFAULT 0,
  `overrideDisplayTitle` int(11) NOT NULL DEFAULT 0,
  `overrideTemplateId` char(22) binary NOT NULL,
  `shortcutByCriteria` int(11) NOT NULL DEFAULT 0,
  `resolveMultiples` char(30) DEFAULT 'mostRecent',
  `shortcutCriteria` text NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `shortcutToAssetId` char(22) binary NOT NULL,
  `disableContentLock` int(11) NOT NULL DEFAULT 0,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `prefFieldsToShow` text DEFAULT NULL,
  `prefFieldsToImport` text DEFAULT NULL,
  `showReloadIcon` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Shortcut_overrides` (
  `assetId` char(22) binary NOT NULL,
  `fieldName` char(255) NOT NULL,
  `newValue` text DEFAULT NULL,
  PRIMARY KEY (`assetId`,`fieldName`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `StockData` (
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL DEFAULT 'StockListTMPL000000001',
  `displayTemplateId` char(22) binary NOT NULL DEFAULT 'StockListTMPL000000002',
  `defaultStocks` text DEFAULT NULL,
  `source` char(50) DEFAULT 'usa',
  `failover` int(11) DEFAULT 1,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `cacheTimeout` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Story` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `headline` char(255) DEFAULT NULL,
  `subtitle` char(255) DEFAULT NULL,
  `byline` char(255) DEFAULT NULL,
  `location` char(255) DEFAULT NULL,
  `highlights` text DEFAULT NULL,
  `story` mediumtext DEFAULT NULL,
  `photo` longtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `StoryArchive` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `storiesPerPage` int(11) DEFAULT NULL,
  `groupToPost` char(22) binary DEFAULT NULL,
  `templateId` char(22) binary DEFAULT NULL,
  `storyTemplateId` char(22) binary DEFAULT NULL,
  `editStoryTemplateId` char(22) binary DEFAULT NULL,
  `keywordListTemplateId` char(22) binary DEFAULT NULL,
  `archiveAfter` int(11) DEFAULT NULL,
  `richEditorId` char(22) binary DEFAULT NULL,
  `approvalWorkflowId` char(22) binary DEFAULT 'pbworkflow000000000003',
  `photoWidth` int(11) DEFAULT NULL,
  `storySortOrder` char(22) DEFAULT NULL,
  `photoHeight` int(11) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `StoryTopic` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `storiesPer` int(11) DEFAULT NULL,
  `storiesShort` int(11) DEFAULT NULL,
  `templateId` char(22) binary DEFAULT NULL,
  `storyTemplateId` char(22) binary DEFAULT NULL,
  `storySortOrder` char(22) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Subscription` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `thankYouMessage` mediumtext DEFAULT NULL,
  `price` float NOT NULL DEFAULT 0,
  `subscriptionGroup` char(22) binary NOT NULL DEFAULT '2',
  `duration` char(12) NOT NULL DEFAULT 'Monthly',
  `executeOnSubscription` char(255) DEFAULT NULL,
  `karma` int(6) DEFAULT 0,
  `recurringSubscription` tinyint(1) NOT NULL DEFAULT 1,
  `redeemSubscriptionCodeTemplateId` char(22) binary NOT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Subscription_code` (
  `code` char(64) NOT NULL,
  `batchId` char(22) binary NOT NULL,
  `status` char(10) NOT NULL DEFAULT 'Unused',
  `dateUsed` bigint(20) DEFAULT NULL,
  `usedBy` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Subscription_codeBatch` (
  `batchId` char(22) binary NOT NULL,
  `name` char(255) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `subscriptionId` char(22) binary NOT NULL,
  `expirationDate` bigint(20) NOT NULL,
  `dateCreated` bigint(20) NOT NULL,
  PRIMARY KEY (`batchId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Survey` (
  `groupToTakeSurvey` char(22) binary NOT NULL DEFAULT '2',
  `groupToEditSurvey` char(22) binary NOT NULL DEFAULT '3',
  `groupToViewReports` char(22) binary NOT NULL DEFAULT '3',
  `overviewTemplateId` char(22) binary NOT NULL,
  `maxResponsesPerUser` int(11) NOT NULL DEFAULT 1,
  `gradebookTemplateId` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `surveyEditTemplateId` char(22) binary DEFAULT NULL,
  `answerEditTemplateId` char(22) binary DEFAULT NULL,
  `questionEditTemplateId` char(22) binary DEFAULT NULL,
  `sectionEditTemplateId` char(22) binary DEFAULT NULL,
  `surveyTakeTemplateId` char(22) binary DEFAULT NULL,
  `surveyQuestionsId` char(22) binary DEFAULT NULL,
  `exitURL` text DEFAULT NULL,
  `surveyJSON` longtext DEFAULT NULL,
  `timeLimit` mediumint(8) unsigned NOT NULL,
  `showProgress` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `showTimeLimit` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `doAfterTimeLimit` char(22) binary DEFAULT NULL,
  `onSurveyEndWorkflowId` char(22) binary DEFAULT NULL,
  `quizModeSummary` tinyint(3) DEFAULT NULL,
  `surveySummaryTemplateId` char(22) binary DEFAULT NULL,
  `allowBackBtn` tinyint(3) DEFAULT NULL,
  `feedbackTemplateId` char(22) binary DEFAULT NULL,
  `testResultsTemplateId` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Survey_questionTypes` (
  `questionType` char(56) NOT NULL,
  `answers` text NOT NULL,
  PRIMARY KEY (`questionType`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Survey_response` (
  `assetId` char(22) binary NOT NULL,
  `Survey_responseId` char(22) binary NOT NULL,
  `userId` char(22) binary DEFAULT NULL,
  `username` char(255) DEFAULT NULL,
  `ipAddress` char(15) DEFAULT NULL,
  `startDate` bigint(20) NOT NULL DEFAULT 0,
  `endDate` bigint(20) NOT NULL DEFAULT 0,
  `isComplete` int(11) NOT NULL DEFAULT 0,
  `anonId` char(255) DEFAULT NULL,
  `responseJSON` longtext DEFAULT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Survey_responseId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Survey_tempReport` (
  `assetId` char(22) binary NOT NULL,
  `Survey_responseId` char(22) binary NOT NULL,
  `order` smallint(5) unsigned NOT NULL,
  `sectionNumber` smallint(5) unsigned NOT NULL,
  `sectionName` text DEFAULT NULL,
  `questionNumber` smallint(5) unsigned NOT NULL,
  `questionName` text DEFAULT NULL,
  `questionComment` mediumtext DEFAULT NULL,
  `answerNumber` smallint(5) unsigned DEFAULT NULL,
  `answerValue` mediumtext DEFAULT NULL,
  `answerComment` mediumtext DEFAULT NULL,
  `entryDate` bigint(20) unsigned NOT NULL COMMENT 'UTC Unix Time',
  `isCorrect` tinyint(3) unsigned DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `fileStoreageId` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`assetId`,`Survey_responseId`,`order`),
  KEY `assetId` (`assetId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Survey_test` (
  `testId` char(22) binary NOT NULL,
  `sequenceNumber` int(11) NOT NULL DEFAULT 1,
  `dateCreated` datetime DEFAULT NULL,
  `lastUpdated` datetime DEFAULT NULL,
  `assetId` char(255) DEFAULT NULL,
  `name` char(255) DEFAULT NULL,
  `test` mediumtext NOT NULL,
  PRIMARY KEY (`testId`),
  KEY `assetId` (`assetId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `SyndicatedContent` (
  `rssUrl` text DEFAULT NULL,
  `maxHeadlines` int(11) NOT NULL DEFAULT 0,
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `hasTerms` char(255) NOT NULL,
  `cacheTimeout` int(11) NOT NULL DEFAULT 3600,
  `processMacroInRssUrl` int(11) DEFAULT 0,
  `sortItems` char(255) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `TT_projectList` (
  `projectId` char(22) binary NOT NULL,
  `assetId` char(22) binary DEFAULT NULL,
  `projectName` char(255) NOT NULL,
  `creationDate` bigint(20) NOT NULL,
  `createdBy` char(22) binary NOT NULL,
  `lastUpdatedBy` char(22) binary NOT NULL,
  `lastUpdateDate` bigint(20) NOT NULL,
  PRIMARY KEY (`projectId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `TT_projectResourceList` (
  `projectId` char(22) binary NOT NULL,
  `resourceId` char(22) binary NOT NULL,
  PRIMARY KEY (`projectId`,`resourceId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `TT_projectTasks` (
  `taskId` char(22) binary NOT NULL,
  `projectId` char(22) binary NOT NULL,
  `taskName` char(255) NOT NULL,
  PRIMARY KEY (`taskId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `TT_report` (
  `reportId` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `startDate` char(10) NOT NULL,
  `endDate` char(10) NOT NULL,
  `reportComplete` int(11) NOT NULL DEFAULT 0,
  `resourceId` char(22) binary NOT NULL,
  `creationDate` bigint(20) NOT NULL,
  `createdBy` char(22) binary NOT NULL,
  `lastUpdatedBy` char(22) binary NOT NULL,
  `lastUpdateDate` bigint(20) NOT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `TT_timeEntry` (
  `entryId` char(22) binary NOT NULL,
  `projectId` char(22) binary NOT NULL,
  `taskId` char(22) binary NOT NULL,
  `taskDate` char(10) NOT NULL,
  `hours` float DEFAULT 0,
  `comments` text DEFAULT NULL,
  `reportId` char(22) binary NOT NULL,
  PRIMARY KEY (`entryId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `TT_wobject` (
  `assetId` char(22) binary NOT NULL,
  `userViewTemplateId` char(22) binary NOT NULL DEFAULT 'TimeTrackingTMPL000001',
  `managerViewTemplateId` char(22) binary NOT NULL DEFAULT 'TimeTrackingTMPL000002',
  `timeRowTemplateId` char(22) binary NOT NULL DEFAULT 'TimeTrackingTMPL000003',
  `pmAssetId` char(22) binary DEFAULT NULL,
  `groupToManage` char(22) binary NOT NULL DEFAULT '3',
  `revisionDate` bigint(20) NOT NULL,
  `pmIntegration` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Thingy` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `defaultThingId` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `ThingyRecord` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `templateIdView` char(22) binary DEFAULT NULL,
  `thingId` char(22) binary DEFAULT NULL,
  `thingFields` longtext DEFAULT NULL,
  `thankYouText` longtext DEFAULT NULL,
  `price` float DEFAULT NULL,
  `duration` bigint(20) DEFAULT NULL,
  `fieldPrice` longtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `ThingyRecord_record` (
  `recordId` char(22) binary NOT NULL,
  `sequenceNumber` int(11) NOT NULL DEFAULT 1,
  `dateCreated` datetime DEFAULT NULL,
  `lastUpdated` datetime DEFAULT NULL,
  `transactionId` char(255) DEFAULT NULL,
  `assetId` char(255) DEFAULT NULL,
  `expires` bigint(20) NOT NULL DEFAULT 0,
  `userId` char(255) DEFAULT NULL,
  `fields` longtext DEFAULT NULL,
  `isHidden` tinyint(1) NOT NULL DEFAULT 0,
  `sentExpiresNotice` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`recordId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Thingy_fields` (
  `assetId` char(22) binary NOT NULL,
  `thingId` char(22) binary NOT NULL,
  `fieldId` char(22) binary NOT NULL,
  `sequenceNumber` int(11) NOT NULL,
  `dateCreated` bigint(20) NOT NULL,
  `createdBy` char(22) binary NOT NULL,
  `dateUpdated` bigint(20) NOT NULL,
  `updatedBy` char(22) binary NOT NULL,
  `label` char(255) NOT NULL,
  `fieldType` char(255) NOT NULL,
  `defaultValue` longtext DEFAULT NULL,
  `possibleValues` text DEFAULT NULL,
  `subtext` char(255) DEFAULT NULL,
  `status` char(255) NOT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `vertical` smallint(1) DEFAULT NULL,
  `extras` char(255) DEFAULT NULL,
  `display` int(11) DEFAULT NULL,
  `viewScreenTitle` int(11) DEFAULT NULL,
  `displayInSearch` int(11) DEFAULT NULL,
  `searchIn` int(11) DEFAULT NULL,
  `fieldInOtherThingId` char(22) binary DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `pretext` char(255) DEFAULT NULL,
  `isUnique` int(1) DEFAULT 0,
  PRIMARY KEY (`fieldId`,`thingId`,`assetId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Thingy_things` (
  `assetId` char(22) binary NOT NULL,
  `thingId` char(22) binary NOT NULL,
  `label` char(255) NOT NULL,
  `editScreenTitle` char(255) NOT NULL,
  `editInstructions` text DEFAULT NULL,
  `groupIdAdd` char(22) binary NOT NULL,
  `groupIdEdit` char(22) binary NOT NULL,
  `saveButtonLabel` char(255) NOT NULL,
  `afterSave` char(255) NOT NULL,
  `editTemplateId` char(22) binary NOT NULL,
  `onAddWorkflowId` char(22) binary DEFAULT NULL,
  `onEditWorkflowId` char(22) binary DEFAULT NULL,
  `onDeleteWorkflowId` char(22) binary DEFAULT NULL,
  `groupIdView` char(22) binary NOT NULL,
  `viewTemplateId` char(22) binary NOT NULL,
  `defaultView` char(255) NOT NULL,
  `searchScreenTitle` char(255) NOT NULL,
  `searchDescription` text DEFAULT NULL,
  `groupIdSearch` char(22) binary NOT NULL,
  `groupIdImport` char(22) binary NOT NULL,
  `groupIdExport` char(22) binary NOT NULL,
  `searchTemplateId` char(22) binary NOT NULL,
  `thingsPerPage` int(11) NOT NULL DEFAULT 25,
  `sortBy` char(22) binary DEFAULT NULL,
  `display` int(11) DEFAULT NULL,
  `exportMetaData` int(11) DEFAULT NULL,
  `maxEntriesPerUser` int(11) DEFAULT NULL,
  `maxEntriesTotal` int(11) DEFAULT NULL,
  PRIMARY KEY (`thingId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Thread` (
  `assetId` char(22) binary NOT NULL,
  `replies` int(11) NOT NULL DEFAULT 0,
  `lastPostId` char(22) binary NOT NULL,
  `lastPostDate` bigint(20) DEFAULT NULL,
  `isLocked` int(11) NOT NULL DEFAULT 0,
  `isSticky` int(11) NOT NULL DEFAULT 0,
  `subscriptionGroupId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `karma` int(11) NOT NULL DEFAULT 0,
  `karmaScale` int(11) NOT NULL DEFAULT 1,
  `karmaRank` float(11,6) DEFAULT NULL,
  `threadRating` int(11) DEFAULT 0,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Thread_read` (
  `threadId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  KEY `threadId_userId` (`threadId`,`userId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `UserList` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `templateId` char(22) binary DEFAULT NULL,
  `showGroupId` char(22) binary DEFAULT NULL,
  `hideGroupId` char(22) binary DEFAULT NULL,
  `usersPerPage` int(11) DEFAULT NULL,
  `alphabet` text DEFAULT NULL,
  `alphabetSearchField` char(128) DEFAULT NULL,
  `showOnlyVisibleAsNamed` int(11) DEFAULT NULL,
  `sortBy` char(128) DEFAULT NULL,
  `sortOrder` char(4) DEFAULT NULL,
  `overridePublicEmail` int(11) DEFAULT NULL,
  `overridePublicProfile` int(11) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `WeatherData` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) unsigned NOT NULL DEFAULT 0,
  `templateId` char(22) binary NOT NULL DEFAULT 'WeatherDataTmpl0000001',
  `locations` text DEFAULT NULL,
  `partnerId` char(100) DEFAULT NULL,
  `licenseKey` char(100) DEFAULT NULL,
  `cacheTimeout` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `WikiMaster` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `groupToEditPages` char(22) binary NOT NULL DEFAULT '2',
  `groupToAdminister` char(22) binary NOT NULL DEFAULT '3',
  `richEditor` char(22) binary NOT NULL DEFAULT 'PBrichedit000000000002',
  `frontPageTemplateId` char(22) binary NOT NULL DEFAULT 'WikiFrontTmpl000000001',
  `pageTemplateId` char(22) binary NOT NULL DEFAULT 'WikiPageTmpl0000000001',
  `pageEditTemplateId` char(22) binary NOT NULL DEFAULT 'WikiPageEditTmpl000001',
  `recentChangesTemplateId` char(22) binary NOT NULL DEFAULT 'WikiRCTmpl000000000001',
  `mostPopularTemplateId` char(22) binary NOT NULL DEFAULT 'WikiMPTmpl000000000001',
  `pageHistoryTemplateId` char(22) binary NOT NULL DEFAULT 'WikiPHTmpl000000000001',
  `searchTemplateId` char(22) binary NOT NULL DEFAULT 'WikiSearchTmpl00000001',
  `recentChangesCount` int(11) NOT NULL DEFAULT 50,
  `recentChangesCountFront` int(11) NOT NULL DEFAULT 10,
  `mostPopularCount` int(11) NOT NULL DEFAULT 50,
  `mostPopularCountFront` int(11) NOT NULL DEFAULT 10,
  `thumbnailSize` int(11) NOT NULL DEFAULT 0,
  `maxImageSize` int(11) NOT NULL DEFAULT 0,
  `approvalWorkflow` char(22) binary NOT NULL DEFAULT 'pbworkflow000000000003',
  `useContentFilter` int(11) DEFAULT 0,
  `filterCode` char(30) DEFAULT 'javascript',
  `byKeywordTemplateId` char(22) binary NOT NULL DEFAULT 'WikiKeyword00000000001',
  `allowAttachments` int(11) NOT NULL DEFAULT 0,
  `topLevelKeywords` longtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `WikiMasterKeywords` (
  `assetId` char(22) binary NOT NULL,
  `keyword` char(64) NOT NULL,
  `subKeyword` char(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`assetId`,`keyword`,`subKeyword`),
  KEY `assetId` (`assetId`),
  KEY `keyword` (`keyword`),
  KEY `subKeyword` (`subKeyword`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `WikiPage` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `content` mediumtext DEFAULT NULL,
  `views` bigint(20) NOT NULL DEFAULT 0,
  `isProtected` int(11) NOT NULL DEFAULT 0,
  `actionTaken` char(35) NOT NULL,
  `actionTakenBy` char(22) binary NOT NULL,
  `isFeatured` int(1) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `Workflow` (
  `workflowId` char(22) binary NOT NULL,
  `title` char(255) NOT NULL DEFAULT 'Untitled',
  `description` text DEFAULT NULL,
  `enabled` int(11) NOT NULL DEFAULT 0,
  `type` char(255) NOT NULL DEFAULT 'None',
  `mode` char(20) NOT NULL DEFAULT 'parallel',
  PRIMARY KEY (`workflowId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `WorkflowActivity` (
  `activityId` char(22) binary NOT NULL,
  `workflowId` char(22) binary NOT NULL,
  `title` char(255) NOT NULL DEFAULT 'Untitled',
  `description` text DEFAULT NULL,
  `sequenceNumber` int(11) NOT NULL DEFAULT 1,
  `className` char(255) DEFAULT NULL,
  PRIMARY KEY (`activityId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `WorkflowActivityData` (
  `activityId` char(22) binary NOT NULL,
  `name` char(255) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`activityId`,`name`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `WorkflowInstance` (
  `instanceId` char(22) binary NOT NULL,
  `workflowId` char(22) binary NOT NULL,
  `currentActivityId` char(22) binary NOT NULL,
  `priority` int(11) NOT NULL DEFAULT 2,
  `className` char(255) DEFAULT NULL,
  `methodName` char(255) DEFAULT NULL,
  `parameters` longtext DEFAULT NULL,
  `runningSince` bigint(20) DEFAULT NULL,
  `lastUpdate` bigint(20) DEFAULT NULL,
  `lastStatus` char(15) DEFAULT NULL,
  `noSession` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`instanceId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `WorkflowInstanceScratch` (
  `instanceId` char(22) binary NOT NULL,
  `name` char(255) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`instanceId`,`name`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `WorkflowSchedule` (
  `taskId` char(22) binary NOT NULL,
  `title` char(255) NOT NULL DEFAULT 'Untitled',
  `enabled` int(11) NOT NULL DEFAULT 0,
  `runOnce` int(11) NOT NULL DEFAULT 0,
  `minuteOfHour` char(255) NOT NULL DEFAULT '0',
  `hourOfDay` char(255) NOT NULL DEFAULT '*',
  `dayOfMonth` char(255) NOT NULL DEFAULT '*',
  `monthOfYear` char(255) NOT NULL DEFAULT '*',
  `dayOfWeek` char(255) NOT NULL DEFAULT '*',
  `workflowId` char(22) binary NOT NULL,
  `className` char(255) DEFAULT NULL,
  `methodName` char(255) DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT 2,
  `parameters` longtext DEFAULT NULL,
  PRIMARY KEY (`taskId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `ZipArchiveAsset` (
  `assetId` char(22) binary NOT NULL,
  `templateId` char(22) binary NOT NULL,
  `showPage` char(255) NOT NULL DEFAULT 'index.html',
  `revisionDate` bigint(20) NOT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `adSkuPurchase` (
  `adSkuPurchaseId` char(22) binary NOT NULL,
  `sequenceNumber` int(11) NOT NULL DEFAULT 1,
  `dateCreated` datetime DEFAULT NULL,
  `lastUpdated` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `clicksPurchased` bigint(20) DEFAULT NULL,
  `dateOfPurchase` bigint(20) DEFAULT NULL,
  `impressionsPurchased` bigint(20) DEFAULT NULL,
  `transactionItemId` char(22) binary DEFAULT NULL,
  `userId` char(22) binary DEFAULT NULL,
  `adId` char(22) binary DEFAULT NULL,
  `storedImage` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`adSkuPurchaseId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `adSpace` (
  `adSpaceId` char(22) binary NOT NULL,
  `name` char(35) NOT NULL,
  `title` char(255) NOT NULL,
  `description` text DEFAULT NULL,
  `minimumImpressions` int(11) NOT NULL DEFAULT 1000,
  `minimumClicks` int(11) NOT NULL DEFAULT 1000,
  `width` int(11) NOT NULL DEFAULT 468,
  `height` int(11) NOT NULL DEFAULT 60,
  PRIMARY KEY (`adSpaceId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `address` (
  `addressId` char(22) binary NOT NULL,
  `addressBookId` char(22) binary NOT NULL,
  `label` char(35) DEFAULT NULL,
  `firstName` char(35) DEFAULT NULL,
  `lastName` char(35) DEFAULT NULL,
  `address1` char(35) DEFAULT NULL,
  `address2` char(35) DEFAULT NULL,
  `address3` char(35) DEFAULT NULL,
  `city` char(35) DEFAULT NULL,
  `state` char(35) DEFAULT NULL,
  `country` char(35) DEFAULT NULL,
  `code` char(35) DEFAULT NULL,
  `phoneNumber` char(35) DEFAULT NULL,
  `organization` char(255) DEFAULT NULL,
  `email` char(255) DEFAULT NULL,
  `isProfile` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`addressId`),
  KEY `addressBookId_addressId` (`addressBookId`,`addressId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `addressBook` (
  `addressBookId` char(22) binary NOT NULL,
  `userId` char(22) binary DEFAULT NULL,
  `defaultAddressId` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`addressBookId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `advertisement` (
  `adId` char(22) binary NOT NULL,
  `adSpaceId` char(22) binary NOT NULL,
  `ownerUserId` char(22) binary NOT NULL,
  `isActive` int(11) NOT NULL DEFAULT 0,
  `title` char(255) NOT NULL,
  `type` char(15) NOT NULL DEFAULT 'text',
  `storageId` char(22) binary DEFAULT NULL,
  `adText` char(255) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `richMedia` text DEFAULT NULL,
  `borderColor` char(7) NOT NULL DEFAULT '#000000',
  `textColor` char(7) NOT NULL DEFAULT '#000000',
  `backgroundColor` char(7) NOT NULL DEFAULT '#ffffff',
  `clicks` int(11) NOT NULL DEFAULT 0,
  `clicksBought` int(11) NOT NULL DEFAULT 0,
  `impressions` int(11) NOT NULL DEFAULT 0,
  `impressionsBought` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) NOT NULL DEFAULT 0,
  `nextInPriority` bigint(20) NOT NULL DEFAULT 0,
  `renderedAd` text DEFAULT NULL,
  PRIMARY KEY (`adId`),
  KEY `adSpaceId_isActive` (`adSpaceId`,`isActive`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `analyticRule` (
  `ruleId` char(22) binary NOT NULL,
  `sequenceNumber` int(11) NOT NULL DEFAULT 1,
  `dateCreated` datetime DEFAULT NULL,
  `lastUpdated` datetime DEFAULT NULL,
  `bucketName` char(255) DEFAULT NULL,
  `regexp` char(255) NOT NULL DEFAULT '.+',
  PRIMARY KEY (`ruleId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `asset` (
  `assetId` char(22) binary NOT NULL,
  `parentId` char(22) binary NOT NULL,
  `lineage` char(255) NOT NULL,
  `state` char(35) NOT NULL,
  `className` char(255) NOT NULL,
  `creationDate` bigint(20) NOT NULL DEFAULT 997995720,
  `createdBy` char(22) binary NOT NULL DEFAULT '3',
  `stateChanged` char(22) binary NOT NULL DEFAULT '997995720',
  `stateChangedBy` char(22) binary NOT NULL DEFAULT '3',
  `isLockedBy` char(22) binary DEFAULT NULL,
  `isSystem` int(11) NOT NULL DEFAULT 0,
  `lastExportedAs` char(255) DEFAULT NULL,
  PRIMARY KEY (`assetId`),
  UNIQUE KEY `lineage` (`lineage`),
  KEY `parentId` (`parentId`),
  KEY `state_parentId_lineage` (`state`,`parentId`,`lineage`),
  KEY `isPrototype_className_assetId` (`className`,`assetId`),
  KEY `className_assetId_state` (`className`,`assetId`,`state`),
  KEY `state_lineage` (`state`,`lineage`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `assetAspectComments` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `comments` longtext DEFAULT NULL,
  `averageCommentRating` int(11) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `assetAspectRssFeed` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `itemsPerFeed` int(11) DEFAULT 25,
  `feedCopyright` text DEFAULT NULL,
  `feedTitle` text DEFAULT NULL,
  `feedDescription` mediumtext DEFAULT NULL,
  `feedImage` char(22) binary DEFAULT NULL,
  `feedImageLink` text DEFAULT NULL,
  `feedImageDescription` mediumtext DEFAULT NULL,
  `feedHeaderLinks` char(32) DEFAULT 'rss\natom',
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `assetAspect_Subscribable` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `subscriptionGroupId` char(22) binary DEFAULT NULL,
  `subscriptionTemplateId` char(22) binary DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `assetData` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `revisedBy` char(22) binary NOT NULL,
  `tagId` char(22) binary NOT NULL,
  `status` char(35) NOT NULL DEFAULT 'pending',
  `title` char(255) NOT NULL DEFAULT 'untitled',
  `menuTitle` char(255) NOT NULL DEFAULT 'untitled',
  `url` char(255) NOT NULL,
  `ownerUserId` char(22) binary NOT NULL,
  `groupIdView` char(22) binary NOT NULL,
  `groupIdEdit` char(22) binary NOT NULL,
  `synopsis` text DEFAULT NULL,
  `newWindow` int(11) NOT NULL DEFAULT 0,
  `isHidden` int(11) NOT NULL DEFAULT 0,
  `isPackage` int(11) NOT NULL DEFAULT 0,
  `isPrototype` int(11) NOT NULL DEFAULT 0,
  `encryptPage` int(11) NOT NULL DEFAULT 0,
  `assetSize` int(11) NOT NULL DEFAULT 0,
  `extraHeadTags` text DEFAULT NULL,
  `skipNotification` int(11) NOT NULL DEFAULT 0,
  `isExportable` int(11) NOT NULL DEFAULT 1,
  `inheritUrlFromParent` int(11) NOT NULL DEFAULT 0,
  `lastModified` bigint(20) DEFAULT NULL,
  `extraHeadTagsPacked` longtext DEFAULT NULL,
  `usePackedHeadTags` int(1) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`),
  KEY `assetId_url` (`assetId`,`url`),
  KEY `assetId_revisionDate_status_tagId` (`assetId`,`revisionDate`,`status`,`tagId`),
  KEY `url` (`url`),
  KEY `assetId_status_tagId_revisionDate` (`assetId`,`status`,`tagId`,`revisionDate`),
  KEY `assetId_status` (`assetId`,`status`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `assetHistory` (
  `assetId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  `dateStamp` bigint(20) NOT NULL DEFAULT 0,
  `actionTaken` char(255) NOT NULL,
  `url` char(255) DEFAULT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `assetIndex` (
  `assetId` char(22) binary NOT NULL,
  `title` char(255) DEFAULT NULL,
  `synopsis` text DEFAULT NULL,
  `url` char(255) NOT NULL DEFAULT '',
  `creationDate` bigint(20) DEFAULT NULL,
  `revisionDate` bigint(20) DEFAULT NULL,
  `ownerUserId` char(22) binary DEFAULT NULL,
  `groupIdView` char(22) binary DEFAULT NULL,
  `groupIdEdit` char(22) binary DEFAULT NULL,
  `className` char(255) DEFAULT NULL,
  `isPublic` int(11) NOT NULL DEFAULT 1,
  `keywords` mediumtext DEFAULT NULL,
  `lineage` char(255) DEFAULT NULL,
  `subId` char(255) binary DEFAULT NULL,
  PRIMARY KEY (`assetId`,`url`),
  FULLTEXT KEY `keywords` (`keywords`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `assetKeyword` (
  `keyword` char(64) NOT NULL,
  `assetId` char(22) binary NOT NULL,
  PRIMARY KEY (`keyword`,`assetId`),
  KEY `keyword` (`keyword`),
  KEY `assetId` (`assetId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `assetVersionTag` (
  `tagId` char(22) binary NOT NULL,
  `name` char(255) NOT NULL,
  `isCommitted` int(11) NOT NULL DEFAULT 0,
  `creationDate` bigint(20) NOT NULL DEFAULT 0,
  `createdBy` char(22) binary NOT NULL,
  `commitDate` bigint(20) NOT NULL DEFAULT 0,
  `committedBy` char(22) binary NOT NULL,
  `isLocked` int(11) NOT NULL DEFAULT 0,
  `lockedBy` char(22) binary NOT NULL,
  `groupToUse` char(22) binary NOT NULL,
  `workflowId` char(22) binary NOT NULL,
  `workflowInstanceId` char(22) binary DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `isSiteWide` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`tagId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `authentication` (
  `userId` char(22) binary NOT NULL,
  `authMethod` char(30) NOT NULL,
  `fieldName` char(128) NOT NULL,
  `fieldData` text DEFAULT NULL,
  PRIMARY KEY (`userId`,`authMethod`,`fieldName`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `bucketLog` (
  `userId` char(22) binary NOT NULL,
  `Bucket` char(255) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `timeStamp` datetime DEFAULT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `cache` (
  `namespace` char(128) NOT NULL,
  `cachekey` char(128) NOT NULL,
  `expires` bigint(20) NOT NULL,
  `size` int(11) NOT NULL,
  `content` mediumblob DEFAULT NULL,
  PRIMARY KEY (`namespace`,`cachekey`),
  KEY `namespace_cachekey_size` (`namespace`,`cachekey`,`expires`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `cart` (
  `cartId` char(22) binary NOT NULL,
  `sessionId` char(22) binary NOT NULL,
  `shippingAddressId` char(22) binary DEFAULT NULL,
  `shipperId` char(22) binary DEFAULT NULL,
  `posUserId` char(22) binary DEFAULT NULL,
  `creationDate` int(20) DEFAULT NULL,
  `billingAddressId` char(22) DEFAULT NULL,
  `gatewayId` char(22) DEFAULT NULL,
  PRIMARY KEY (`cartId`),
  KEY `sessionId` (`sessionId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `cartItem` (
  `itemId` char(22) binary NOT NULL,
  `cartId` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `dateAdded` datetime NOT NULL,
  `options` longtext DEFAULT NULL,
  `configuredTitle` char(255) DEFAULT NULL,
  `shippingAddressId` char(22) binary DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`itemId`),
  KEY `cartId_assetId_dateAdded` (`cartId`,`assetId`,`dateAdded`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `databaseLink` (
  `databaseLinkId` char(22) binary NOT NULL,
  `title` char(255) DEFAULT NULL,
  `DSN` char(255) DEFAULT NULL,
  `username` char(255) DEFAULT NULL,
  `identifier` char(255) DEFAULT NULL,
  `allowedKeywords` text DEFAULT NULL,
  `allowMacroAccess` int(11) NOT NULL DEFAULT 0,
  `additionalParameters` char(255) NOT NULL,
  PRIMARY KEY (`databaseLinkId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `deltaLog` (
  `userId` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `delta` int(11) DEFAULT NULL,
  `timeStamp` bigint(20) DEFAULT NULL,
  `url` char(255) NOT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `donation` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `defaultPrice` float NOT NULL DEFAULT 100,
  `thankYouMessage` mediumtext DEFAULT NULL,
  `templateId` char(22) binary NOT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `filePumpBundle` (
  `bundleId` char(22) binary NOT NULL,
  `sequenceNumber` int(11) NOT NULL DEFAULT 1,
  `dateCreated` datetime DEFAULT NULL,
  `lastUpdated` datetime DEFAULT NULL,
  `bundleName` char(255) NOT NULL DEFAULT 'New bundle',
  `lastModified` bigint(20) NOT NULL DEFAULT 0,
  `lastBuild` bigint(20) NOT NULL DEFAULT 0,
  `jsFiles` longtext NOT NULL,
  `cssFiles` longtext NOT NULL,
  `otherFiles` longtext NOT NULL,
  PRIMARY KEY (`bundleId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `friendInvitations` (
  `inviteId` char(22) binary NOT NULL,
  `inviterId` char(22) binary NOT NULL,
  `friendId` char(22) binary NOT NULL,
  `dateSent` datetime NOT NULL,
  `comments` char(255) NOT NULL,
  `messageId` char(22) binary NOT NULL,
  PRIMARY KEY (`inviteId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `groupGroupings` (
  `groupId` char(22) binary NOT NULL,
  `inGroup` char(22) binary NOT NULL,
  PRIMARY KEY (`groupId`,`inGroup`),
  KEY `inGroup` (`inGroup`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `groupings` (
  `groupId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  `expireDate` bigint(20) NOT NULL DEFAULT 2114402400,
  `groupAdmin` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`groupId`,`userId`),
  KEY `userId` (`userId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `groups` (
  `groupId` char(22) binary NOT NULL,
  `groupName` char(100) DEFAULT NULL,
  `description` char(255) DEFAULT NULL,
  `expireOffset` int(11) NOT NULL DEFAULT 314496000,
  `karmaThreshold` int(11) NOT NULL DEFAULT 1000000000,
  `ipFilter` text DEFAULT NULL,
  `dateCreated` int(11) NOT NULL DEFAULT 997938000,
  `lastUpdated` int(11) NOT NULL DEFAULT 997938000,
  `deleteOffset` int(11) NOT NULL DEFAULT 14,
  `expireNotifyOffset` int(11) NOT NULL DEFAULT -14,
  `expireNotifyMessage` text DEFAULT NULL,
  `expireNotify` int(11) NOT NULL DEFAULT 0,
  `scratchFilter` text DEFAULT NULL,
  `autoAdd` int(11) NOT NULL DEFAULT 0,
  `autoDelete` int(11) NOT NULL DEFAULT 0,
  `databaseLinkId` char(22) binary NOT NULL,
  `groupCacheTimeout` int(11) NOT NULL DEFAULT 3600,
  `dbQuery` text DEFAULT NULL,
  `isEditable` int(11) NOT NULL DEFAULT 1,
  `showInForms` int(11) NOT NULL DEFAULT 1,
  `ldapGroup` char(255) DEFAULT NULL,
  `ldapGroupProperty` char(255) DEFAULT NULL,
  `ldapRecursiveProperty` char(255) DEFAULT NULL,
  `ldapLinkId` char(22) binary DEFAULT NULL,
  `ldapRecursiveFilter` mediumtext DEFAULT NULL,
  `isAdHocMailGroup` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`groupId`),
  KEY `groupName` (`groupName`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `imageColor` (
  `colorId` char(22) binary NOT NULL,
  `name` char(255) NOT NULL DEFAULT 'untitled',
  `fillTriplet` char(7) NOT NULL DEFAULT '#000000',
  `fillAlpha` char(2) NOT NULL DEFAULT '00',
  `strokeTriplet` char(7) NOT NULL DEFAULT '#000000',
  `strokeAlpha` char(2) NOT NULL DEFAULT '00',
  PRIMARY KEY (`colorId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `imageFont` (
  `fontId` char(22) binary NOT NULL,
  `name` char(255) DEFAULT NULL,
  `storageId` char(22) binary DEFAULT NULL,
  `filename` char(255) DEFAULT NULL,
  PRIMARY KEY (`fontId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `imagePalette` (
  `paletteId` char(22) binary NOT NULL,
  `name` char(255) NOT NULL DEFAULT 'untitled',
  PRIMARY KEY (`paletteId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `imagePaletteColors` (
  `paletteId` char(22) binary NOT NULL,
  `colorId` char(22) binary NOT NULL,
  `paletteOrder` int(11) NOT NULL,
  PRIMARY KEY (`paletteId`,`paletteOrder`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `inbox` (
  `messageId` char(22) binary NOT NULL,
  `status` char(15) NOT NULL DEFAULT 'pending',
  `dateStamp` bigint(20) NOT NULL,
  `completedOn` bigint(20) DEFAULT NULL,
  `completedBy` char(22) binary DEFAULT NULL,
  `userId` char(22) binary DEFAULT NULL,
  `groupId` char(22) binary DEFAULT NULL,
  `subject` char(255) NOT NULL DEFAULT 'No Subject',
  `message` mediumtext DEFAULT NULL,
  `sentBy` char(22) binary NOT NULL DEFAULT '3',
  PRIMARY KEY (`messageId`),
  KEY `completedOn_dateStamp` (`completedOn`,`dateStamp`),
  KEY `pb_userId` (`userId`),
  KEY `pb_groupId` (`groupId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `inbox_messageState` (
  `messageId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  `isRead` tinyint(4) NOT NULL DEFAULT 0,
  `repliedTo` tinyint(4) NOT NULL DEFAULT 0,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`messageId`,`userId`),
  KEY `userId_deleted_isRead` (`userId`,`deleted`,`isRead`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `incrementer` (
  `incrementerId` char(50) NOT NULL,
  `nextValue` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`incrementerId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `karmaLog` (
  `userId` char(22) binary NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 1,
  `source` char(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `dateModified` bigint(20) NOT NULL DEFAULT 0
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `ldapLink` (
  `ldapLinkId` char(22) binary NOT NULL,
  `ldapLinkName` char(255) NOT NULL,
  `ldapUrl` char(255) NOT NULL,
  `connectDn` char(255) NOT NULL,
  `identifier` char(255) NOT NULL,
  `ldapUserRDN` char(255) DEFAULT NULL,
  `ldapIdentity` char(255) DEFAULT NULL,
  `ldapIdentityName` char(255) DEFAULT NULL,
  `ldapPasswordName` char(255) DEFAULT NULL,
  `ldapSendWelcomeMessage` char(2) DEFAULT NULL,
  `ldapWelcomeMessage` text DEFAULT NULL,
  `ldapAccountTemplate` char(22) binary NOT NULL,
  `ldapCreateAccountTemplate` char(22) binary NOT NULL,
  `ldapLoginTemplate` char(22) binary NOT NULL,
  `ldapGlobalRecursiveFilter` mediumtext DEFAULT NULL,
  `ldapDeactivateAccountTemplate` char(22) NOT NULL,
  PRIMARY KEY (`ldapLinkId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `mailQueue` (
  `messageId` char(22) binary NOT NULL,
  `message` mediumtext DEFAULT NULL,
  `toGroup` char(22) binary DEFAULT NULL,
  `isInbox` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`messageId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `metaData_classes` (
  `className` char(255) DEFAULT NULL,
  `fieldId` char(22) DEFAULT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `metaData_properties` (
  `fieldId` char(22) binary NOT NULL,
  `fieldName` char(100) NOT NULL,
  `description` mediumtext NOT NULL,
  `fieldType` char(30) DEFAULT NULL,
  `possibleValues` text DEFAULT NULL,
  `defaultValue` char(255) DEFAULT NULL,
  PRIMARY KEY (`fieldId`),
  UNIQUE KEY `field_unique` (`fieldName`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `metaData_values` (
  `fieldId` char(22) binary NOT NULL,
  `value` char(255) DEFAULT NULL,
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`fieldId`,`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `passiveAnalyticsStatus` (
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `running` int(2) DEFAULT 0,
  `userId` char(255) NOT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `passiveLog` (
  `userId` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `sessionId` char(22) binary NOT NULL,
  `timeStamp` bigint(20) DEFAULT NULL,
  `url` char(255) NOT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `passiveProfileAOI` (
  `userId` char(22) binary NOT NULL,
  `fieldId` char(22) binary NOT NULL,
  `value` char(100) NOT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`userId`,`fieldId`,`value`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `passiveProfileLog` (
  `passiveProfileLogId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  `sessionId` char(22) binary NOT NULL,
  `assetId` char(22) binary NOT NULL,
  `dateOfEntry` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`passiveProfileLogId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `paymentGateway` (
  `paymentGatewayId` char(22) binary NOT NULL,
  `className` char(255) DEFAULT NULL,
  `options` longtext DEFAULT NULL,
  PRIMARY KEY (`paymentGatewayId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `redirect` (
  `assetId` char(22) binary NOT NULL,
  `redirectUrl` text DEFAULT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `redirectType` int(11) NOT NULL DEFAULT 302,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `replacements` (
  `replacementId` char(22) binary NOT NULL,
  `searchFor` char(255) DEFAULT NULL,
  `replaceWith` text DEFAULT NULL,
  PRIMARY KEY (`replacementId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `search` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `classLimiter` text DEFAULT NULL,
  `searchRoot` char(22) binary NOT NULL DEFAULT 'PBasset000000000000001',
  `templateId` char(22) binary NOT NULL DEFAULT 'PBtmpl0000000000000200',
  `useContainers` int(11) NOT NULL DEFAULT 0,
  `paginateAfter` int(11) NOT NULL DEFAULT 25,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `settings` (
  `name` char(255) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `shipper` (
  `shipperId` char(22) binary NOT NULL,
  `className` char(255) DEFAULT NULL,
  `options` longtext DEFAULT NULL,
  PRIMARY KEY (`shipperId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `shopCredit` (
  `creditId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  `amount` float NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `dateOfAdjustment` datetime DEFAULT NULL,
  PRIMARY KEY (`creditId`),
  KEY `userId` (`userId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `sku` (
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `sku` char(35) NOT NULL,
  `vendorId` char(22) binary NOT NULL DEFAULT 'defaultvendor000000000',
  `displayTitle` tinyint(1) NOT NULL DEFAULT 1,
  `overrideTaxRate` tinyint(1) NOT NULL DEFAULT 0,
  `taxRateOverride` float NOT NULL DEFAULT 0,
  `taxConfiguration` longtext DEFAULT NULL,
  `shipsSeparately` tinyint(1) NOT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`),
  KEY `sku` (`sku`),
  KEY `vendorId` (`vendorId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `snippet` (
  `assetId` char(22) binary NOT NULL,
  `snippet` mediumtext DEFAULT NULL,
  `mimeType` char(50) NOT NULL DEFAULT 'text/html',
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `cacheTimeout` int(11) NOT NULL DEFAULT 3600,
  `snippetPacked` longtext DEFAULT NULL,
  `usePacked` int(1) DEFAULT NULL,
  `templateParser` char(255) DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `taxDriver` (
  `className` char(255) NOT NULL,
  `options` longtext DEFAULT NULL,
  PRIMARY KEY (`className`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `tax_eu_vatNumbers` (
  `userId` char(22) binary NOT NULL,
  `countryCode` char(3) NOT NULL,
  `vatNumber` char(20) NOT NULL,
  `viesValidated` tinyint(1) DEFAULT NULL,
  `viesErrorCode` int(3) DEFAULT NULL,
  `approved` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`userId`,`vatNumber`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `tax_generic_rates` (
  `taxId` char(22) binary NOT NULL,
  `country` char(100) NOT NULL,
  `state` char(100) DEFAULT NULL,
  `city` char(100) DEFAULT NULL,
  `code` char(100) DEFAULT NULL,
  `taxRate` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`taxId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `template` (
  `template` mediumtext DEFAULT NULL,
  `namespace` char(35) NOT NULL DEFAULT 'Page',
  `isEditable` int(11) NOT NULL DEFAULT 1,
  `showInForms` int(11) NOT NULL DEFAULT 1,
  `assetId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `parser` char(255) NOT NULL DEFAULT 'WebGUI::Asset::Template::HTMLTemplate',
  `isDefault` int(1) DEFAULT 0,
  `templatePacked` longtext DEFAULT NULL,
  `usePacked` int(1) DEFAULT NULL,
  `storageIdExample` char(22) DEFAULT NULL,
  `attachmentsJson` longtext DEFAULT NULL,
  PRIMARY KEY (`assetId`,`revisionDate`),
  KEY `namespace_showInForms` (`namespace`,`showInForms`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `transaction` (
  `transactionId` char(22) binary NOT NULL,
  `originatingTransactionId` char(22) binary DEFAULT NULL,
  `isSuccessful` tinyint(1) NOT NULL DEFAULT 0,
  `orderNumber` int(11) NOT NULL AUTO_INCREMENT,
  `transactionCode` char(100) DEFAULT NULL,
  `statusCode` char(35) DEFAULT NULL,
  `statusMessage` char(255) DEFAULT NULL,
  `userId` char(22) binary NOT NULL,
  `username` char(35) NOT NULL,
  `amount` float DEFAULT NULL,
  `shopCreditDeduction` float DEFAULT NULL,
  `shippingAddressId` char(22) binary DEFAULT NULL,
  `shippingAddressName` char(35) DEFAULT NULL,
  `shippingAddress1` char(35) DEFAULT NULL,
  `shippingAddress2` char(35) DEFAULT NULL,
  `shippingAddress3` char(35) DEFAULT NULL,
  `shippingCity` char(35) DEFAULT NULL,
  `shippingState` char(35) DEFAULT NULL,
  `shippingCountry` char(35) DEFAULT NULL,
  `shippingCode` char(35) DEFAULT NULL,
  `shippingPhoneNumber` char(35) DEFAULT NULL,
  `shippingDriverId` char(22) binary DEFAULT NULL,
  `shippingDriverLabel` char(35) DEFAULT NULL,
  `shippingPrice` float DEFAULT NULL,
  `paymentAddressId` char(22) binary DEFAULT NULL,
  `paymentAddressName` char(35) DEFAULT NULL,
  `paymentAddress1` char(35) DEFAULT NULL,
  `paymentAddress2` char(35) DEFAULT NULL,
  `paymentAddress3` char(35) DEFAULT NULL,
  `paymentCity` char(35) DEFAULT NULL,
  `paymentState` char(35) DEFAULT NULL,
  `paymentCountry` char(35) DEFAULT NULL,
  `paymentCode` char(35) DEFAULT NULL,
  `paymentPhoneNumber` char(35) DEFAULT NULL,
  `paymentDriverId` char(22) binary DEFAULT NULL,
  `paymentDriverLabel` char(35) DEFAULT NULL,
  `taxes` float DEFAULT NULL,
  `dateOfPurchase` datetime DEFAULT NULL,
  `isRecurring` tinyint(1) DEFAULT NULL,
  `notes` mediumtext DEFAULT NULL,
  `cashierUserId` char(22) binary DEFAULT NULL,
  `shippingOrganization` char(35) DEFAULT NULL,
  `paymentOrganization` char(35) DEFAULT NULL,
  PRIMARY KEY (`transactionId`),
  UNIQUE KEY `orderNumber` (`orderNumber`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `transactionItem` (
  `itemId` char(22) binary NOT NULL,
  `transactionId` char(22) binary NOT NULL,
  `assetId` char(22) binary DEFAULT NULL,
  `configuredTitle` char(255) DEFAULT NULL,
  `options` longtext DEFAULT NULL,
  `shippingAddressId` char(22) binary DEFAULT NULL,
  `shippingName` char(35) DEFAULT NULL,
  `shippingAddress1` char(35) DEFAULT NULL,
  `shippingAddress2` char(35) DEFAULT NULL,
  `shippingAddress3` char(35) DEFAULT NULL,
  `shippingCity` char(35) DEFAULT NULL,
  `shippingState` char(35) DEFAULT NULL,
  `shippingCountry` char(35) DEFAULT NULL,
  `shippingCode` char(35) DEFAULT NULL,
  `shippingPhoneNumber` char(35) DEFAULT NULL,
  `shippingTrackingNumber` char(255) DEFAULT NULL,
  `orderStatus` char(35) NOT NULL DEFAULT 'NotShipped',
  `lastUpdated` datetime DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` float DEFAULT NULL,
  `vendorId` char(22) binary NOT NULL DEFAULT 'defaultvendor000000000',
  `vendorPayoutStatus` char(10) DEFAULT 'NotPaid',
  `vendorPayoutAmount` decimal(8,2) DEFAULT 0.00,
  `taxRate` decimal(6,3) DEFAULT NULL,
  `taxConfiguration` longtext DEFAULT NULL,
  `shippingOrganization` char(35) DEFAULT NULL,
  PRIMARY KEY (`itemId`),
  KEY `transactionId` (`transactionId`),
  KEY `vendorId` (`vendorId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `userInvitations` (
  `inviteId` char(22) binary NOT NULL,
  `userId` char(22) binary NOT NULL,
  `dateSent` date DEFAULT NULL,
  `email` char(255) NOT NULL,
  `newUserId` char(22) binary DEFAULT NULL,
  `dateCreated` date DEFAULT NULL,
  PRIMARY KEY (`inviteId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `userLoginLog` (
  `userId` char(22) binary NOT NULL,
  `status` char(30) DEFAULT NULL,
  `timeStamp` int(11) DEFAULT NULL,
  `ipAddress` char(128) DEFAULT NULL,
  `userAgent` text DEFAULT NULL,
  `sessionId` char(22) binary DEFAULT NULL,
  `lastPageViewed` int(11) DEFAULT NULL,
  KEY `sessionId` (`sessionId`),
  KEY `userId` (`userId`),
  KEY `timeStamp` (`timeStamp`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `userProfileCategory` (
  `profileCategoryId` char(22) binary NOT NULL,
  `label` char(255) NOT NULL DEFAULT 'Undefined',
  `shortLabel` char(255) DEFAULT NULL,
  `sequenceNumber` int(11) NOT NULL DEFAULT 1,
  `visible` int(11) NOT NULL DEFAULT 1,
  `editable` int(11) NOT NULL DEFAULT 1,
  `protected` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`profileCategoryId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `userProfileData` (
  `userId` char(22) binary NOT NULL,
  `email` char(255) DEFAULT NULL,
  `firstName` char(255) DEFAULT NULL,
  `middleName` char(255) DEFAULT NULL,
  `lastName` char(255) DEFAULT NULL,
  `icq` char(255) DEFAULT NULL,
  `aim` char(255) DEFAULT NULL,
  `msnIM` char(255) DEFAULT NULL,
  `yahooIM` char(255) DEFAULT NULL,
  `cellPhone` char(255) DEFAULT NULL,
  `pager` char(255) DEFAULT NULL,
  `emailToPager` char(255) DEFAULT NULL,
  `language` char(255) DEFAULT NULL,
  `homeAddress` char(255) DEFAULT NULL,
  `homeCity` char(255) DEFAULT NULL,
  `homeState` char(255) DEFAULT NULL,
  `homeZip` char(255) DEFAULT NULL,
  `homeCountry` char(255) DEFAULT NULL,
  `homePhone` char(255) DEFAULT NULL,
  `workAddress` char(255) DEFAULT NULL,
  `workCity` char(255) DEFAULT NULL,
  `workState` char(255) DEFAULT NULL,
  `workZip` char(255) DEFAULT NULL,
  `workCountry` char(255) DEFAULT NULL,
  `workPhone` char(255) DEFAULT NULL,
  `gender` char(255) DEFAULT NULL,
  `birthdate` bigint(20) DEFAULT NULL,
  `homeURL` char(255) DEFAULT NULL,
  `workURL` char(255) DEFAULT NULL,
  `workName` char(255) DEFAULT NULL,
  `timeZone` char(255) DEFAULT NULL,
  `dateFormat` char(255) DEFAULT NULL,
  `timeFormat` char(255) DEFAULT NULL,
  `discussionLayout` char(255) DEFAULT NULL,
  `firstDayOfWeek` char(255) DEFAULT NULL,
  `uiLevel` char(255) DEFAULT NULL,
  `alias` char(255) DEFAULT NULL,
  `signature` longtext DEFAULT NULL,
  `publicProfile` longtext DEFAULT NULL,
  `toolbar` char(255) DEFAULT NULL,
  `photo` char(22) binary DEFAULT NULL,
  `avatar` char(22) binary DEFAULT NULL,
  `department` char(255) DEFAULT NULL,
  `allowPrivateMessages` longtext DEFAULT NULL,
  `ableToBeFriend` tinyint(4) DEFAULT NULL,
  `showMessageOnLoginSeen` bigint(20) DEFAULT NULL,
  `showOnline` tinyint(1) DEFAULT NULL,
  `versionTagMode` char(255) DEFAULT NULL,
  `wg_privacySettings` longtext DEFAULT NULL,
  `receiveInboxEmailNotifications` tinyint(1) DEFAULT NULL,
  `receiveInboxSmsNotifications` tinyint(1) DEFAULT NULL,
  `assetManagerSortColumn` char(255) DEFAULT NULL,
  `assetManagerSortDirection` char(255) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  KEY `email` (`email`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `userProfileField` (
  `fieldName` char(128) NOT NULL,
  `label` char(255) NOT NULL DEFAULT 'Undefined',
  `visible` int(11) NOT NULL DEFAULT 0,
  `required` int(11) NOT NULL DEFAULT 0,
  `fieldType` char(128) NOT NULL DEFAULT 'text',
  `possibleValues` text DEFAULT NULL,
  `dataDefault` text DEFAULT NULL,
  `sequenceNumber` int(11) NOT NULL DEFAULT 1,
  `profileCategoryId` char(22) binary NOT NULL,
  `protected` int(11) NOT NULL DEFAULT 0,
  `editable` int(11) NOT NULL DEFAULT 1,
  `forceImageOnly` int(11) DEFAULT 1,
  `showAtRegistration` int(11) NOT NULL DEFAULT 0,
  `requiredForPasswordRecovery` int(11) NOT NULL DEFAULT 0,
  `extras` text DEFAULT NULL,
  `defaultPrivacySetting` char(128) DEFAULT NULL,
  PRIMARY KEY (`fieldName`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `userSession` (
  `sessionId` char(22) binary NOT NULL,
  `expires` int(11) DEFAULT NULL,
  `lastPageView` int(11) DEFAULT NULL,
  `adminOn` int(11) NOT NULL DEFAULT 0,
  `lastIP` char(50) DEFAULT NULL,
  `userId` char(22) binary NOT NULL,
  PRIMARY KEY (`sessionId`),
  KEY `expires` (`expires`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `userSessionScratch` (
  `sessionId` char(22) binary NOT NULL,
  `name` char(255) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`sessionId`,`name`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `users` (
  `userId` char(22) binary NOT NULL,
  `username` char(100) DEFAULT NULL,
  `authMethod` char(30) NOT NULL DEFAULT 'WebGUI',
  `dateCreated` int(11) NOT NULL DEFAULT 1019867418,
  `lastUpdated` int(11) NOT NULL DEFAULT 1019867418,
  `karma` int(11) NOT NULL DEFAULT 0,
  `status` char(35) NOT NULL DEFAULT 'Active',
  `referringAffiliate` char(22) binary NOT NULL,
  `friendsGroup` char(22) binary NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `username_unique` (`username`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `vendor` (
  `vendorId` char(22) binary NOT NULL,
  `dateCreated` datetime DEFAULT NULL,
  `name` char(255) DEFAULT NULL,
  `userId` char(22) binary NOT NULL DEFAULT '3',
  `preferredPaymentType` char(255) DEFAULT NULL,
  `paymentInformation` text DEFAULT NULL,
  `paymentAddressId` char(22) binary DEFAULT NULL,
  `url` text DEFAULT NULL,
  PRIMARY KEY (`vendorId`),
  KEY `userId` (`userId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `vendorPayoutLog` (
  `payoutId` char(22) binary NOT NULL,
  `isSuccessful` tinyint(1) NOT NULL,
  `errorCode` char(10) DEFAULT NULL,
  `errorMessage` char(255) DEFAULT NULL,
  `paypalTimestamp` char(20) NOT NULL,
  `amount` decimal(7,2) NOT NULL,
  `currency` char(3) NOT NULL,
  `correlationId` char(13) NOT NULL,
  `paymentInformation` char(255) NOT NULL,
  PRIMARY KEY (`payoutId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `vendorPayoutLog_items` (
  `payoutId` char(22) binary NOT NULL,
  `transactionItemId` char(22) binary NOT NULL,
  `amount` decimal(7,2) NOT NULL,
  PRIMARY KEY (`payoutId`,`transactionItemId`)
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `webguiVersion` (
  `webguiVersion` char(10) DEFAULT NULL,
  `versionType` char(30) DEFAULT NULL,
  `dateApplied` int(11) DEFAULT NULL
) ENGINE=MyISAM CHARSET=utf8;
CREATE TABLE `wobject` (
  `displayTitle` int(11) NOT NULL DEFAULT 1,
  `description` mediumtext DEFAULT NULL,
  `assetId` char(22) binary NOT NULL,
  `styleTemplateId` char(22) binary NOT NULL,
  `printableStyleTemplateId` char(22) binary NOT NULL,
  `revisionDate` bigint(20) NOT NULL DEFAULT 0,
  `mobileStyleTemplateId` char(22) binary DEFAULT 'PBtmpl0000000000000060',
  PRIMARY KEY (`assetId`,`revisionDate`)
) ENGINE=MyISAM CHARSET=utf8;
/*M!999999\- enable the sandbox mode */ 
