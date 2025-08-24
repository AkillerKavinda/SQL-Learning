-- 1. View the table

select * from sales;

-- 2. Preview the final results

select * from final_sales;

-- 3. Select a series of dates (Union, union all)

select '2025-01-01' as dt
union 
select '2025-01-02'
union 
select '2025-01-02';

select '2025-01-01' as dt
union all
select '2025-01-02'
union all
select '2025-01-03'
union all
select '2025-01-04'
union all
select '2025-01-05'
union all
select '2025-01-06'
union all
select '2025-01-07';

-- 4. Join with our original table (subquery, left join, inner join)
select sq.dt, sales.num_sales 
from 

(select '2025-01-01' as dt
union all
select '2025-01-02'
union all
select '2025-01-03'
union all
select '2025-01-04'
union all
select '2025-01-05'
union all
select '2025-01-06'
union all
select '2025-01-07') sq

left join sales on sq.dt = sales.dt;

-- Rewrite our subquery as a CTE

with cte as (select '2025-01-01' as dt
union all
select '2025-01-02'
union all
select '2025-01-03'
union all
select '2025-01-04'
union all
select '2025-01-05'
union all
select '2025-01-06'
union all
select '2025-01-07') 

select cte.dt, sales.num_sales
from cte left join sales on cte.dt= sales.dt;

-- Rewrite our current cte as a recursive cte

with recursive cte as (select cast('2025-01-01' as date) as dt
						union all
						select dt + interval 1 day 
                        from cte
                        where dt < cast('2025-01-07' as date)
) 
select cte.dt, sales.num_sales
from cte left join sales on cte.dt= sales.dt;

-- Fill in the null values (NULL Function, Numeric Function)
with recursive cte as (select cast('2025-01-01' as date) as dt
						union all
						select dt + interval 1 day 
                        from cte
                        where dt < cast('2025-01-07' as date)
) 
select cte.dt, sales.num_sales,
		coalesce(sales.num_sales, 0) as sales_estimate,
        coalesce(sales.num_sales, round((select avg(sales.num_sales) from sales), 1)) as sales_estimate_2
from cte left join sales on cte.dt= sales.dt;

-- Window Functions (Windows - Rows of data)

select dt, num_sales,
		row_number() over () as row_num,
        lag(num_sales) over () as prev_num_sales,
        lead(num_sales) over () as next_num_sales
from sales;	


-- Add on two window functions (When there is a null, look at the prior value and next value and take their average)
with recursive cte as (select cast('2025-01-01' as date) as dt
						union all
						select dt + interval 1 day 
                        from cte
                        where dt < cast('2025-01-07' as date)
) 
select cte.dt, sales.num_sales,
		coalesce(sales.num_sales, 0) as sales_estimate,
        coalesce(sales.num_sales, round((select avg(sales.num_sales) from sales), 1)) as sales_estimate_2,
        coalesce(sales.num_sales, round(lag(sales.num_sales) over() + lead(sales.num_sales) over()/2)) as sales_estimate_3

from cte left join sales on cte.dt= sales.dt;

-- Cleaning up the final query 

with recursive cte as (select cast('2025-01-01' as date) as dt
						union all
						select dt + interval 1 day 
                        from cte
                        where dt < cast('2025-01-07' as date)
) 
select cte.dt,
        coalesce(sales.num_sales, round(lag(sales.num_sales) over() + lead(sales.num_sales) over()/2)) as sales_estimate_3
from cte left join sales on cte.dt= sales.dt;
