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
	  m.movieTitle = w.movieTitle AND b.mTitle = m.movieTitle AND g.mTitle = m.movieTitle AND
	  b.grossProfit > 50000000 AND
	  w.primaryRole = 'actor' AND
	  g.Mgenre LIKE '%comedy%';
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
-- < Select the movie title, cost of production and gross profit for all movies that have earned awards, with ratings greater than 3,
--   and whose gross profit is greater than the average gross profit >
--
SELECT b.mTitle, b.costOfProduction, b.grossProfit
FROM box_office b
WHERE b.grossProfit > 
 (SELECT AVG (b.grossProfit)
 FROM box_office b, awards a, movie m
 WHERE a.mAward IS NOT NULL AND
       m.rating > 3)
--
-- 5: GROUP BY, HAVING, ORDER BY
-- < DESCRIPTION HERE >
--
SELECT
FROM
WHERE ;
--
-- 6: Correlated Subquery
-- Find any movie that has a gross profit greater than the average gross profit of movies in
-- the same genre.
--
SELECT DISTINCT m1.movieTitle, b1.grossProfit 
FROM movie m1, box_office b1, genre g1
WHERE m1.movieTitle = b1.mTitle AND
	  b1.grossProfit > 
      (SELECT AVG(b2.grossProfit)
       FROM movie m2, box_office b2, genre g2
       WHERE g1.mGenre = g2.mGenre)
ORDER BY m1.movieTitle;
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
