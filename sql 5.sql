# inner join --> this joins the common columns 
SELECT movies.movie_id, title, budget, revenue, currency, unit
FROM movies JOIN financials ON movies.movie_id=financials.movie_id;

#using shorter abbrevations for the same query
SELECT m.movie_id, title, budget, revenue, currency, unit
FROM movies m JOIN financials f ON m.movie_id=f.movie_id;

# left join table name written after from is considered as left --> join all of left side and common in both
SELECT m.movie_id, title, budget, revenue, currency, unit
FROM movies m LEFT JOIN financials f ON m.movie_id=f.movie_id;

# right join --> join all from right table and the common in both
SELECT f.movie_id, title, budget, revenue, currency, unit
FROM movies m RIGHT JOIN financials f ON m.movie_id=f.movie_id;

# full join --> ALL RECORDS 
SELECT m.movie_id, title, budget, revenue, currency, unit
FROM movies m LEFT JOIN financials f ON m.movie_id=f.movie_id
UNION
SELECT f.movie_id, title, budget, revenue, currency, unit
FROM movies m RIGHT JOIN financials f ON m.movie_id=f.movie_id;

# using USING clause --> when joining on same column_name:
SELECT m.movie_id, title, budget, revenue, currency, unit
FROM movies m LEFT JOIN financials f USING (movie_id)
UNION
SELECT f.movie_id, title, budget, revenue, currency, unit
FROM movies m RIGHT JOIN financials f USING (movie_id);


# 1. Show all the movies with their language names
# 2. Show all Telugu movie names (assuming you don't know the language
# id for Telugu)
# 3. Show the language and number of movies released in that language

SELECT movie_id, title, l.name
FROM movies m LEFT JOIN languages l ON m.language_id=l.language_id;

SELECT movie_id, title, l.name
FROM movies m LEFT JOIN languages l ON m.language_id=l.language_id WHERE l.name="Telugu";

SELECT l.name, count(m.movie_id) as movie_count FROM movies m LEFT JOIN languages l ON m.language_id=l.language_id
GROUP BY l.name ORDER BY movie_count DESC; # in this left join is from movies->lang

SELECT l.name, COUNT(m.movie_id) as no_movies ## in this the left join is from lang->movies
	FROM languages l
	LEFT JOIN movies m USING (language_id)        
	GROUP BY language_id
	ORDER BY no_movies DESC;


