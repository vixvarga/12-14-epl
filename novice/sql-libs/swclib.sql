PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE Works(Work_ID integer, Title text, ISBN text, Date integer, Place text, Publisher text, Edition text, Pages integer);
INSERT INTO "Works" VALUES(1,'SQL in a nutshell','9780596518844',2009,'Sebastopol','O''Reilly','3rd ed.',578);
INSERT INTO "Works" VALUES(2,'SQL for dummies','9781118607961',2013,'Hoboken','Wiley','8th ed.',NULL);
INSERT INTO "Works" VALUES(3,'PHP & MySQL','9781449325572',2013,'Sebastopol','O''Reilly','2nd ed.',532);
INSERT INTO "Works" VALUES(4,'Using SQLite','9780596521189',2010,'Sebastopol','O''Reilly','1st ed.',503);
INSERT INTO "Works" VALUES(5,'Geek sublime','9780571310302',2014,'London','Faber & Faber',NULL,258);
INSERT INTO "Works" VALUES(6,'Capital in the 21st century','9780674430006',2014,'Cambridge','Belknap Press',NULL,685);
INSERT INTO "Works" VALUES(7,'SQL','9780071548649',2009,'New York','McGraw-Hill','3rd ed.',534);
INSERT INTO "Works" VALUES(8,'Discovering SQL','9781118002674',2011,'Indianapolis','Wiley',NULL,400);
INSERT INTO "Works" VALUES(9,'SQL','0321334175',2005,'Berkeley','Peachpit','2nd ed.',460);
INSERT INTO "Works" VALUES(10,'A guide to SQL','9780324597684',2008,'Mason','South-Western','8th ed.',309);
INSERT INTO "Works" VALUES(11,'SQL bible','9780470229064',2008,'Indianapolis','Wiley','2nd ed.',857);
INSERT INTO "Works" VALUES(12,'Learning SQL','9780596520830',2009,'Sebastopol','O''Reilly','2nd ed.',320);
INSERT INTO "Works" VALUES(13,'SQL for dummies','9780470557419',2010,'Hoboken','Wiley','7th ed.',440);
INSERT INTO "Works" VALUES(14,'Beginning SQL queries','9781590599433',2008,'Berkeley','Apress',NULL,218);
INSERT INTO "Works" VALUES(15,'Beginning SQL','0764577328',2005,'Indianapolis','Wiley',NULL,501);
INSERT INTO "Works" VALUES(16,'Microsoft SQL server 2012','9780132977661',2013,'Indianapolis','Sams',NULL,NULL);
INSERT INTO "Works" VALUES(17,'SQL all-in-one','9780470929964',2011,'Hoboken','Wiley','2nd ed.',708);
INSERT INTO "Works" VALUES(18,'Access 2013 all-in-one','9781118510551',2013,'Hoboken','Wiley',NULL,760);
INSERT INTO "Works" VALUES(19,'SQL in a nutshell','0596004818',2004,'Cambridge','O''Reilly','2nd ed.',691);
INSERT INTO "Works" VALUES(20,'MySQL in a nutshell','0596007892',2005,'Sebastopol','O''Reilly','1st ed.',321);
CREATE TABLE Works_Authors(Work_ID integer, Author_ID integer, Role text);
INSERT INTO "Works_Authors" VALUES(1,1,'Author');
INSERT INTO "Works_Authors" VALUES(1,2,'Contributor');
INSERT INTO "Works_Authors" VALUES(1,3,'Contributor');
INSERT INTO "Works_Authors" VALUES(2,4,'Author');
INSERT INTO "Works_Authors" VALUES(3,5,'Author');
INSERT INTO "Works_Authors" VALUES(4,6,'Author');
INSERT INTO "Works_Authors" VALUES(5,7,'Author');
INSERT INTO "Works_Authors" VALUES(6,8,'Author');
INSERT INTO "Works_Authors" VALUES(6,9,'Translator');
INSERT INTO "Works_Authors" VALUES(7,10,'Author');
INSERT INTO "Works_Authors" VALUES(7,11,'Contributor');
INSERT INTO "Works_Authors" VALUES(8,12,'Author');
INSERT INTO "Works_Authors" VALUES(9,13,'Author');
INSERT INTO "Works_Authors" VALUES(10,14,'Author');
INSERT INTO "Works_Authors" VALUES(10,15,'Contributor');
INSERT INTO "Works_Authors" VALUES(11,12,'Author');
INSERT INTO "Works_Authors" VALUES(12,16,'Author');
INSERT INTO "Works_Authors" VALUES(13,4,'Author');
INSERT INTO "Works_Authors" VALUES(14,17,'Author');
INSERT INTO "Works_Authors" VALUES(15,18,'Author');
INSERT INTO "Works_Authors" VALUES(15,19,'Contributor');
INSERT INTO "Works_Authors" VALUES(16,20,'Author');
INSERT INTO "Works_Authors" VALUES(16,1,'Contributor');
INSERT INTO "Works_Authors" VALUES(16,21,'Contributor');
INSERT INTO "Works_Authors" VALUES(17,4,'Author');
INSERT INTO "Works_Authors" VALUES(18,22,'Author');
INSERT INTO "Works_Authors" VALUES(18,23,'Contributor');
INSERT INTO "Works_Authors" VALUES(18,4,'Contributor');
INSERT INTO "Works_Authors" VALUES(19,1,'Author');
INSERT INTO "Works_Authors" VALUES(19,2,'Contributor');
INSERT INTO "Works_Authors" VALUES(19,3,'Contributor');
INSERT INTO "Works_Authors" VALUES(20,24,'Author');
CREATE TABLE Items(Item_ID integer, Work_ID integer, Barcode text, Acquired integer, Status text);
INSERT INTO "Items" VALUES(1,1,'081722942611',2009,'Loaned');
INSERT INTO "Items" VALUES(2,1,'492437609065',2011,'On shelf');
INSERT INTO "Items" VALUES(3,2,'172480710952',2013,'On shelf');
INSERT INTO "Items" VALUES(4,3,'708014968732',2013,'Missing');
INSERT INTO "Items" VALUES(5,3,'819783404942',2014,'Loaned');
INSERT INTO "Items" VALUES(6,4,'257370237291',2010,'Missing');
INSERT INTO "Items" VALUES(7,5,'002905925356',2014,'Loaned');
INSERT INTO "Items" VALUES(8,5,'964583604781',2014,'Loaned');
INSERT INTO "Items" VALUES(9,6,'701630524534',2014,'Loaned');
INSERT INTO "Items" VALUES(10,6,'722040919616',2014,'On shelf');
INSERT INTO "Items" VALUES(11,6,'026655281484',2014,'On shelf');
INSERT INTO "Items" VALUES(12,7,'422970103061',2010,'On shelf');
INSERT INTO "Items" VALUES(13,8,'655280484976',2011,'Loaned');
INSERT INTO "Items" VALUES(14,9,'610721228318',2005,'Missing');
INSERT INTO "Items" VALUES(15,10,'148164881245',2008,'Missing');
INSERT INTO "Items" VALUES(16,10,'445317012796',2010,'On shelf');
INSERT INTO "Items" VALUES(17,11,'291006691199',2008,'On shelf');
INSERT INTO "Items" VALUES(18,12,'665741505651',2009,'On shelf');
INSERT INTO "Items" VALUES(19,12,'623061160016',2009,'Loaned');
INSERT INTO "Items" VALUES(20,13,'827361553957',2010,'On shelf');
INSERT INTO "Items" VALUES(21,13,'228598347653',2010,'Missing');
INSERT INTO "Items" VALUES(22,13,'585952782539',2010,'On shelf');
INSERT INTO "Items" VALUES(23,13,'701532568017',2011,'On shelf');
INSERT INTO "Items" VALUES(24,14,'989297622703',2008,'On shelf');
INSERT INTO "Items" VALUES(25,15,'640793136396',2005,'On shelf');
INSERT INTO "Items" VALUES(26,15,'521089986565',2005,'On shelf');
INSERT INTO "Items" VALUES(27,16,'139685507140',2013,'Loaned');
INSERT INTO "Items" VALUES(28,16,'853183712696',2013,'Loaned');
INSERT INTO "Items" VALUES(29,17,'257153081154',2011,'On shelf');
INSERT INTO "Items" VALUES(30,18,'208546921091',2013,'Loaned');
INSERT INTO "Items" VALUES(31,19,'921664426379',2004,'On shelf');
INSERT INTO "Items" VALUES(32,19,'298308111210',2004,'Loaned');
INSERT INTO "Items" VALUES(33,19,'210139559101',2004,'Missing');
INSERT INTO "Items" VALUES(34,20,'344919897556',2005,'On shelf');
INSERT INTO "Items" VALUES(35,20,'035230397910',2005,'On shelf');
INSERT INTO "Items" VALUES(36,20,'527524003500',2005,'On shelf');
INSERT INTO "Items" VALUES(37,20,'467701665668',2005,'Missing');
INSERT INTO "Items" VALUES(38,20,'082665141572',2005,'On shelf');
INSERT INTO "Items" VALUES(39,20,'273837764866',2006,'Loaned');
INSERT INTO "Items" VALUES(40,20,'582937020090',2006,'On shelf');
CREATE TABLE Authors(Author_ID integer, Family text, Personal text, Occupation text, Birth integer, Death integer);
INSERT INTO "Authors" VALUES(1,'Kline','Kevin E.',NULL,1966,NULL);
INSERT INTO "Authors" VALUES(2,'Kline','Daniel',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(3,'Hunt','Brand',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(4,'Taylor','Allen G.',NULL,1945,NULL);
INSERT INTO "Authors" VALUES(5,'McLaughlin','Brett',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(6,'Kreibich','Jay A.',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(7,'Chandra','Vikram','Writer',1961,NULL);
INSERT INTO "Authors" VALUES(8,'Piketty','Thomas','Economist',1971,NULL);
INSERT INTO "Authors" VALUES(9,'Goldhammer','Arthur',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(10,'Oppel','Andrew J.',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(11,'Sheldon','Robert',NULL,1955,NULL);
INSERT INTO "Authors" VALUES(12,'Kriegel','Alex',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(13,'Fehily','Chris',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(14,'Pratt','Philipp J. ',NULL,1945,NULL);
INSERT INTO "Authors" VALUES(15,'Last','Mary Z.',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(16,'Beaulieu','Alan',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(17,'Churcher','Clare',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(18,'Wilton','Paul',NULL,1969,NULL);
INSERT INTO "Authors" VALUES(19,'Colby','John W.',NULL,1954,NULL);
INSERT INTO "Authors" VALUES(20,'Mistry','Ross',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(21,'Seenarine','Shirmattie',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(22,'Barrows','Alison',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(23,'Stockman','Joseph C.',NULL,NULL,NULL);
INSERT INTO "Authors" VALUES(24,'Dyer','Russel J. T.',NULL,NULL,NULL);
COMMIT;
