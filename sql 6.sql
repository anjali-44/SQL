# CROSS JOIN 

SELECT * 
FROM food_db.items
CROSS JOIN food_db.variants; ## this will do cartesian product of table items and variants

SELECT *, CONCAT(name, " - ", variant_name) as full_name,
(price + variant_price) as total_price
FROM food_db.items
CROSS JOIN food_db.variants;

# ANALYTICS ON TABLES :

SELECT m.movie_id, title, budget, revenue, currency, unit,
(revenue - budget) as profit
FROM movies m JOIN financials f ON m.movie_id=f.movie_id
WHERE industry="bollywood";

# which movie made highest profit:
# normalize column unit

SELECT m.movie_id, title, budget, revenue, currency, unit,
(revenue - budget) as profit,
	CASE
		WHEN unit="thousands" THEN ROUND((revenue-budget)/1000, 1)
		WHEN unit="billions" THEN ROUND((revenue-budget)*1000 , 1)
		ELSE ROUND((revenue - budget ), 1)
	END AS profit_mln
FROM movies m JOIN financials f ON m.movie_id=f.movie_id
WHERE industry="bollywood"
ORDER BY profit_mln DESC;

# JOINING MORE THAN TWO TABLES :

SELECT m.title, group_concat(a.name separator " | ")
FROM movies m 
JOIN movie_actor ma ON ma.movie_id=m.movie_id
JOIN actors a ON a.actor_id=ma.actor_id
GROUP BY m.movie_id;


SELECT a.name, group_concat(m.title separator " | "), COUNT(m.title) as movie_count
FROM actors a
JOIN movie_actor ma ON ma.actor_id=a.actor_id
JOIN movies m ON m.movie_id=ma.movie_id
GROUP BY a.actor_id
ORDER BY movie_count DESC;

# 1. Generate a report of all Hindi movies sorted by their revenue amount in millions.
# Print movie name, revenue, currency, and unit

SELECT m.movie_id, m.title, revenue, currency, unit,
CASE
WHEN unit="thousands" THEN ROUND((revenue)/1000, 2)
WHEN unit="billions" THEN ROUND((revenue)*1000, 2)
ELSE ROUND(revenue, 2)
END AS Revenue_mln
FROM movies m 
JOIN languages l ON m.language_id = l.language_id
JOIN financials f ON m.movie_id = f.movie_id WHERE l.name="hindi"
ORDER BY Revenue_mln DESC;
