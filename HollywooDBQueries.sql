-- ------------------------------------------------------------
-- 
-- < HollywooDB Queries >
--
-- -------------------------------------------------------------
SPOOL hollywoodbquery.out
SET ECHO ON
-- 1: Joining 4
-- Find the person's name/ company name, movie title and (movie's) gross profit for any actor 
-- that worked on a comedy film that grossed more than $50 mill 
--
SELECT p.personName, m.movieTitle, b.grossProfit
FROM Person p, Movie m, box_office b, works_on w, genre g
WHERE p.personName = w.personName AND
	  m.movieTitle = w.movieTitle AND b.movieTitle = m.movieTitle AND g.movieTitle = m.movieTitle AND
	  b.grossProfit > 50000000 AND
	  w.primaryRole = 'actor' AND
	  g.genre LIKE '%comedy%'
	  ;
--
-- 2: Self Join
-- Find pairs of names of people who worked on the same movie that also share the same birthday.
--
SELECT  DISTINCT P1.personName, P2.personName, P1.dateOfBirth,  W1.works_on
FROM 	person P1, person P2, works_on w1, works_on w2
WHERE 	p1.personName <> p2.personName AND
		p1.personName = w1.personName AND p2.personName = w2.personName AND
		w1.movieTitle = w2.movieTitle AND
		p1.dateOfBirth = p2.dateOfBirth
		;
--
-- 3: Union/Intersection/Minus
-- < Select all of the action movies with a rating greater than 3 >
--
SELECT m.movieTitle
FROM movie m 
WHERE m.rating > 3
INTERSECT
SELECT g.mTitle
FROM genre g
WHERE g.mGenre LIKE '%action%';
--
-- 4: SUM/AVG/MAX/MIN
-- < DESCRIPTION HERE >
--
SELECT
FROM
WHERE ;
--
-- 5: GROUP BY, HAVING, ORDER BY
-- < DESCRIPTION HERE >
--
SELECT
FROM
WHERE ;
--
-- 6: Correlated Subquery
-- < DESCRIPTION HERE >
--
SELECT
FROM
WHERE ;
--
-- 7: Non-correlated Subquery
-- < DESCRIPTION HERE >
--
SELECT
FROM
WHERE ;
--
-- 8: A Relational DIVISION query
-- < DESCRIPTION HERE >
--
SELECT
FROM
WHERE ;
-- 
-- 9: Outer Join
-- < DESCRIPTION HERE >
-- 
SELECT
FROM
WHERE ;
--
-- 10: RANK
-- Find the rank in duration of the movie The Godfather.
--
SELECT RANK (SELECT duration FROM Movies WHERE movieTitle = 'The Godfather') WITHIN GROUP
 (ORDER BY duration) "The rank (in duration) of the movie: The Godfather"
FROM movie;
--
-- 11: Top-N
-- Finds the title, cost of production, and gross profit of the 5 highest grossing movies.
--
SELECT  mtitle, costOfProduction, grossProfit 
FROM   (SELECT * FROM box_office ORDER BY grossProfit DESC)
WHERE   ROWNUM < 6;
--
--
---------------------------------------------------------------
SET ECHO OFF
SPOOL OFF
