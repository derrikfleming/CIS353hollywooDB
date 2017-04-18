
--TODO: Write a 1 row, 2 attribute Integrity Constraint, and a test for it.
--      Add Values to works_on
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
DROP TABLE awards CASCADE CONSTRAINTS;
DROP TABLE genre CASCADE CONSTRAINTS;
DROP TABLE works_on CASCADE CONSTRAINTS;
DROP TABLE distributes CASCADE CONSTRAINTS;
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
  mTitle	                 varchar2(50),
  costOfProduction         varchar2(15),
  admissions		           number(15),
  openingWeekendRevenue		 number(15),
  grossProfit	           number(15),
  PRIMARY KEY (costOfProduction, mTitle),
--
CONSTRAINT boIC1 CHECK (openingWeekendRevenue >= 0)
--
);
--
CREATE TABLE awards (
  mTitle			varchar2(50),
  mAward			varchar2(50),
  PRIMARY KEY (mTitle, mAward)
--
);
--
CREATE TABLE genre (
  mTitle 		varchar2(50),
  mGenre		  varchar2(50),
  PRIMARY KEY (mTitle, mGenre)
--	
);
--
CREATE TABLE works_on (
  personName      varchar2(50),
  movieTitle      varchar2(50),
  primaryRole     varchar2(25),
  PRIMARY KEY (personName, movieTitle)
--
);
--
CREATE TABLE distributes (
  distributorName        varchar2(50),
  movieTitle            varchar2(50), 
  distributionDate      date,
  distributionMedium    varchar2(20),
  country               varchar2(20),
  PRIMARY KEY (distributorName, movieTitle) 
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
INSERT INTO movie VALUES ('The Wizard of Oz', 'Warner Bros. Pictures', '101',5);
INSERT INTO movie VALUES ('Citizen Kane', 'RKO Radio Pictures', '119', 4);
INSERT INTO movie VALUES ('The Third Man', 'Rialto Pictures', '104', 5);
INSERT INTO movie VALUES ('MM : Fury Road', 'Warner Bros. Pictures', '120', 5);
INSERT INTO movie VALUES ('All About Eve', '20th Century Fox', '138', 5);
INSERT INTO movie VALUES ('The Cabinet of Dr.Caligari', 'Rialto Pictures', '52',4);
INSERT INTO movie VALUES ('Inside Out', 'Disney/Pixar', '94',3);
INSERT INTO movie VALUES ('The Godfather', 'Paramount Pictures', '175',3);
INSERT INTO movie VALUES ('Metropolis', 'Paramount Pictures', '115', 4);
INSERT INTO movie VALUES ('Get Out', 'Universal Pictures', '104', 3);
INSERT INTO movie VALUES ('Modern Times', 'United Artists', '87', 5);
INSERT INTO movie VALUES ('E.T. The Extra-Terrestrial', 'Universal Pictures','114', 3);
INSERT INTO movie VALUES ('Singin in the Rain', 'MGM', '102',4);
INSERT INTO movie VALUES ('It Happened One Night', 'Sony Pictures Home Entertainment', '105',3);
INSERT INTO movie VALUES ('Casablanca', 'Warner Bros. Pictures', '102',4);
INSERT INTO movie VALUES ('Animal House', 'Universal Pictures', '109','comedy',6);
--
-- testing (mIC1)

-- testing (mIC2)
INSERT INTO movie VALUES ('Life', 'Warner Bros. Pictures', '117',8);
--
-- person inserts
INSERT INTO person VALUES('Will Smith','PW Management','10/15/2016','09/25/1968','m');
INSERT INTO person VALUES('John Smith','PW Management','3/22/2014','02/12/1965','m');
INSERT INTO person VALUES('Jason Momoa','JR Agencies','1/19/2012','08/01/1979','m');
INSERT INTO person VALUES('Emma Watson','PW Management','07/05/2009','04/15/1990','f');
INSERT INTO person VALUES('Abby Hall','JR Agencies','02/24/2013','06/14/1987','f');
INSERT INTO person VALUES('Seth Rogen','JR Agencies','09/27/2015','04/15/1982','m');
INSERT INTO person VALUES('Emily Jones','EL Management','09/04/2016','08/01/1977','f');
INSERT INTO person VALUES('George Mann','EL Management','05/15/2012','12/02/1978','m');
INSERT INTO person VALUES('John Belushi','Blues Bros Management','05/15/1978','01/24/1949','m');
INSERT INTO person VALUES('Kevin Bacon','5-0 Management','05/15/2012','12/02/1978','m');
--
-- testing (pIC1)
INSERT INTO person VALUES('Eli Joseph','EL Management','03/20/2011','07/31/1955','n');
-- testing (pIC2)
INSERT INTO person VALUES('Anne Murrica','EL Management','05/15/2012','07/04/1776','f');
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
INSERT INTO production_company VALUES('Warner Bros. Pictures',1700);
--
-- distributor inserts
INSERT INTO distributor VALUES('Warner Bros. Pictures','10/09/95','Kevin Tsujihara','The Warner Bros');
INSERT INTO distributor VALUES('RKO Radio Pictures','01/24/89', 'DEFUNCT', 'Joseph P. Kennedy Sr.');
INSERT INTO distributor VALUES('Rialto Pictures','03/12/93','Bruce Goldstein', 'Bruce Goldstein');
INSERT INTO distributor VALUES('20th Century Fox','07/05/82', 'Stacey Snider', 'William Fox');
INSERT INTO distributor VALUES('Paramount Pictures','11/20/74','Jim Gianopulos', 'Jesse L. Lasky');
INSERT INTO distributor VALUES('Disney/Pixar','12/17/77', 'Robert A. Iger', 'Walt Disney');
INSERT INTO distributor VALUES('Universal Pictures','02/20/88', 'Ronald Meyer', 'Carl Laemmle');
INSERT INTO distributor VALUES('United Artists','08/24/86', 'Mark Burnette', 'Charlie Chaplain');
INSERT INTO distributor VALUES('MGM','09/03/97', 'Gary Barber', 'Louis B. Mayer');
INSERT INTO distributor VALUES('Sony Pictures Home Entertainment','10/24/03', 'Man Jit Singh', 'Masaru Ibuka');
-- testing (IC name)
-- distributes inserts
INSERT INTO distributes VALUES('Warner Bros. Pictures','The Wizard of Oz','10/24/03','dvd','United States');
INSERT INTO distributes VALUES('RKO Radio Pictures','Citizen Kane','10/20/04','dvd','United States');
INSERT INTO distributes VALUES('Rialto Pictures','The Third Man','07/18/2000','dvd','United States');
INSERT INTO distributes VALUES('20th Century Fox','MM Fury Road','08/27/06','vcr','United States');
INSERT INTO distributes VALUES('Paramount Pictures','All About Eve','04/12/02','vcr','United States');
INSERT INTO distributes VALUES('Disney/Pixar','The Cabinet of Dr. Caligari','10/20/99','dvd','United States');
INSERT INTO distributes VALUES('Universal Pictures','Inside Out','02/24/05','vcr','United States');
INSERT INTO distributes VALUES('Universal Pictures','Animal House','07/28/78','vcr','United States');
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
INSERT INTO box_office VALUES('Animal House',3000000,1200341,479138,141600000);
--
-- testing (boIC1)
INSERT INTO box_office VALUES('Life',1829423,1286475,-235687,563254100);
--
-- works_on inserts
INSERT INTO works_on VALUES('Will Smith','Life','actor');
INSERT INTO works_on VALUES('John Smith','It','booking agent');
INSERT INTO works_on VALUES('Jason Momoa','Taken','actor');
INSERT INTO works_on VALUES('Emma Watson','Interstellar','actress');
INSERT INTO works_on VALUES('Abby Hall','Martian','booking agent');
INSERT INTO works_on VALUES('Seth Rogen','Pineapple Express','actor');
INSERT INTO works_on VALUES('Emily Jones','Prizoner of Azkaban','director');
INSERT INTO works_on VALUES('George Mann','Forrest Gump','producer');
INSERT INTO works_on VALUES('John Belushi','Animal House','actor');
INSERT INTO works_on VALUES('Kevin Bacon','Animal House','actor');
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
INSERT INTO genre VALUES ('Animal House','comedy');
-- testing (IC name)
COMMIT;
