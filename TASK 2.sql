## TASK 2 : aggregate monthly gross sales report for Croma India Customer so to track how muxh sales
## this particular customer is generating to manage relationships accordingly 

-- this report should have following fields:
-- 1. Month
-- 2. Total gross sales amount to Croma India in this month

SELECT * FROM fact_sales_monthly s
JOIN fact_gross_price g 
ON g.product_code = s.product_code and 
g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002
order by s.date asc

-- Now to get monthly aggregated sales in a given month
-- doing GROUP BY -- make sure use aggregation SUM otherwise gross_price_total will not be accurate

SELECT s.date, SUM(g.gross_price*s.sold_quantity) as gross_price_total
FROM fact_sales_monthly s
JOIN fact_gross_price g 
ON g.product_code = s.product_code and 
g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002
GROUP BY s.date
order by s.date asc

-- TASK 2 Completed



-- TASK 2 : with the help of stored procedure

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_for_any_customer`(
	IN in_C_code INT 
)
BEGIN
	SELECT s.date, SUM(g.gross_price*s.sold_quantity) as gross_price_total
	FROM fact_sales_monthly s
	JOIN fact_gross_price g 
	ON g.product_code = s.product_code and 
	g.fiscal_year = get_fiscal_year(s.date)
	where customer_code = in_C_code
	GROUP BY s.date
	order by s.date asc
END


-- Stored procedure for customer having two codes like the one with Amazon in India having
-- two customer codes
-- so to get aggregated monthly gross sales for those customers
-- use both the codes 

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthy_gross_sales_forCustomer_withTwoCodes`(
	IN in_customer_codes TEXT
)
BEGIN
	SELECT s.date, SUM(g.gross_price*s.sold_quantity) as gross_price_total
	FROM fact_sales_monthly s
	JOIN fact_gross_price g 
	ON g.product_code = s.product_code and 
	g.fiscal_year = get_fiscal_year(s.date)
	where find_in_set(s.customer_code, in_customer_codes) > 0
	GROUP BY s.date
	order by s.date asc
END
