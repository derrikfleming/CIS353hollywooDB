--
-- Drop pre-existing tables if present.
--
DROP TABLE movie CASCADE CONSTRAINTS;
DROP TABLE person CASCADE CONSTRAINTS;
DROP TABLE production_company CASCADE CONSTRAINTS;
DROP TABLE distributor CASCADE CONSTRAINTS;
DROP TABLE box_office CASCADE CONSTRAINTS;
--
-- Create new tables
-- 
CREATE TABLE movie (
  title				varchar2(25) PRIMARY KEY,
  co_name			varchar2(20),
  mins_duration		number(4),
  mgenre 			varchar2(25),
  rating			number(1)
);
--
CREATE TABLE person (
  name				varchar2(50) PRIMARY KEY,
  comp_name			varchar2(20),
  hire_date			date,
  age				number(3),
  sex				char(1),
  role				varchar2(20)
);
--
CREATE TABLE production_company (
  company_name		varchar(20) PRIMARY KEY,
  year_founded		number(4)
);
--
CREATE TABLE distributor (
  dist_name			varchar2(15)
);
--
CREATE TABLE box_office (
  budget			number(12),
  mtitle			varchar2(25),
  admissions		number(15),
  opening_wkd		number(15),
  gross_profit		number(15)
);
--
CREATE TABLE role (
  person_name		varchar2(50) PRIMARY KEY,
  prole				varchar2(20)
);
--
CREATE TABLE awards (
  movie_title		varchar2(25),
  maward			varchar2(20)
);
--
CREATE TABLE genre (
  mov_title 		varchar2(25),
  mov_genre			
);