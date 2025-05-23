-- TASK 3 : stored procedure for market badge 
-- to create a stored procedure that can determine market badge on following logic
-- if sold qty > 5 million, markrt is gold elase it is silver
-- I/P -> market, fiscal_year
-- O/P -> market badge

## to find sold qty based on country join fact_sales and dim_customer tables

SELECT SUM(sold_quantity) as total_qty
from fact_sales_monthly s
join dim_customer c
on s.customer_code = c.customer_code
where get_fiscal_year(s.date) = 2021 and c.market = 'India'
group by c.market

-- now creating a stored procedure from it 

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_market_badge`(
	IN in_market varchar(45),
    IN In_fiscal_year YEAR,
    OUT out_badge varchar(45)
)
BEGIN
	DECLARE qty int default 0;
    -- set deafult market to India
    If in_market='' THEN SET in_market="India";
    end if;
    -- retrieve total quantity for given market+fiscal_year
    SELECT SUM(sold_quantity) into qty
	from fact_sales_monthly s
	join dim_customer c
	on s.customer_code = c.customer_code
	where get_fiscal_year(s.date) = In_fiscal_year 
    and c.market = in_market
    group by c.market;
    -- determine market badge
    if qty > 5000000 THEN SET out_badge = 'Gold';
    else SET out_badge = 'Silver';
    end if;
END