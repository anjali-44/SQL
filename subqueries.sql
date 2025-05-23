## subqueries 

# movie with highest imdb_rating
select * from movies 
where imdb_rating = (select max(imdb_rating) from movies);

# similarly movie with minimum imdb_rating
select * from movies 
where imdb_rating = (select min(imdb_rating) from movies);

# can also return min amd max at the same time
select * from movies 
where imdb_rating in (
     (select min(imdb_rating) from movies), 
     (select max(imdb_rating) from movies)
     );
     
# to get actors age > 70  and < 85
select * from (
      (select name, year(curdate()) - birth_year as age from actors)
      ) as actors_age
where age > 70 and age < 85;



## ANY and ALL operators 

# actor who acted in any of movies with movie_id (101, 110, 121)
select * from actors where actor_id = ANY(
        select actor_id from movie_actor
        where movie_id in (101,110,121)
        ); 
        
# movies whose rating greater than *any* of marvel movies rating
select * from movies where imdb_rating > ANY (
       select imdb_rating from movies 
       where studio = "marvel studios"
       ); # here the minimum rating in marvel studios is 6.8 and the movies printed here have rating greater than 6.8

      # OR
select * from movies where imdb_rating > ANY (
       select min(imdb_rating) from movies 
       where studio = "marvel studios"
       );
       
       # can also be done to get the movie rating greater than the highest rated marvel studios movie
select * from movies where imdb_rating > ANY (
       select max(imdb_rating) from movies 
       where studio = "marvel studios"
       );
       

## CO-RELATED SUBQUERIES 

# select actor_id, name and total movies acted in
# using normal query
select a.actor_id, a.name, count(*) as movie_count
from movie_actor ma
join actors a 
on ma.actor_id = a.actor_id
group by a.actor_id
order by movie_count desc;

# using co-related subqueries --> correlated as its execution depends on the outer query
# explain analyze --> written at the top of any query to know performance analysis
select actor_id, name, (
     select count(*) from movie_actor
     where actor_id = actors.actor_id
     ) as movie_count
 from actors
 order by movie_count desc;
 
 
# EXERCISE 

# 1. Select all the movies with minimum and maximum release_year. Note that there
# can be more than one movie in min and a max year hence output rows can be more than 2
    
# 2. Select all the rows from the movies table whose imdb_rating is higher than the average rating
    
select * from movies where release_year in (
     (select min(release_year) from movies),
     (select max(release_year) from movies)
     )
 order by release_year desc;
 
 select * from movies where imdb_rating > (
      select avg(imdb_rating) from movies
      )
order by imdb_rating desc;