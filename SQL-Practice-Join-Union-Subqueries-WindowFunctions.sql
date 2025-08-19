select * from parks_and_recreation.employee_demographics;

select * from employee_demographics;

select* from employee_salary;

select * from parks_departments;

select * from employee_salary;

select * from employee_salary 
where salary > 70000;

select * from employee_salary
where salary > 70000 and last_name like '%a%';

select * from employee_salary
order by salary desc;

select occupation, avg(salary) from employee_salary
group by occupation;

select * from employee_salary;

select * from employee_demographics;

-- Joining multiple tables
select * from employee_demographics
inner join employee_salary 
on employee_demographics.employee_id = employee_salary.employee_id
join parks_departments
on employee_salary.dept_id = parks_departments.department_id;

-- Self Join
select emp1.employee_id as emp_santa, emp1.first_name as santa_first_name, emp1.last_name as santa_last_name, emp2.first_name, emp2.last_name
from employee_salary emp1
join employee_salary emp2
on emp1.employee_id + 1 = emp2.employee_id;


-- Unions

select * from employee_demographics;
select * from employee_salary;
select * from parks_departments;

select * from employee_demographics emp1 union select * from employee_salary;
select employee_id, last_name from employee_salary union select department_id, department_name from parks_departments;

select * from employee_salary;
select * from parks_departments;

select first_name, last_name from employee_demographics union 
select occupation, salary from employee_salary;

select first_name, last_name from employee_demographics 
union
select first_name, last_name from employee_salary;

select first_name, last_name from employee_demographics 
union all
select first_name, last_name from employee_salary;

select first_name, last_name, 'Old Lady' as label
from employee_demographics where age > 40 and gender = 'Female'
union
select first_name, last_name, 'Old Man' as label 
from employee_demographics where age > 40 and gender = 'Male'
union
select first_name, last_name, 'Highly Paid Dude'
from employee_salary where salary > 70000;

-- String Functions

select* from employee_demographics;

select length("How");
select length("How ");

select first_name, length(first_name)
from employee_demographics;

select upper("How");
select lower("How");
select trim(" How ");
select ltrim(" How");
select rtrim("How ");

select right("Name", 4);
select left("Name", 4);
select substring("Alexandara", 2, 3);

select * from employee_demographics;
select birth_date, substring(birth_date, 1, 4) as birth_year
from employee_demographics;

select replace(first_name, "l","z")
from employee_demographics;

select replace(first_name, "z", "l")
from employee_demographics;

select locate('e', 'Alexander');
select first_name, locate('e',first_name) from employee_demographics;

select concat(first_name, ' ', last_name) as full_name
from employee_demographics;

-- Case statements
select first_name, last_name, age,
case
	when age > 40 then 'Old'
    when age > 20 then 'Young'
    else 'Minor'
end as age
from employee_demographics;

select * from employee_demographics;
select * from employee_salary;
select * from parks_departments;

select first_name, last_name, 
case
	when age > 40 then 'Old'
    when age > 20 then 'Young'
    else 'Minor'
end as Age
from employee_demographics;

select first_name, last_name,
case
	when salary > 45000 then salary + (salary * 0.5)
    when salary > 60000 then salary + (salary * 0.3)
end as new_salary,
case
	when dept_id= 6 then salary + (salary * 0.1)
end as bonus
from employee_salary;

-- Subqueries

select * from employee_salary
where salary > (select avg(salary) from employee_salary);

select * from employee_demographics;
select * from employee_salary;
select * from parks_departments;

select * from employee_demographics
where employee_id in (select employee_id from employee_salary where dept_id=1);

select first_name, salary, (select avg(salary) from employee_salary)
from employee_salary;

select * from
(select gender, min(age), max(age), count(age), avg(age)
from employee_demographics
group by gender) agg_table;

select gender, min(age), max(age), count(age), avg(age)
from employee_demographics
group by gender;

select gender, avg(min_age), avg(max_age)
from 
(select gender, min(age) min_age, max(age) max_age, count(age), avg(age)
from employee_demographics
group by gender) agg_table
group by gender;

select avg(min_age), avg(max_age), avg(count_age), avg(avg_age)
from (select gender, min(age) min_age, max(age) max_age, count(age) count_age, avg(age) avg_age
from employee_demographics
group by gender) agg_table;

-- Window functions

select gender, avg(salary) as avg_salary
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
group by gender;

select gender, avg(salary) over() as overall_avg
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

select gender, avg(salary) over(partition by gender) as overall_avg
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

select dem.first_name, dem.last_name, gender, avg(salary) over ()
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

select dem.first_name, dem.last_name, gender, avg(salary) over (partition by gender)
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

select dem.first_name, dem.last_name, gender, avg(salary) as avg_salary
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
group by dem.first_name, dem.last_name, gender;

select * from employee_salary;

select dem.first_name, dem.last_name, gender, sum(salary)
over (partition by gender)
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

select dem.first_name, dem.last_name, gender, sum(salary)
over (partition by gender order by dem.employee_id) as rolling_total
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over () as row_num,
rank() over () as rank_num,
dense_rank() over () as dense_rank_num
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;


select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over (order by salary desc) as row_num,
rank() over ( order by salary desc) as rank_num,
dense_rank() over (order by salary desc) as dense_rank_num
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over (partition by gender order by salary desc) as row_num,
rank() over (partition by gender order by salary desc) as rank_num,
dense_rank() over (partition by gender order by salary desc) as dense_rank_num
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;





