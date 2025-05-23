# COMMON TABLE EXPRESSIONS

# all actors age between 70 and 85

with actor_age as (
     select name as actor_name, 
     year(curdate()) - birth_year as age
     from actors
     )
 select actor_name, age
 from actor_age
 where age > 70 and age < 80;
 
 with actors_age (actor_name, age) as (
      select name as x, year(curdate()) - birth_year as y
      from actors
      )

select actor_name, age
from actors_age
where age > 70 and age < 80;


# movies that produced 500% or more profit and their avg rating was less than avg rating of all the movies

# using subquery

select x.movie_id, x.pct_profit,
	   y.title, y.imdb_rating
   from (
		select *, (revenue-budget)*100/budget as pct_profit
        from financials
		) x
	join (
		 select * from movies 
         where imdb_rating < (select avg(imdb_rating)
         from movies) 
         ) y
 on x.movie_id = y.movie_id
 where pct_profit >= 500;
 
 
 # using cte
 
 with x as (
		  select *, (revenue-budget)*100/budget as pct_profit
          from financials
           ),
	   y as (
		  select * from movies 
          where imdb_rating < (select avg(imdb_rating)
          from movies
            ))
            
select x.movie_id, x.pct_profit,
       y.title, y.imdb_rating
from x
join y
on x.movie_id = y.movie_id
where pct_profit >= 500;


# Select all Hollywood movies released after the year 2000 that made more than 500 
#million $ profit or more profit. Note that all Hollywood movies have millions as 
#a unit hence you don't need to do the unit conversion. Also, you can write this 
#query without CTE as well but you should try to write this using CTE only

select * from movies where industry = "Hollywood";
select *, (revenue - budget)*100/budget as profit
from financials where (revenue - budget)*100/budget >= 500;

with x as (
          select * from movies where industry = "Hollywood" and release_year > 2000
          ),
	 y as (
		  select *, (revenue - budget)*100/budget as profit
          from financials where (revenue - budget) >= 500
          )
select x.movie_id, x.title, x.release_year,
       y.profit
	from x
    join y
    on x.movie_id = y.movie_id;
    
    
    
    
    
with cte as (select title, release_year, (revenue-budget) as profit
			from movies m
			join financials f
			on m.movie_id=f.movie_id
			where release_year>2000 and industry="hollywood"
	)
	select * from cte where profit>500;
