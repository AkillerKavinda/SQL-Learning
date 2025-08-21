-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.

select distinct city 
from station
where 
    city like 'A%'
    or city like 'E%'
    or city like 'I%'
    or city like 'O%'
    or city like 'U%';
    
-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

select distinct city
from station
where 
    city like '%a'
    or city like '%e'
    or city like '%i'
    or city like '%o'
    or city like '%u';

select distinct city
from station
where city like 'A%a'
    or city like 'A%e'
    or city like 'A%i'
    or city like 'A%o'
    or city like 'A%u'
    or city like 'E%a'
    or city like 'E%e'
    or city like 'E%i'
    or city like 'E%u'
    or city like 'I%a'
    or city like 'I%e'
    or city like 'I%i'
    or city like 'I%u'
    or city like 'O%a'
    or city like 'O%e'
    or city like 'O%i'
    or city like 'O%o'
    or city like 'O%u';

-- -- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.

select distinct city
from station
where upper(substr(city, 1, 1)) in ('A', 'E', 'I', 'O','U')
            and upper(substr(city, length(city),1)) in ('A', 'E', 'I', 'O', 'U');

-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

select distinct city
from station
where upper(substr(city, 1, 1)) not in ('A', 'E', 'I', 'O', 'U');

-- Cities with no vowel letters

SELECT DISTINCT city
FROM station
WHERE city NOT LIKE '%a%'
  AND city NOT LIKE '%e%'
  AND city NOT LIKE '%i%'
  AND city NOT LIKE '%o%'
  AND city NOT LIKE '%u%'
  AND city NOT LIKE '%A%'
  AND city NOT LIKE '%E%'
  AND city NOT LIKE '%I%'
  AND city NOT LIKE '%O%'
  AND city NOT LIKE '%U%';

SELECT DISTINCT city
FROM station
WHERE city NOT REGEXP '[aeiouAEIOU]';

-- Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.

select distinct city
from station
where upper(substr(city, length(city), 1)) not in ('A', 'E', 'I', 'O', 'U');

-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.

-- Include cities where first or last letters are NOT vowels	
select distinct city
from station
where upper(substr(city, 1, 1)) not in ('A', 'E', 'I', 'O', 'U')
        or upper(substr(city, length(city), 1)) not in ('A', 'E', 'I', 'O', 'U');
        
select distinct city
from station
where upper(substr(city, 1, 1)) not in ('A', 'E', 'I', 'O', 'U')
        and upper(substr(city, length(city), 1)) not in ('A', 'E', 'I', 'O', 'U');

-- Akila, Akil, Kila
-- And doesn't include anything
-- Or incldues Akil and kila

-- In
SELECT city
FROM station
WHERE city IN ('New York', 'Los Angeles', 'Chicago');


-- Exists

SELECT city
FROM station s
WHERE EXISTS (
  SELECT 1
  FROM orders o
  WHERE o.city = s.city
);

-- Union removes duplicates
-- Union all does not remove duplicates

-- Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.

select name 
from students
where marks > 75
order by right(name, 3), id; -- Sorts by the last three letters of names. And if they match, sorts by id. 

-- Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than  per month who have been employees for less than  months. Sort your result by ascending employee_id.

select name
from Employee
where salary > 2000
and months < 10
order by employee_id;

-- Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

select sum(c.population)
from city c
join country coun
on c.countrycode = coun.code
where coun.continent = 'Asia';

-- Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

select c.name
from city c
join country cn
on c.countrycode = cn.code
where cn.continent = 'Africa';

-- Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.


select cn.continent, floor(avg(c.population))
from country cn
join city c
on c.countrycode = cn.code
group by cn.continent;

-- Round - Rounds to the nearest decimal
-- Floor - Rounds to the integer below


