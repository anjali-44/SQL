SELECT * FROM moviesdb.movies; ## as we are using the database moviesdb
SELECT * FROM movies;  # here we have set moviesdb as our default database so no need to mention 
SELECT title, industry
FROM movies;

SELECT * FROM movies WHERE industry="bollywood";
SELECT * FROM movies WHERE industry="hollywood";
select count(*) from movies where industry="hollywood";
select count(*) from movies where industry="bollywood";
select distinct industry from movies; # distinct unique industries
select * from movies where title like "%THOR%";
select * from movies where title like "%america%";
select * from movies where studio="";