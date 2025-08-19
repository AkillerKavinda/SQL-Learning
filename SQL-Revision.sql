CREATE DATABASE company;
USE company;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    manager_id INT
);

INSERT INTO employees VALUES
(1, 'Alice', 'Johnson', 'HR', 60000, '2015-03-10', NULL),
(2, 'Bob', 'Smith', 'IT', 80000, '2017-07-22', 1),
(3, 'Charlie', 'Lee', 'Finance', 75000, '2018-01-15', 1),
(4, 'Diana', 'Garcia', 'IT', 90000, '2016-05-30', 2),
(5, 'Ethan', 'Martinez', 'Finance', 70000, '2019-11-01', 3),
(6, 'Fiona', 'Brown', 'HR', 65000, '2020-08-20', 1),
(7, 'George', 'Davis', 'IT', 85000, '2014-12-11', 2),
(8, 'Hannah', 'Wilson', 'Finance', 72000, '2016-02-28', 3);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'IT'),
(2, 'Finance'),
(3, 'HR');

ALTER TABLE employees
ADD department_id INT;

UPDATE employees
SET department_id = 1 WHERE department = 'IT';
UPDATE employees
SET department_id = 2 WHERE department = 'Finance';
UPDATE employees
SET department_id = 3 WHERE department = 'HR';

-- SELECT 

SELECT * FROM employees;

select first_name, last_name, department
from employees;

-- WHERE

select * from employees;

select first_name, last_name, salary
from employees
where salary > 75000;

-- Order By

select first_name, last_name, salary
from employees
where salary > 75000
order by salary desc;

-- Conditions (And Or)

select * from employees;

select first_name, last_name, salary
from employees
where department='IT' and salary >80000;

-- IN and Not In

select first_name, last_name, salary
from employees
where department in ("IT", "Finance");

-- Between

select first_name, last_name, salary
from employees
where salary between 70000 and 80000;

-- Order By by two columns

select first_name, last_name, department, salary
from employees
order by department, salary desc;

-- Group By

select department, avg(salary) Average_Salary
from employees
group by department;

select department, min(salary) Minimum_Salary
from employees
group by department;

select department, avg(salary) Average_Salary
from employees
group by department
having Average_Salary > 70000;

-- Limits and Aliasing

select e.first_name, e.last_name, e.salary as "Salary ($)"
from employees e
limit 5;

-- Case

select first_name, last_name, salary,
	case 
		when salary >= 85000 then 'A'
        when salary >=70000 and salary < 85000 then 'B'
        else 'C'
	end as salary_grade
from employees;

-- Joins

select * from employees;
select * from departments;

select e.first_name, e.last_name, d.department_name, e.salary
from employees e
inner join departments d
on e.department_id = d.department_id;

select e.first_name, e.last_name, d.department_name, e.salary
from employees e
inner join departments d
	on e.department_id = d.department_id;


select e.first_name, e.last_name, d.department_name, e.salary
from employees e
left join departments d
	on e.department_id = d.department_id;
    
select e.first_name, e.last_name, d.department_name, e.salary
from employees e
right join departments d
	on e.department_id= d.department_id;
    
-- Subqueries

select first_name, salary
from employees
where salary > (select avg(salary) from employees);

select first_name, salary, salary - (select avg(salary) from employees)
from employees;

select * from employees;

select department, avg_salary
from (
select department, avg(salary) avg_salary
from employees
group by department) dept_avgs
where avg_salary > 65000;

select first_name, salary
from employees
where department in (
	select department 
    from employees 
    group by department 
    having avg(salary) > 65000
);

select first_name, last_name, salary
from employees
where salary > (select avg(salary) avg_salary from employees);

select first_name, last_name, salary, salary - (select avg(salary) from employees) 
from employees;

select department, avg_salary
from (select department, avg(salary) avg_salary
		from employees 
        group by department) dep_avg
where avg_salary > 65000;

select first_name, last_name, salary
from employees
where department in 
		(select department
		from employees
        group by department 
        having avg(salary) > 65000
);

-- We can use subqueries inside where, inside from, and inside where with in

-- Write a query to display each department along with the average salary of employees in that department.

select department, avg(salary)
from (select * from employees) all_info
group by department;

-- Write a query to find the departments that have more than 2 employees, along with the number of employees in each.

select * from 
(select department, count(salary) count_employees
		from employees
		group by department) dep_count
where count_employees >2;

select * from employees;

-- Revising

select * from employees
where salary > (select avg(salary) from employees);

SELECT first_name, last_name, department
FROM employees
WHERE department IN (
    SELECT department
    FROM employees
    WHERE salary > 80000
);

select * from employees;

update employees
set salary = 80000
where employee_id = 4;

select first_name, last_name, department
from employees
where (department, salary) = (select department, salary from employees where first_name = "Bob" and last_name = "Smith");

select first_name, last_name, department, salary
from employees
where (department, salary) = (select department, salary from employees where first_name = "Bob" and last_name = "Smith");

select first_name, last_name, salary
from employees
where salary > (select avg(salary) from employees);

select first_name, last_name, salary, department
from employees e1
where salary > (select avg(salary)
				from employees e2
                where e1.department=e2.department);

select avg(salary) from employees;

select first_name, last_name, department, salary
from employees e1
where (select avg(salary) 
		from employees e2
        where e1.department=e2.department);
        
select first_name, last_name, salary, department 
from employees e1 
where salary > 
		(select avg(salary) 
        from employees e2 
        where e1.department = e2.department);
        
select first_name, last_name, salary, department from employees e1 where salary > (select avg(salary) from employees e2 where e1.department=e2.department);


select * from (select department, count(*) as emp_count
	from employees
    group by department) dep_counts
where emp_count > 2;

select * from (select department, count(*) as emp_count from employees group by department) dep_counts where emp_count > 2;
select * from (select department, count(*) as emp_count from employees group by department) dep_count where emp_count>2;
select * from (select department, count(*) as emp_count from employees group by department) dep_count where emp_count > 2;

select  * from employees where salary > (select avg (salary) from employees);
select * from employees where department in (select department from employees where salary > 80000);
select * from employees where (department, salary) = (select department, salary from employees where first_name = 'Bob' and last_name= 'Smith');

select first_name, last_name, salary, department from employees e1
where salary > (select avg(salary) from employees e2 where e1.department = e2.department);

select *
from (select department, count(salary) emp_count from employees e2 group by department) dept_counts
where emp_count > 2;

-- SQL Joins

select * from employees
join departments
on employees.employee_id = departments.department_id;

select * from employees
left join departments
on employees.department_id = departments.department_id;

select * from employees
right join departments
on employees.department_id = departments.department_id;


