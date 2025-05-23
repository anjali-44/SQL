-- Window function Tasks : 
-- TASK 1 : get top n products in each division by their qty sold 
-- also create stored proc for getting top n product in each division by qty sold in given FY

SELECT 
  p.division, 
  p.product, 
  s.sold_quantity,
  SUM(s.sold_quantity) OVER () AS total_qty
FROM 
  fact_sales_monthly s
JOIN 
  dim_product p ON p.product_code = s.product_code
WHERE 
  fiscal_year = 2021;


with cte1 as (
SELECT 
  p.division, 
  p.product, 
  s.sold_quantity,
  SUM(s.sold_quantity) OVER () AS total_qty
FROM 
  fact_sales_monthly s
JOIN 
  dim_product p ON p.product_code = s.product_code
WHERE 
  fiscal_year = 2021),
  
  cte2 as (
  select *, dense_rank() over (partition by division order by total_qty desc) as drank
  from cte1)
  
  select * from cte2 where drank <= 3;