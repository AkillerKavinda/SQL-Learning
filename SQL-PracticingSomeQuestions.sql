select * from orders;

-- 1. Find top 3 outlets by cuisine type without using limit and top function

with cte as (
	select cuisine, restaurant_id, count(*) as countOfOrders
	from orders
	group by cuisine, restaurant_id
)
select * 
	from (select *, row_number() over(partition by cuisine order by countOfOrders desc) as rn
				from cte) a
where rn = 1
;

-- 2. Find the numbers of new customers that we are acquiring everyday from the launch date
with cte as(
select customer_code, cast(min(placed_at) as date) as first_order_date
from orders
group by customer_code
order by first_order_date)

select first_order_date, count(*) as num_of_new_customers
from cte
group by first_order_date
order by first_order_date;

-- We can also use row_number, rn = 1 and get the answer. The idea is that get the first_order_date, group it,
-- and counting the number of new customers

-- 3. Count of all the users who were acquired in Jan 2025 and only placed one order in jan and did not place 
-- any other order

select * from orders;

with cte as (select customer_code, count(*) as jan_order_count, min(placed_at::date)
from orders
where extract(month from placed_at) = 1
group by customer_code
having count(*) = 1)

select * from cte
where customer_code not in( 
		select customer_code from(
				select customer_code, min(placed_at::date)
				from orders
				where not (extract(month from placed_at) = 1)
				group by customer_code) a)
