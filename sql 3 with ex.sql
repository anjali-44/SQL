SELECT MAX(imdb_rating) from movies where studio="marvel studios";
SELECT MIN(imdb_rating) from movies where studio="marvel studios";
SELECT ROUND(AVG(imdb_rating), 2) from movies where studio="marvel studios";
select round(avg(imdb_rating), 2) as avg_rating, max(imdb_rating) as max_rating,
min(imdb_rating) as min_rating from movies group by industry;
select industry, count(*) from movies group by industry;
select studio, count(*) as cnt from movies group by studio order by cnt desc;

select industry, count(industry) as cnt, round(avg(imdb_rating), 2) as avg_rating
from movies where studio!="" group by industry order by avg_rating desc;

# 1. How many movies were released between 2015 and 2022
# 2. Print the max and min movie release year
# 3. Print a year and how many movies were released in that year starting with the latest year

select count(*) as movies_count from movies where release_year between 2015 and 2022;
select max(release_year) as max_release_year, min(release_year) as min_release_year from movies;
select release_year, count(release_year) from movies group by release_year
order by release_year desc;
select release_year, count(release_year) as movies_count 
   from movies group by release_year order by release_year desc