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
--
-- Create new tables
CREATE TABLE production_company (
  company_name		varchar2(50) PRIMARY KEY,
  year_founded		number(4),
--
CONSTRAINT pcIC1 CHECK(year_founded >= 1800 AND year_founded <= 2017)
);
--
CREATE TABLE movie (
  title				        varchar2(50) PRIMARY KEY,
  co_name			        varchar2(50),
  mins_duration	      number(4) NOT NULL,
  mgenre 			        varchar2(50) NOT NULL,
  rating			        number(1),
--
CONSTRAINT mIC1 UNIQUE (title, co_name),
CONSTRAINT mIC2 CHECK (rating IN ('1','2','3','4','5'))	
);
--
CREATE TABLE person (
  pname				  varchar2(50) PRIMARY KEY,
  comp_name			varchar2(50),
  hire_date			date,
  date_birth    date,
  sex				    char(1) NOT NULL,
--
CONSTRAINT pIC1 CHECK (sex IN('m','f')),
CONSTRAINT pIC2 CHECK (age >= 1)
);
--
CREATE TABLE distributor (
  dist_name		     varchar2(50) PRIMARY KEY,
  founding_date    date,
  president_name   varchar2(50),
  founder_name     varchar2(50)
--
);
--
CREATE TABLE box_office (
  mtitle	       varchar2(50) PRIMARY KEY,
  admissions		 number(15),
  opening_wkd		 number(15),
  gross_profit	 number(15),
--
CONSTRAINT boIC1 CHECK(opening_wkd >= 0)
);
--
CREATE TABLE roles (
  person_name		        varchar2(50) PRIMARY KEY,
  person_role				    varchar2(50)
--
);
--
CREATE TABLE awards (
  movie_title			varchar2(50) PRIMARY KEY,
  movie_award			varchar2(50)
--
);
--
CREATE TABLE genre (
  mov_title 		varchar2(50) PRIMARY KEY,
  mov_genre		  varchar2(50)
--	
);
--
-- Adding foreign keys:
ALTER TABLE movie
ADD FOREIGN KEY (co_name) REFERENCES production_company (company_name)
Deferrable initially deferred;
--
ALTER TABLE box_office
ADD FOREIGN KEY (mtitle) REFERENCES movie (title)
Deferrable initially deferred;
--
ALTER TABLE roles
ADD FOREIGN KEY (person_name) REFERENCES person (pname)
Deferrable initially deferred;
--
ALTER TABLE awards
ADD FOREIGN KEY (movie_title) REFERENCES movie (title)
Deferrable initially deferred;
--
ALTER TABLE genre
ADD FOREIGN KEY (mov_title) REFERENCES movie (title)
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
--testing(IC name)
--
-- person inserts
INSERT INTO person VALUES('Will Smith','PW Management','10/15/16','43','m');
INSERT INTO person VALUES('John Smith','PW Management','03/22/14','47','m');
INSERT INTO person VALUES('Jason Momoa','JR Agencies','01/19/12','39','m');
INSERT INTO person VALUES('Emma Watson','PW Management','07/25/09','28','f');
INSERT INTO person VALUES('Abby Hall','JR Agencies','02/04/13','31','f');
INSERT INTO person VALUES('Seth Rogen','JR Agencies','09/27/15','34','m');
INSERT INTO person VALUES('Emily Jones','EL Management','09/04/16','42','f');
INSERT INTO person VALUES('George Mann','EL Management','05/15/12','53','m');
-- testing (IC name)
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
-- testing (IC name)
-- distributor inserts
INSERT INTO distributor VALUES('Warner Bros. Pictures');
INSERT INTO distributor VALUES('RKO Radio Pictures');
INSERT INTO distributor VALUES('Rialto Pictures');
INSERT INTO distributor VALUES('20th Century Fox');
INSERT INTO distributor VALUES('Paramount Pictures');
INSERT INTO distributor VALUES('Disney/Pixar');
INSERT INTO distributor VALUES('Universal Pictures');
INSERT INTO distributor VALUES('United Artists');
INSERT INTO distributor VALUES('MGM');
INSERT INTO distributor VALUES('Sony Pictures Home Entertainment');
--testing (IC name)
-- box office inserts
INSERT INTO box_office VALUES(1000000,'The Wizard of Oz',1235986,156872,985634587);
INSERT INTO box_office VALUES(1235986,'Citizen Kane',1286475,968725,547862354);
INSERT INTO box_office VALUES(2694853,'The Third Man',17854963,123748,234658971);
INSERT INTO box_office VALUES(258741,'MM : Fury Road',1235986,854721,127653892);
INSERT INTO box_office VALUES(175982,'All About Eve',17854963,765843,234856975);
INSERT INTO box_office VALUES(1236548,'The Cabinet of Dr.Caligari',1596734,657921,542376854);
INSERT INTO box_office VALUES(257683,'Inside Out',17854963,435678,954723612);
INSERT INTO box_office VALUES(2456852,'The Godfather',17854963,349685,124578965);
INSERT INTO box_office VALUES(1596734,'Metropolis',1235986,754865,325412578);
INSERT INTO box_office VALUES(29758632,'Get Out',17854963,346218,236521452);
INSERT INTO box_office VALUES(1746859,'Modern Times',1286475,546231,458756325);
INSERT INTO box_office VALUES(1286475,'E.T. The Extra-Terrestrial',17854963,742131,632541258);
INSERT INTO box_office VALUES(2369854,'Singin in the Rain',1235986,355684,147896321);
INSERT INTO box_office VALUES(17854963,'It Happened One Night',1596734,241322,258967413);
INSERT INTO box_office VALUES(1798652,'Casablanca',1286475,235687,563254100);
-- testing (IC name)
-- roles inserts
INSERT INTO roles VALUES('Will Smith','actor');
INSERT INTO roles VALUES('John Smith','booking agent');
INSERT INTO roles VALUES('Jason Momoa','actor');
INSERT INTO roles VALUES('Emma Watson','actress');
INSERT INTO roles VALUES('Abby Hall','booking agent');
INSERT INTO roles VALUES('Seth Rogen','actor');
INSERT INTO roles VALUES('Emily Jones','director');
INSERT INTO roles VALUES('George Mann','producer');
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
