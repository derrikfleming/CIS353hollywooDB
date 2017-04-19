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
---------------------------------------------------------------
SET ECHO OFF
SPOOL OFF
