SPOOL project.out
SET ECHO ON
/*
CIS353 - Movie Database Design Project
Derrik Flemming
Alex Duncanson
Nathan Lindenbaum
Mike Ames
*/
--
--
-- ------------------------------------------------
-- Creating Schema
-- ------------------------------------------------
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
  movieTitle	        varchar2(50) PRIMARY KEY NOT NULL,
  cName			          varchar2(50),
  duration    	      number(4) NOT NULL,
  rating			        number(1) NOT NULL,
  gCreview				number(1) NOT NULL,
--
CONSTRAINT mIC1 UNIQUE (movieTitle, cName),
CONSTRAINT mIC2 CHECK (rating IN ('1','2','3','4','5')),
CONSTRAINT mIC3 CHECK (NOT (rating > '3' AND gCreview < '1'))	
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
  PRIMARY KEY (distributorName, movieTitle),
  CONSTRAINT di1 FOREIGN KEY (distributorName) REFERENCES distributor (distributorName) ON DELETE CASCADE
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
ALTER TABLE person
ADD FOREIGN KEY (cName) REFERENCES production_company (companyName)
Deferrable initially deferred;
--
ALTER TABLE works_on
ADD FOREIGN KEY (personName) REFERENCES person (personName)
ADD FOREIGN KEY (movieTitle) REFERENCES movie (movieTitle)
Deferrable initially deferred;
--
ALTER TABLE distributes
ADD FOREIGN KEY (movieTitle) REFERENCES movie (movieTitle)
Deferrable initially deferred;
--
--
SET FEEDBACK OFF
--
-- --------------------------------------------------------------
-- Populate the database
-- --------------------------------------------------------------
--
alter session set NLS_DATE_FORMAT = 'MM/DD/YYYY';
--
-- movie inserts
--
INSERT INTO movie VALUES ('The Wizard of Oz', 'JR Agencies', '101',5 , 2);
INSERT INTO movie VALUES ('Citizen Kane', '5-0 Management', '119', 4, 2);
INSERT INTO movie VALUES ('The Third Man', '5-0 Management', '104', 5, 3);
INSERT INTO movie VALUES ('MM : Fury Road', 'LA Management', '120', 5, 2);
INSERT INTO movie VALUES ('All About Eve', 'PW Management', '138', 5, 3);
INSERT INTO movie VALUES ('The Cabinet of Dr. Caligari', 'Blues Bros Management', '52',4, 4);
INSERT INTO movie VALUES ('Inside Out', 'JR Agencies', '94',3, 5);
INSERT INTO movie VALUES ('The Godfather', 'JR Agencies', '175',3, 6);
INSERT INTO movie VALUES ('Metropolis', 'EL Management', '115', 4, 3);
INSERT INTO movie VALUES ('Get Out', 'PW Management', '104', 3, 4);
INSERT INTO movie VALUES ('Modern Times', 'PW Management', '87', 5, 7);
INSERT INTO movie VALUES ('E.T. The Extra-Terrestrial', 'Blues Bros Management','114', 3, 4);
INSERT INTO movie VALUES ('Singin in the Rain', 'PW Management', '102',4, 3);
INSERT INTO movie VALUES ('It Happened One Night', 'PW Management', '105',3, 5);
INSERT INTO movie VALUES ('Casablanca', 'Blues Bros Management', '102',4, 4);
INSERT INTO movie VALUES ('Animal House', '5-0 Management', '109',5, 4);
INSERT INTO movie VALUES ('Pineapple Express', 'HI GH Agencies','117',5, 4);
INSERT INTO movie VALUES ('Drillbit Taylor', 'LA Management','102',5, 5);
--
-- person inserts
--
INSERT INTO person VALUES('Will Smith','PW Management','10/15/2016','09/25/1968','m');
INSERT INTO person VALUES('John Smith','PW Management','3/22/2014','02/12/1965','m');
INSERT INTO person VALUES('Jason Momoa','JR Agencies','1/19/2012','08/01/1979','m');
INSERT INTO person VALUES('Emma Watson','PW Management','07/05/2009','04/15/1990','f');
INSERT INTO person VALUES('Abby Hall','JR Agencies','02/24/2013','06/14/1987','f');
INSERT INTO person VALUES('Seth Rogen','HI GH Agencies','09/27/2015','04/15/1982','m');
INSERT INTO person VALUES('James Franco','HI GH Agencies','04/20/2006','04/19/1978','m');
INSERT INTO person VALUES('Emily Jones','EL Management','09/04/2016','08/01/1977','f');
INSERT INTO person VALUES('George Mann','EL Management','05/15/2012','12/02/1978','m');
INSERT INTO person VALUES('John Belushi','Blues Bros Management','05/15/1978','01/24/1949','m');
INSERT INTO person VALUES('Kevin Bacon','5-0 Management','05/15/2012','12/02/1978','m');
INSERT INTO person VALUES('Casey Boersma','LA Management','01/01/2008','01/13/1995','m');
INSERT INTO person VALUES('Dylan Boersma','LA Management','05/15/2008','01/13/1995','m');
--
-- production company inserts
--
INSERT INTO production_company VALUES('PW Management',1923);
INSERT INTO production_company VALUES('JR Agencies',1928);
INSERT INTO production_company VALUES('HI GH Agencies',1997);
INSERT INTO production_company VALUES('EL Management',1935);
INSERT INTO production_company VALUES('Blues Bros Management',1912);
INSERT INTO production_company VALUES('5-0 Management',1986);
INSERT INTO production_company VALUES('LA Management',1912);
--
-- distributor inserts
--
INSERT INTO distributor VALUES('Warner Bros. Pictures','10/09/95','Kevin Tsujihara','Jesse L. Lasky');
INSERT INTO distributor VALUES('RKO Radio Pictures','01/24/89', 'DEFUNCT', 'Joseph P. Kennedy Sr.');
INSERT INTO distributor VALUES('Rialto Pictures','03/12/93','Bruce Goldstein', 'Bruce Goldstein');
INSERT INTO distributor VALUES('20th Century Fox','07/05/82', 'Stacey Snider', 'William Fox');
INSERT INTO distributor VALUES('Paramount Pictures','10/09/95','Jim Gianopulos', 'Jesse L. Lasky');
INSERT INTO distributor VALUES('Disney/Pixar','12/17/77', 'Robert A. Iger', 'Walt Disney');
INSERT INTO distributor VALUES('Universal Pictures','02/20/88', 'Ronald Meyer', 'Carl Laemmle');
INSERT INTO distributor VALUES('United Artists','08/24/86', 'Mark Burnette', 'Charlie Chaplain');
INSERT INTO distributor VALUES('MGM','10/09/95', 'Gary Barber', 'Jesse L. Lasky');
INSERT INTO distributor VALUES('Sony Pictures Home Entertainment','10/24/03', 'Man Jit Singh', 'Masaru Ibuka');
-- 
-- distributes inserts
--
INSERT INTO distributes VALUES('Warner Bros. Pictures','The Wizard of Oz','10/24/03','dvd','United States');
INSERT INTO distributes VALUES('RKO Radio Pictures','Citizen Kane','10/20/04','dvd','United Kingdom');
INSERT INTO distributes VALUES('Rialto Pictures','The Third Man','07/18/2000','dvd','United States');
INSERT INTO distributes VALUES('20th Century Fox','MM : Fury Road','08/27/06','vcr','Denmark');
INSERT INTO distributes VALUES('Paramount Pictures','All About Eve','04/12/02','vcr','United States');
INSERT INTO distributes VALUES('Disney/Pixar','The Cabinet of Dr. Caligari','10/20/99','dvd','Iraq');
INSERT INTO distributes VALUES('Universal Pictures','Inside Out','02/24/05','vcr','United States');
INSERT INTO distributes VALUES('Universal Pictures','The Godfather','07/28/78','vcr','Djibouti');
INSERT INTO distributes VALUES('Sony Pictures Home Entertainment','Pineapple Express','08/06/08','dvd','United States');
INSERT INTO distributes VALUES('MGM','Drillbit Taylor','03/21/08','dvd','United States');
--
-- box office inserts
--
INSERT INTO box_office VALUES('The Wizard of Oz',4897362,1235986,156872,985634587);
INSERT INTO box_office VALUES('Citizen Kane',1235986,1286475,968725,547862354);
INSERT INTO box_office VALUES('The Third Man',84927489,17854963,123748,234658971);
INSERT INTO box_office VALUES('MM : Fury Road',1726374,1235986,854721,127653892);
INSERT INTO box_office VALUES('All About Eve',1236453,17854963,765843,234856975);
INSERT INTO box_office VALUES('The Cabinet of Dr. Caligari',1829374,1596734,657921,542376854);
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
INSERT INTO box_office VALUES('Pineapple Express',27000000,14000000,23245025,87341380);
INSERT INTO box_office VALUES('Drillbit Taylor',40000000,5555555,10309986,32853640);
--
-- works_on inserts
--
INSERT INTO works_on VALUES('Will Smith','Modern Times','actor');
INSERT INTO works_on VALUES('John Smith','It Happened One Night','booking agent');
INSERT INTO works_on VALUES('Jason Momoa','Inside Out','actor');
INSERT INTO works_on VALUES('Emma Watson','It Happened One Night','actress');
INSERT INTO works_on VALUES('Abby Hall','Inside Out','booking agent');
INSERT INTO works_on VALUES('Seth Rogen','Pineapple Express','actor');
INSERT INTO works_on VALUES('James Franco','Pineapple Express','actor');
INSERT INTO works_on VALUES('Emily Jones','Metropolis','director');
INSERT INTO works_on VALUES('George Mann','Metropolis','producer');
INSERT INTO works_on VALUES('John Belushi','Casablanca','actor');
INSERT INTO works_on VALUES('Kevin Bacon','The Third Man','actor');
INSERT INTO works_on VALUES('Casey Boersma','Drillbit Taylor','actor');
INSERT INTO works_on VALUES('Dylan Boersma','Drillbit Taylor','actor');
--
-- awards inserts
--
INSERT INTO awards VALUES ('The Wizard of Oz','Film of The Year');
INSERT INTO awards VALUES ('Citizen Kane','Academy Award');
INSERT INTO awards VALUES ('The Third Man','Film of The Year');
INSERT INTO awards VALUES ('MM : Fury Road','Academy Award');
INSERT INTO awards VALUES ('All About Eve','Academy Award');
INSERT INTO awards VALUES ('The Cabinet of Dr. Caligari','Film of The Year');
INSERT INTO awards VALUES ('Inside Out','Academy Award');
INSERT INTO awards VALUES ('The Godfather','Film of The Year');
INSERT INTO awards VALUES ('Metropolis','Academy Award');
INSERT INTO awards VALUES ('Get Out','Film of The Year');
INSERT INTO awards VALUES ('Modern Times','Academy Award');
INSERT INTO awards VALUES ('E.T. The Extra-Terrestrial','Film of The Year');
INSERT INTO awards VALUES ('Singin in the Rain','Academy Award');
INSERT INTO awards VALUES ('It Happened One Night','Film of The Year');
INSERT INTO awards VALUES ('Casablanca','Academy Award');
--
-- genre inserts
--
INSERT INTO genre VALUES ('The Wizard of Oz','fantasy');
INSERT INTO genre VALUES ('Citizen Kane','action');
INSERT INTO genre VALUES ('The Third Man','action');
INSERT INTO genre VALUES ('MM : Fury Road','action');
INSERT INTO genre VALUES ('All About Eve','romance');
INSERT INTO genre VALUES ('The Cabinet of Dr. Caligari','thriller');
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
INSERT INTO genre VALUES ('Pineapple Express','comedy');
INSERT INTO genre VALUES ('Drillbit Taylor','comedy');
--
--
SET FEEDBACK ON
--
COMMIT;
--
-- ------------------------------------------------------------------
-- Displaying Tables
-- ------------------------------------------------------------------
--
SELECT * FROM movie;
SELECT * FROM person;
SELECT * FROM production_company;
SELECT * FROM distributor;
SELECT * FROM box_office;
SELECT * FROM awards;
SELECT * FROM genre;
SELECT * FROM works_on;
SELECT * FROM distributes;
--
-- ------------------------------------------------------------------
-- Queries
-- ------------------------------------------------------------------
--
-- 1: Joining 4
-- Find the person's name/ company name, movie title and (movie's) gross profit for any actor 
-- that worked on a comedy film that grossed more than $50 mill 
--
SELECT p.personName, m.movieTitle, b.grossProfit
FROM Person p, Movie m, box_office b, works_on w, genre g
WHERE p.personName = w.personName AND
	  m.movieTitle = w.movieTitle AND b.mTitle = m.movieTitle AND g.mTitle = m.movieTitle AND
	  b.grossProfit > 50000000 AND
	  w.primaryRole = 'actor' AND
	  g.Mgenre LIKE '%comedy%';
--
-- 2: Self Join
-- Find names of distributors who were founded at the same time that also share the same founder.
--
SELECT DISTINCT d1.distributorName
   FROM distributor d1, distributor d2
   WHERE d1.distributorName <> d2.distributorName AND
         d1.founder = d2.founder AND
         d1.dateOfFounding = d2.dateOfFounding;
--
-- 3: Union/Intersection/Minus
-- < Select all of the action movies with a rating greater than 3 >
--
SELECT m.movieTitle, g.mGenre, m.rating
FROM movie m, genre g 
WHERE m.rating > 3
INTERSECT
SELECT g.mTitle, g.mGenre, m.rating
FROM genre g, movie m
WHERE g.mGenre LIKE '%action%';
--
-- 4: SUM/AVG/MAX/MIN
-- < Select the movie title, cost of production and gross profit, and  
--   awards for all movies that have earned awards, with ratings greater than 3,
--   and whose gross profit is greater than the average gross profit >
--
SELECT distinct b.mTitle, b.costOfProduction, b.grossProfit, a.mAward
FROM   box_office b, awards a
WHERE  b.mTitle = a.mTitle AND
       b.grossProfit > 
        (SELECT AVG (b.grossProfit)
         FROM box_office b, awards a, movie m
         WHERE a.mAward IS NOT NULL AND
         m.rating > 3)
ORDER BY b.mTitle;
--
-- 5: GROUP BY, HAVING, ORDER BY
-- < Find the average duration of movies with a rating of 3, 4, and 5 >
SELECT rating, AVG (duration)
   FROM movie
   GROUP BY rating
   HAVING COUNT (rating) > 2
   ORDER BY AVG (rating);
--
--
-- 6: Correlated Subquery
-- Find the title, gross profit, and genre of the highest grossing films of each genre.
--
SELECT b1.mTitle, b1.grossProfit, g1.mGenre 
FROM   box_office b1, genre g1
WHERE g1.mTitle = b1.mTitle AND
	  b1.grossProfit = 
      (SELECT MAX(b2.grossProfit)
       FROM box_office b2, genre g2
       WHERE g1.mGenre LIKE g2.mGenre AND
             b2.mTitle = g2.mTitle)
ORDER BY b1.mTitle;
--
-- 7: Non-correlated Subquery
-- < Finds every movie that wasn't distributed in the United States >
--
SELECT M.movieTitle
   FROM distributes M
   WHERE M.country NOT IN (SELECT N.country
                              FROM distributes N
                              WHERE N.country = 'United States');
--
-- 8: A Relational DIVISION query
-- < Finds the title of every movie that has a rating of 5 and
--   was not produced by Warner Bros. Pictures >
--
SELECT M.movieTitle
   FROM movie M
   WHERE M.movieTitle = ((SELECT N.movieTitle
                    FROM movie N
                    WHERE N.rating = 5 AND
                          N.movieTitle = M.movieTitle)
                   MINUS
                   (SELECT N.movieTitle
                    FROM movie N
                    WHERE N.cName = 'Warner Bros. Pictures'));
-- 
-- 9: Outer Join
-- < Finds the title, rating, and gross profit of every movie >
-- 
SELECT M.movieTitle, M.rating, B.grossProfit
   FROM movie M LEFT OUTER JOIN box_office B ON M.movieTitle = B.mTitle;
--
-- 10: RANK
-- Returns the titles and ranks the gross profits of the movies in the 'action' genre, 
-- ordered by highest grossing to lowest, and (rank)1 = highest grossing.
--
SELECT b.mTitle, b.grossProfit,
RANK() OVER (PARTITION BY g.mgenre ORDER BY b.grossProfit DESC)
FROM box_office b, genre g
WHERE b.mtitle = g.mtitle AND
      g.mgenre LIKE '%action%';
--
-- 11: Top-N
-- Finds the title, cost of production, and gross profit of the 5 highest grossing movies.
--
SELECT  mtitle, costOfProduction, grossProfit 
FROM   (SELECT * FROM box_office ORDER BY grossProfit DESC)
WHERE   ROWNUM < 6;
--
--
--Test constraint di1 (On delete cascade in the distributes table) 
SELECT  d.distributorName
FROM distributes d;

DELETE 
FROM distributor
WHERE distributorName = 'Warner Bros. Pictures';

SELECT d.distributorName
FROM distributes d;
--
-- ---------------------------------------------------------------------------------------------
-- Integrity Constraint Checks
-- ---------------------------------------------------------------------------------------------
-- 
-- testing (mICKEY)
INSERT INTO movie VALUES ('The Wizard of Oz', '5-0 Management', '101',5 , 2);
--
-- testing (dil)
DELETE FROM distributor WHERE distributorName = '20th Century Fox';
SELECT distributorName FROM distributes;
SELECT distributorName FROM distributor;
--
-- testing (mIC2)
INSERT INTO movie VALUES ('Into The Wild', 'JR Agencies', '103', 7, 3);
--
-- testing (mIC3)
INSERT INTO movie VALUES ('Into The Wild', 'JR Agencies', '103', 5, 0);
--
COMMIT;
--
SPOOL OFF




