SELECT * FROM random_tables.expenses;

-- total expense is
select sum(amount) from expenses;

-- now to get the % expense of each 
select *, amount*100/sum(amount) as pct from expenses order by category;

-- using window function 
select *, amount*100/sum(amount) over() as pct from expenses order by category;

-- to get this pct wrt total per category 
select sum(amount) from expenses where category = "Food";

select *, amount*100/sum(amount) over(partition by category) as pct
from expenses 
order by category;

-- let us now display the cumulative sum 
select * ,sum(amount) over(partition by category order by date) as total_exp_till_date
from expenses
order by category;


-- WINDOWS FUNCTIONS : row_number, rank(), dense_rank()
-- task show top 2 expenses in each category

select *, row_number() over(partition by category order by amount desc) as rn
from expenses 
order by category;

with cte1 as (
select *, row_number() over(partition by category order by amount desc) as rn
from expenses 
order by category
)

select * from cte1 where rn <= 2;


select *, row_number() over(partition by category order by amount desc) as rn,
rank() over(partition by category order by amount desc) as rnk,
dense_rank() over(partition by category order by amount desc) as drnk
from expenses 
order by category;