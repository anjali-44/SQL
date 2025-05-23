-- Month
-- Product Name
-- Variant
-- Sold Quantity
-- Gross Price Per Item
-- Gross Price Total


# selecting all products for croma customer for year 2021 

select * from fact_sales_monthly
where customer_code=90002002 and 
YEAR(date)=2021
order by date desc


# converting calender year to fiscal year
SELECT * FROM fact_sales_monthly
WHERE customer_code = 90002002 and 
YEAR(DATE_ADD(date, INTERVAL 4 MONTH)) = 2021
ORDER BY date asc

## lets create a user defined sql function for this 
-- go to functions tab and click create a new function
-- created and applied lets test now

select * from fact_sales_monthly
where customer_code = 90002002 and 
get_fiscal_year(date) = 2021
order by date asc

## TASK 2 : function to get the quarter for respective FY 2021 here specifically Q4
-- lets create abother function named : get_fiscal_quarter

select * from fact_sales_monthly
where customer_code = 90002002 and 
get_fiscal_year(date) = 2021 and 
get_fiscal_quarter(date) = 'Q4'
order by date asc
limit 1000000

-- TILL HERE WE HAVE DONE MONTH AND SOLD_QTY 


-- GROSS SALES REPORT : MONTHLY PRODUCT TRANSACTIONS TO RETRIEVE REMAINING INFORMATION REQUIRED 
-- PRODUCT NAME AND VARIANT (PRESENT IN DIM PRODUCT TABLE)
-- USING JOINS AND ABBREVATIONS

SELECT s.date, s.product_code, p.product, p.variant, s.sold_quantity
FROM fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
where customer_code = 90002002 and 
get_fiscal_year(date) = 2021
order by date asc
limit 1000000

-- product name and variant done till here 

-- NOW FOCUS ON GETTING GROSS PRICE PER ITEM AND GROSS PRICE TOTAL
-- PERFORM ANOTHER JOIN

SELECT s.date, s.product_code, p.product, p.variant, s.sold_quantity, g.gross_price
FROM fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
join fact_gross_price g
on g.product_code = s.product_code and 
g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002 and 
get_fiscal_year(date) = 2021
order by date asc
limit 1000000

-- TO GET GROSS PRICE TOTAL JUST MULTIPLY GROSS PRICE AND SOLD QUANTITY

SELECT s.date, s.product_code, p.product, p.variant, s.sold_quantity, g.gross_price,
ROUND(g.gross_price*s.sold_quantity, 2) as gross_price_total
FROM fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
join fact_gross_price g
on g.product_code = s.product_code and 
g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002 and 
get_fiscal_year(date) = 2021
order by date asc
limit 1000000

## Done with task 1









