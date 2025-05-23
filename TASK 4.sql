# Task 4 : generate report for top customer product and markets by net sales for givrn FY.
-- net sales = gross price - pre invoice deduction - post invoice deduction

-- first get preinvoice deduction 

select s.date, s.product_code, p.product, p.variant, s.sold_quantity, g.gross_price as gross_price_per_item, 
round(s.sold_quantity*g.gross_price, 2) as gross_price_total, pre.pre_invoice_discount_pct
from fact_sales_monthly s 
join dim_product p 
on s.product_code = p.product_code
join fact_gross_price g 
on g.fiscal_year = get_fiscal_year(s.date)
and g.product_code = s.product_code
join fact_pre_invoice_deductions pre
on pre.customer_code = s.customer_code 
and pre.fiscal_year = get_fiscal_year(s.date)
where get_fiscal_year(s.date) = 2021
limit 1000000;

-- this query is taking too long to execute nearly 7sec, time taking in fetching fiscal_year from get_fiscal_year function
-- we need to optimize its performance to makke it run faster

## improvement 1 : create a look up table 
## improvement 2 : adding extra column fiscal_year itself in fact_sales_monthly --->>
-- now we have fiscal_year in fact_sales_monthly, use in the baove query

select s.date, s.product_code, p.product, p.variant, s.sold_quantity, g.gross_price as gross_price_per_item, 
round(s.sold_quantity*g.gross_price, 2) as gross_price_total, pre.pre_invoice_discount_pct
from fact_sales_monthly s 
join dim_product p 
on s.product_code = p.product_code
join fact_gross_price g 
on g.fiscal_year = s.fiscal_year
and g.product_code = s.product_code
join fact_pre_invoice_deductions pre
on pre.customer_code = s.customer_code 
and pre.fiscal_year = s.fiscal_year
where s.fiscal_year = 2021
limit 1000000;

-- working fine also taking less time than previous query

-- now we have pre invoice dct pct apply it on gross price total and get net invoice sales
-- doing so by using CTE as we cant use derived columns directly

with cte1 as (
    select s.date, s.product_code, p.product, p.variant, s.sold_quantity, g.gross_price as gross_price_per_item, 
round(s.sold_quantity*g.gross_price, 2) as gross_price_total, pre.pre_invoice_discount_pct
from fact_sales_monthly s 
join dim_product p 
on s.product_code = p.product_code
join fact_gross_price g 
on g.fiscal_year = s.fiscal_year
and g.product_code = s.product_code
join fact_pre_invoice_deductions pre
on pre.customer_code = s.customer_code 
and pre.fiscal_year = s.fiscal_year
where s.fiscal_year = 2021
limit 1000000
)
select *, (gross_price_total - gross_price_total*pre_invoice_discount_pct) as net_invoice_sales
from cte1;

-- our cte1 query is something we will be using in future for other purposes too 
-- so storing it in database views
-- created views now using it in our query

select *, (gross_price_total - gross_price_total*pre_invoice_discount_pct) as net_invoice_sales
from sales_pre_inv_discount;

-- now lets work on grtting post invoice sales 

select *, (1 - pre_invoice_discount_pct)*gross_price_total as net_invoice_sales, 
(po.discounts_pct + po.other_deductions_pct) as post_inv_discount_pct
from sales_pre_inv_discount s
join fact_post_invoice_deductions po
on s.date = po.date 
and s.product_code = po.product_code;

-- this gives post_invoice_discount_pct 
-- create a view for this too 
-- use this views in our query now 

select *, (1 - post_inv_discount_pct)*net_invoice_sales as net_sales
from sales_post_inv_discount;

-- let us create one more view for net sales 

## now our all views are ready, now lets find top markets and customers

# TOP MARKET

select market, sum(net_sales) as net_sales, round(sum(net_sales)/1000000, 2) as net_sales_million
from net_sales
where fiscal_year = 2021
group by market
order by net_sales_million desc
limit 5;






