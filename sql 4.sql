select year(curdate());
select *, year(curdate())-birth_year as age from actors;
select *, (revenue-budget) as profit from financials;

select *, if(currency="usd", revenue*77, revenue) as revenue_inr
from financials;

## print profit % for all the movies

select *, (revenue-budget) as profit, (revenue-budget)*100 as profit_percent from financials; 

 