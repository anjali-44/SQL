# 1. Print all movie titles and release year for all Marvel Studios movies.
# 2. Print all movies that have Avenger in their name.
# 3. Print the year when the movie "The Godfather" was released.
# 4. Print all distinct movie studios in the Bollywood industry.

SELECT title, release_year FROM movies WHERE studio="marvel studios";
SELECT * FROM movies WHERE title like "%avenger%";
SELECT release_year FROM movies WHERE title="The Godfather";
SELECT distinct studio from movies where industry="bollywood";
