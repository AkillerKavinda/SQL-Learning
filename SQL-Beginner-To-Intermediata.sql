-- SELECT 

select * from employee_demographics;

select employee_id, first_name, age + 10
from employee_demographics;

select DISTINCT  first_name
from employee_demographics;

select * from employee_demographics;
select * from employee_salary;
select * from parks_departments;

-- WHERE

select * from employee_demographics
where age > 30;

select * from employee_demographics
where gender = "Male";

select * from employee_demographics
where birth_date > '1986-01-01';

select * from employee_demographics
where first_name != "Tom";

select * from employee_demographics
where first_name like '%a';

select * from employee_demographics
where first_name like 'a_%';

select * from employee_demographics
where last_name like '%w%';

select gender from employee_demographics
group by gender;

select * from employee_salary;

select occupation from employee_salary
group by occupation;

select * from employee_salary;

select distinct first_name from employee_salary;

select * from employee_salary;

select * from employee_demographics;

-- GROUP BY

select gender from employee_demographics
group by gender;

select occupation, salary 
from employee_salary
group by occupation, salary;

select * from employee_demographics;

select gender, avg(age)
from employee_demographics
group by gender;

SELECT gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender;

-- Order By

select * from employee_demographics;

select *
from employee_demographics
order by first_name;

select * 
from employee_demographics
order by first_name desc;

select *
from employee_demographics
order by gender, age;

select * from employee_demographics
order by gender desc, age desc;

select gender, avg(age)
from employee_demographics
group by gender
having avg(age)>40;

-- Limits and aliasing

select * from employee_demographics
order by first_name;

select * from employee_demographics
order by first_name
limit 3;

select * from employee_demographics
order by first_name
limit 3, 2;

select gender, avg(age) as Avg_Age
from employee_demographics
group by gender
having Avg_Age > 40;

-- Joins

select * from employee_demographics;
select * from employee_salary;

select * from employee_demographics
join employee_salary
on employee_demographics.employee_id = employee_salary.employee_id;

select * from employee_demographics dem
inner join employee_salary sal
on dem.employee_id = sal.employee_id;


select * from employee_demographics dem
left join employee_salary sal
	on dem.employee_id=sal.employee_id;

select * from employee_demographics dem
right join employee_salary sal
on dem.employee_id = sal.employee_id;

select * from employee_salary;

select * from employee_salary emp1
join employee_salary emp2
on emp1.employee_id=emp2.employee_id;

select * from employee_salary emp1
join employee_salary emp2
on emp1.employee_id + 1 = emp2.employee_id; 
-- Giver and Receiver

SELECT emp1.employee_id as emp_santa, emp1.first_name as santa_first_name, emp1.last_name as santa_last_name, emp2.employee_id, emp2.first_name, emp2.last_name
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1  = emp2.employee_id;
    
select * 
from employee_demographics dem
inner join employee_salary sal
	on dem.employee_id = sal.employee_id
join parks_departments dept
	on dept.department_id = sal.dept_id;

select * from employee_salary;
select * from parks_departments;

SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept
	ON dept.department_id = sal.dept_id;
    
-- Unions

select first_name, last_name
from employee_demographics
union
select occupation, salary
from employee_salary;

select first_name, last_name
from employee_demographics
union
select first_name, last_name
from employee_salary;

SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary;

select first_name, last_name
from employee_demographics
union all
select first_name, last_name
from employee_salary;	

select first_name, last_name, 'old'
from employee_demographics
where age > 50;


select first_name, last_name, "Old Lady"
from employee_demographics
where age > 40 and gender = 'Female'
union
select first_name, last_name, "Old Man"
from employee_demographics 
where age > 40 and gender = 'Male'
union
select first_name, last_name, "Highly Paid Dude"
from employee_salary
where salary > 70000
order by first_name;

-- String functions

select length("Sky blue is very beautiful");

select first_name, length(first_name) as length_of_the_first_name
from employee_demographics;

select upper("How are you?");

select trim("      How are you   ");

SELECT LTRIM('     I           love          SQL');

SELECT RTRIM('I love SQL    ');

SELECT LEFT('Alexander', 4);

SELECT SUBSTRING('Alexander', 2, 3);

select * from employee_demographics;

select birth_date, substring(birth_date, 1, 4) as birth_year
from employee_demographics;

select replace(first_name, 'a', 'z')
from employee_demographics;

select replace(first_name, 'z', 'a')
from employee_demographics;

select locate('x', 'alexandra');
select locate('e', 'alexandre');

select first_name, locate('a', first_name)
from employee_demographics;

select concat("Alexandra", " Daddario");


select first_name, last_name,
case
	when age > 30 then "Old"
end
from employee_demographics;

select first_name, last_name,
case
	when age <= 30 then "Young"
    when age between 31 and 50 then "Old"
    when age >=51 then "Dead"
end
from employee_demographics;

select first_name, last_name, salary,
case
	when salary > 45000 then salary + (salary * 0.05)
    when salary < 45000 then salary + (salary * 0.07)
end as new_salary,
case
	when dept_id = 6 then salary * 0.10
end as bonus
from employee_salary;


-- Subqueries

select * from
employee_demographics 
where employee_id in(
				select employee_id from employee_salary
					where dept_id=1);
                    
select * from 
employee_demographics
where employee_id in (select employee_id, salary from employee_salary where dept_id=3);

-- Can't do this because we are using the in operator

select first_name, salary, avg(salary)
from employee_salary
group by first_name, salary;

select first_name, salary,(select avg(salary) from employee_salary) from employee_salary;


select * from (
	select gender, min(age), max(age), count(age), avg(age)
    from employee_demographics
    group by gender
) as aggtable;

SELECT gender, AVG(Min_age)
FROM (SELECT gender, MIN(age) Min_age, MAX(age) Max_age, COUNT(age) Count_age ,AVG(age) Avg_age
FROM employee_demographics
GROUP BY gender) AS Agg_Table
group by gender;


-- Window Functions

select gender, avg(salary) as avg_salary
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender;

SELECT dem.gender, sal.salary, AVG(sal.salary) OVER () 
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

SELECT dem.gender, sal.salary, AVG(sal.salary) OVER (partition by gender) 
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;
    
select dem.first_name, dem.last_name, gender, avg(salary) over (partition by gender)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;
    
select dem.first_name, dem.last_name, gender, sum(salary) over (partition by gender)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;

-- Windows function - running total

select dem.first_name, dem.last_name, gender,sum(salary) over (partition by gender order by dem.employee_id) as running_total
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;
    
-- Row Num / Rank / Dense Rank 

select dem.employee_id, dem.first_name, dem.last_name, gender, salary, 
row_number() over (partition by gender order by salary desc) as row_num,
rank() over (partition by gender order by salary desc) rank_num, 
dense_rank() over (partition by gender order by salary desc) dense_rank_num
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;