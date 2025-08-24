-- Window Functions

-- View the table

select * from baby.baby_names;

-- Order by popularity

select * from baby_names
order by total desc;

-- Add a popularity column

select gender, name, total, 
		row_number() over (order by total desc) as popularity 
 from baby_names
;

-- Window is how you wanna be viewing your data when you are applying your function. 

-- Try different functions

select 
    gender, 
    name, 
    total,

    -- ranking functions
    row_number() over (order by total desc) as popularity,
    rank() over (order by total desc) as popularity_r,
    dense_rank() over (order by total desc) as popularity_d,

    -- value functions
    first_value(name) over (order by total desc) as first_name,
    lead(name) over (order by total desc) as next_name,
    lag(name) over (order by total desc) as previous_name,

    -- distribution functions
    percent_rank() over (order by total desc) as percent_rank_val,
    cume_dist() over (order by total desc) as cume_dist_val,
    ntile(4) over (order by total desc) as quartile  -- splits into 4 buckets

from baby_names;



-- Using partition by 

select gender, name, total, 
		row_number() over (partition by gender order by total desc) as popularity 
 from baby_names
;

-- What are the top 3 most popular names for each gender
select * from
(select gender, name, total, 
		row_number() over (partition by gender order by total desc) as popularity 
 from baby_names) as pop
 where popularity <=3;
