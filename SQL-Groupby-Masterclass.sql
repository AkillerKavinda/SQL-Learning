CREATE DATABASE my_database;
USE my_database;

select * from walmart sales group by dataset;
RENAME TABLE `my_database`.`walmart sales group by dataset` 
TO `my_database`.`walmart_sales`;

select * from walmart_sales;

-- ---------------------------------------------
-- Business Problems :: Basic Level
-- ---------------------------------------------

-- Q.1 Find the total sales amount for each branch

select * from walmart_sales;

select sum(total)
from walmart_sales;

select count(total)
from walmart_sales;

select distinct branch
from walmart_sales;

select branch, total
from walmart_sales;

select branch, sum(total) 
from walmart_sales
group by branch;

-- We use group by with sum, count, mix, max, average

-- Q.2 Calculate the average customer rating for each city.
select * from walmart_sales;

select city, avg(rating) avg_rating
from walmart_sales
group by city
order by avg_rating desc;

-- Q.3 Count the number of sales transactions for each customer type.
select * from walmart_sales;

select count(*) from walmart_sales;

select customer_type, count(total) as sales_transactions
from walmart_sales
group by customer_type;

-- Q.4 Find the total quantity of products sold for each product line.

select * from walmart_sales;

select product_line, sum(quantity)
from walmart_sales
group by product_line;

-- Q.5 v1 Calculate the total VAT collected for each payment method.

select * from walmart_sales
limit 5;

select payment_method, sum(vat)
from walmart_sales
group by payment_method;

-- ---------------------------------------------
-- Business Problems :: Medium Level
-- ---------------------------------------------

-- Q.6 Find the total sales amount and average customer rating for each branch.

select * from walmart_sales;

select branch Branch, sum(total) Total_Sales, avg(rating) Average_Rating
from walmart_sales
group by branch;

-- Q.6 Calculate the total sales amount for each city and gender combination.

select * from walmart_sales
limit 1;

select city, gender, sum(total)
from walmart_sales
group by city, gender;

-- Q.7 Find the average quantity of products sold for each product line to female customers.

select * from walmart_sales
limit 1;

select product_line, avg(quantity) Average_Quantity_Sold
from walmart_sales
where gender='female'
group by product_line;

-- Q.8 Count the number of sales transactions for members in each branch.

select * from walmart_sales
limit 1;

select branch, count(total) 
from walmart_sales
where customer_type="Member"
group by branch;

-- Q.9 Find the total sales amount for each day. (Return day name and their total sales order DESC by amt)

select * from walmart_sales
limit 1;

select date from walmart_sales;

SELECT date, sum(total), DAYNAME(date) AS day_name
FROM walmart_sales
group by day_name;

SELECT DAYNAME(date) AS day_name, SUM(total) AS total_sum
FROM walmart_sales
GROUP BY day_name
order by total_sum desc;

-- ---------------------------------------------
-- Business Problems :: Advanced Level
-- ---------------------------------------------

-- Q.10 Calculate the total sales amount for each hour of the day

select * from walmart_sales;

select hour(time) as hour, sum(total) as total_sum
From walmart_sales
group by hour
order by total_sum;

select minute(time) as minute, sum(total) as total_sum
From walmart_sales
group by 1
order by 2;

-- Q.11 Find the total sales amount for each month. (return month name and their sales)

select * from walmart_sales;

select monthname(date) as month, sum(total)
from walmart_sales
group by 1
order by 2;

-- Q.12 Calculate the total sales amount for each branch where the average customer rating is greater than 8.

select * from walmart_sales;

select branch, sum(total), avg(rating)
from walmart_sales
group by branch;

select branch, sum(total), avg(rating) average_rating
from walmart_sales
group by branch
having average_rating > 7;

select branch, sum(total), avg(rating) average_rating
from walmart_sales
where branch <> 'c'
group by branch
having average_rating > 5;

-- Q.13 Find the total VAT collected for each product line where the total sales amount is more than 500.

select * from walmart_sales;

select product_line, sum(vat) total_vat
from walmart_sales
where total > 500
group by product_line;

-- Q.14 Calculate the average sales amount for each gender in each branch.

select branch, gender, avg(total)
from walmart_sales
group by branch, gender
order by avg(total) desc;

-- Q.15 Count the number of sales transactions for each day of the week.

select * from walmart_sales;

select dayname(date) as day, sum(total) as total_sales
from walmart_sales
group by day
order by total_sales desc;

-- Q.16 Find the total sales amount for each city and customer type combination where the number of sales transactions is greater than 50.

select * from walmart_sales;

select city, customer_type, sum(total)
from walmart_sales
group by city, customer_type
having count(*) > 50
order by sum(total) desc;

-- Q.17 Calculate the average unit price for each product line and payment method combination.

select * from walmart_sales;

select product_line, payment_method, avg(unit_price)
from walmart_sales
group by product_line, payment_method;

-- Q.18 Find the total sales amount for each branch and hour of the day combination.

select * from walmart_sales;

select branch, hour(time) as hour, sum(total) total_sales
from walmart_sales
group by branch, hour
order by total_sales desc;

-- Q.19 Calculate the total sales amount and average customer rating for each product line where the total sales amount is greater than 1000.


select * from walmart_sales;

select product_line, sum(total) total, avg(rating)
from walmart_sales
where total > 1000
group by product_line;

-- Use where when you want to filter rows before grouping.
-- Use having when you want to filter groups after grouping. 

-- Q.20 Calculate the total sales amount for morning (6 AM to 12 PM), afternoon (12 PM to 6 PM), and evening (6 PM to 12 AM) periods using the time condition.

select * from walmart_sales;

select 
	case
		when hour(time) >= 6 and hour(time) < 12 then 'morning'
        when hour(time) >=12 and hour(time) < 18 then 'afternoon'
        else 'evening'
	end as period,
	sum(total)
from walmart_sales
group by period;

