--TODO:
--

SPOOL project.out
SET ECHO ON
--
-- Drop pre-existing tables if present.
--
DROP TABLE movie CASCADE CONSTRAINTS;
DROP TABLE person CASCADE CONSTRAINTS;
DROP TABLE production_company CASCADE CONSTRAINTS;
DROP TABLE distributor CASCADE CONSTRAINTS;
DROP TABLE box_office CASCADE CONSTRAINTS;
DROP TABLE roles CASCADE CONSTRAINTS;
DROP TABLE awards CASCADE CONSTRAINTS;
DROP TABLE genre CASCADE CONSTRAINTS;
DROP TABLE works_on CASCADE CONSTRAINTS;
--
-- Create new tables
CREATE TABLE production_company (
  companyName		varchar2(50) PRIMARY KEY,
  yearFounded		number(4),
--
CONSTRAINT pcIC1 CHECK(yearFounded >= 1800 AND yearFounded <= 2017)
);
--
CREATE TABLE movie (
  movieTitle	        varchar2(50) PRIMARY KEY,
  cName			          varchar2(50),
  duration    	      number(4) NOT NULL,
  genre 			        varchar2(50) NOT NULL,
  rating			        number(1),
--
CONSTRAINT mIC1 UNIQUE (movieTitle, cName),
CONSTRAINT mIC2 CHECK (rating IN ('1','2','3','4','5'))	
);
--
CREATE TABLE person (
  personName		varchar2(50) PRIMARY KEY,
  cName			    varchar2(50),
  hDate			    date,
  dateOfBirth    	    date,
  sex		            char(1) NOT NULL,
--
CONSTRAINT pIC1 CHECK (sex IN('m','f')),
CONSTRAINT pIC2 CHECK (dateOfBirth between date '1800-01-01' and date '2017-04-15')
);
--
CREATE TABLE distributor (
  distributorName	   varchar2(50) PRIMARY KEY,
  dateOfFounding     date,
  president          varchar2(50),
  founder            varchar2(50)
--
);
--
CREATE TABLE box_office (
  mTitle	                 varchar2(50) PRIMARY KEY,
  costOfProduction         varchar2(15),
  admissions		           number(15),
  openingWeekendRevenue		 number(15),
  grossProfit	           number(15),
--
CONSTRAINT boIC1 CHECK(openingWeekendRevenue >= 0)
);
--
);
--
CREATE TABLE awards (
  mTitle			varchar2(50) PRIMARY KEY,
  mAward			varchar2(50)
--
);
--
CREATE TABLE genre (
  mTitle 		varchar2(50) PRIMARY KEY,
  mGenre		  varchar2(50)
--	
);
--
CREATE TABLE works_on (
  personName      varchar2(50) PRIMARY KEY,
  movieTitle      varchar2(50),
  primaryRole     varchar2(25)
--
);
--
CREATE TABLE distributes (
  distributorName        varchar2(50) PRIMARY KEY,
  movieTitle            varchar2(50), 
  distributionDate      date,
  distributionMedium    varchar2(20),
  country               varchar2(20) 
--
);
--
-- Adding foreign keys:
ALTER TABLE movie
ADD FOREIGN KEY (cName) REFERENCES production_company (companyName)
Deferrable initially deferred;
--
ALTER TABLE box_office
ADD FOREIGN KEY (mtitle) REFERENCES movie (movieTitle)
Deferrable initially deferred;
--
ALTER TABLE roles
ADD FOREIGN KEY (personName) REFERENCES person (personName)
Deferrable initially deferred;
--
ALTER TABLE awards
ADD FOREIGN KEY (mTitle) REFERENCES movie (movieTitle)
Deferrable initially deferred;
--
ALTER TABLE genre
ADD FOREIGN KEY (mTitle) REFERENCES movie (movieTitle)  
Deferrable initially deferred;
--
-- --------------------------------------------------------------
-- Populate the database
-- --------------------------------------------------------------
--
alter session set NLS_DATE_FORMAT = 'MM/DD/YYYY';
--
--
-- movie inserts
INSERT INTO movie VALUES ('The Wizard of Oz', 'Warner Bros. Pictures', '101','fantasy',5);
INSERT INTO movie VALUES ('Citizen Kane', 'RKO Radio Pictures', '119','action',4);
INSERT INTO movie VALUES ('The Third Man', 'Rialto Pictures', '104','action',5);
INSERT INTO movie VALUES ('MM : Fury Road', 'Warner Bros. Pictures', '120','action',5);
INSERT INTO movie VALUES ('All About Eve', '20th Century Fox', '138','romance',5);
INSERT INTO movie VALUES ('The Cabinet of Dr.Caligari', 'Rialto Pictures', '52','thriller',4);
INSERT INTO movie VALUES ('Inside Out', 'Disney/Pixar', '94','animation',3);
INSERT INTO movie VALUES ('The Godfather', 'Paramount Pictures', '175','action',3);
INSERT INTO movie VALUES ('Metropolis', 'Paramount Pictures', '115','suspense',4);
INSERT INTO movie VALUES ('Get Out', 'Universal Pictures', '104','horror',3);
INSERT INTO movie VALUES ('Modern Times', 'United Artists', '87','suspense',5);
INSERT INTO movie VALUES ('E.T. The Extra-Terrestrial', 'Universal Pictures','114','fantasy',3);
INSERT INTO movie VALUES ('Singin in the Rain', 'MGM', '102','romance',4);
INSERT INTO movie VALUES ('It Happened One Night', 'Sony Pictures Home Entertainment', '105','romance',3);
INSERT INTO movie VALUES ('Casablanca', 'Warner Bros. Pictures', '102','romance',4);
--
-- testing (mIC1)

-- testing (mIC2)
INSERT INTO movie VALUES ('Life', 'Warner Bros. Pictures', '117','romance',8);
--
-- person inserts
INSERT INTO person VALUES('Will Smith','PW Management','10/15/16',43,'m');
INSERT INTO person VALUES('John Smith','PW Management','03/22/14',47,'m');
INSERT INTO person VALUES('Jason Momoa','JR Agencies','01/19/12',39,'m');
INSERT INTO person VALUES('Emma Watson','PW Management','07/25/09',28,'f');
INSERT INTO person VALUES('Abby Hall','JR Agencies','02/04/13',31,'f');
INSERT INTO person VALUES('Seth Rogen','JR Agencies','09/27/15',34,'m');
INSERT INTO person VALUES('Emily Jones','EL Management','09/04/16',42,'f');
INSERT INTO person VALUES('George Mann','EL Management','05/15/12',53,'m');
--
-- testing (pIC1)
INSERT INTO person VALUES('Eli Joseph','EL Management','03/20/11',50,'n');
-- testing (pIC2)
INSERT INTO person VALUES('George Mann','EL Management','05/15/12',-40,'m');
--
-- production company inserts
INSERT INTO production_company VALUES('Warner Bros. Pictures',1923);
INSERT INTO production_company VALUES('RKO Radio Pictures',1928);
INSERT INTO production_company VALUES('Rialto Pictures',1997);
INSERT INTO production_company VALUES('20th Century Fox',1935);
INSERT INTO production_company VALUES('Paramount Pictures',1912);
INSERT INTO production_company VALUES('Disney/Pixar',1986);
INSERT INTO production_company VALUES('Universal Pictures',1912);
INSERT INTO production_company VALUES('United Artists',1919);
INSERT INTO production_company VALUES('MGM',1924);
INSERT INTO production_company VALUES('Sony Pictures Home Entertainment',1991);
--
-- testing (pcIC1)
INSERT INTO movie VALUES('Warner Bros. Pictures',1700)
--
-- distributor inserts
INSERT INTO distributor VALUES('Warner Bros. Pictures',’10/09/95’);
INSERT INTO distributor VALUES('RKO Radio Pictures',’01/24/89’);
INSERT INTO distributor VALUES('Rialto Pictures',’03/12/93’);
INSERT INTO distributor VALUES('20th Century Fox',’07/05/82’);
INSERT INTO distributor VALUES('Paramount Pictures',’11/20/74’);
INSERT INTO distributor VALUES('Disney/Pixar',’12/17/77’);
INSERT INTO distributor VALUES('Universal Pictures',’02/20/88’);
INSERT INTO distributor VALUES('United Artists',’08/24/86’);
INSERT INTO distributor VALUES('MGM',’09/03/97’);
INSERT INTO distributor VALUES('Sony Pictures Home Entertainment',’10/24/03’);
-- testing (IC name)
-- distributes inserts
INSERT INTO distributes VALUES(‘Warner Bros. Pictures’,’The Wizard of Oz’,’10/24/03’,’dvd’,’United States’);
INSERT INTO distributes VALUES(‘RKO Radio Pictures’,’Citizen Kane’,’10/20/04’,’dvd’,’United States’);
INSERT INTO distributes VALUES(‘Rialto Pictures’,’The Third Man’,’07/18/00’,’dvd’,’United States’);
INSERT INTO distributes VALUES(‘20th Century Fox’,’MM Fury Road’,’08/27/06’,’vcr’,’United States’);
INSERT INTO distributes VALUES(‘Paramount Pictures’,’All About Eve’,’04/12/02’,’vcr’,’United States’);
INSERT INTO distributes VALUES(‘Disney/Pixar’,’The Cabinet of Dr. Caligari’,’10/20/99’,’dvd’,’United States’);
INSERT INTO distributes VALUES(‘Universal Pictures’,’Inside Out’,’02/24/05’,’vcr’,’United States’);
--testing (IC name)
-- box office inserts
INSERT INTO box_office VALUES('The Wizard of Oz',4897362,1235986,156872,985634587);
INSERT INTO box_office VALUES('Citizen Kane',1235986,1286475,968725,547862354);
INSERT INTO box_office VALUES('The Third Man',84927489,17854963,123748,234658971);
INSERT INTO box_office VALUES('MM : Fury Road',1726374,1235986,854721,127653892);
INSERT INTO box_office VALUES('All About Eve',1236453,17854963,765843,234856975);
INSERT INTO box_office VALUES('The Cabinet of Dr.Caligari',1829374,1596734,657921,542376854);
INSERT INTO box_office VALUES('Inside Out',1726456,17854963,435678,954723612);
INSERT INTO box_office VALUES('The Godfather',1829476,17854963,349685,124578965);
INSERT INTO box_office VALUES('Metropolis',1728475,1235986,754865,325412578);
INSERT INTO box_office VALUES('Get Out',1827465,17854963,346218,236521452);
INSERT INTO box_office VALUES('Modern Times',1827475,1286475,546231,458756325);
INSERT INTO box_office VALUES('E.T. The Extra-Terrestrial',1728472,17854963,742131,632541258);
INSERT INTO box_office VALUES('Singin in the Rain',1827462,1235986,355684,147896321);
INSERT INTO box_office VALUES('It Happened One Night',1829423,1596734,241322,258967413);
INSERT INTO box_office VALUES('Casablanca',1829423,1286475,235687,563254100);
--
-- testing (boIC1)
INSERT INTO box_office VALUES('Life',1829423,1286475,-235687,563254100);
--
-- works_on inserts
INSERT INTO works_on VALUES(‘Will Smith’,’actor’);
INSERT INTO works_on VALUES(‘John Smith’,’booking agent’);
INSERT INTO works_on VALUES(‘Jason Momoa’,’actor’);
INSERT INTO works_on VALUES(‘Emma Watson’,’actress’);
INSERT INTO works_on VALUES(‘Abby Hall’,’booking agent’);
INSERT INTO works_on VALUES(‘Seth Rogen’,’actor’);
INSERT INTO works_on VALUES(‘Emily Jones’,’director’);
INSERT INTO works_on VALUES(‘George Mann’,’producer’);
-- testing (IC name)
-- awards inserts
INSERT INTO awards VALUES ('The Wizard of Oz','Film of The Year');
INSERT INTO awards VALUES ('Citizen Kane','Academy Award');
INSERT INTO awards VALUES ('The Third Man','Film of The Year');
INSERT INTO awards VALUES ('MM : Fury Road','Academy Award');
INSERT INTO awards VALUES ('All About Eve','Academy Award');
INSERT INTO awards VALUES ('The Cabinet of Dr.Caligari','Film of The Year');
INSERT INTO awards VALUES ('Inside Out','Academy Award');
INSERT INTO awards VALUES ('The Godfather','Film of The Year');
INSERT INTO awards VALUES ('Metropolis','Academy Award');
INSERT INTO awards VALUES ('Get Out','Film of The Year');
INSERT INTO awards VALUES ('Modern Times','Academy Award');
INSERT INTO awards VALUES ('E.T. The Extra-Terrestrial','Film of The Year');
INSERT INTO awards VALUES ('Singin in the Rain','Academy Award');
INSERT INTO awards VALUES ('It Happened One Night','Film of The Year');
INSERT INTO awards VALUES ('Casablanca','Academy Award');
-- testing (IC name)
-- genre inserts
INSERT INTO genre VALUES ('The Wizard of Oz','fantasy');
INSERT INTO genre VALUES ('Citizen Kane','action');
INSERT INTO genre VALUES ('The Third Man','action');
INSERT INTO genre VALUES ('MM : Fury Road','action');
INSERT INTO genre VALUES ('All About Eve','romance');
INSERT INTO genre VALUES ('The Cabinet of Dr.Caligari','thriller');
INSERT INTO genre VALUES ('Inside Out','animation');
INSERT INTO genre VALUES ('The Godfather','action');
INSERT INTO genre VALUES ('Metropolis','suspense');
INSERT INTO genre VALUES ('Get Out','horror');
INSERT INTO genre VALUES ('Modern Times','suspense');
INSERT INTO genre VALUES ('E.T. The Extra-Terrestrial','fantasy');
INSERT INTO genre VALUES ('Singin in the Rain','romance');
INSERT INTO genre VALUES ('It Happened One Night','romance');
INSERT INTO genre VALUES ('Casablanca','romance');
-- testing (IC name)
COMMIT;
