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

-- Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. 
-- Ketty doesn't want the NAMES of those students who received a grade lower than 8. 
-- The report must be in descending order by grade -- i.e. higher grades are entered first. 
-- If there is more than one student with the same grade (8-10) assigned to them, order those 
-- particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and 
-- list them by their grades in descending order. If there is more than one student with 
-- the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

-- Tables - Students, Grades
-- Columns - Name, Grades, Mark
-- Grade < 8 'Null' (Name)
-- Order by grade, if grade >= 8 order by name, grade<8 order by marks ascending

select 
    case
        when g.grade <8 then null
        else s.name 
    end as student_name, 
    g.grade, s.marks
from students s
join grades g
    on s.marks between g.min_mark and g.max_mark
order by g.grade desc,
    case
        when g.grade >= 8 then s.name
        else null
    end asc,
    case 
        when g.grade < 8 then s.marks
        else null
    end asc;


-- Julia just finished conducting a coding contest, 
-- and she needs your help assembling the leaderboard! 
-- Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
-- Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
-- If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

-- Tables - Hackers, Difficulty, Challenges, Submissions
-- Columns - h.hacker_id, h.name
-- Full scores - submissions/ difficulty

-- -- Process
-- select submissions.challenge_id 
-- join challenges.challenge_id
-- join difficulty.difficulty_level - see if the score is perfect
-- then return hacker_id, and hacker name

SELECT 
    h.hacker_id, 
    h.name
FROM hackers h
JOIN submissions s
    ON h.hacker_id = s.hacker_id
JOIN challenges c
    ON s.challenge_id = c.challenge_id
JOIN difficulty d
    ON c.difficulty_level = d.difficulty_level
WHERE s.score = d.score
GROUP BY h.hacker_id, h.name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC, h.hacker_id ASC;

-- Triangle or not question

select
    case
        when a + b <= c or a + c <= b or b + c <= a then 'Not A Triangle'
        when a = b and b = c then 'Equilateral'
        when a = b or b = c or a = c then 'Isosceles'
        else 'Scalene'
    end as triangle_type
from Triangles;


/*
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand 
of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, 
sorted in order of descending power.
 If more than one wand has same power, sort the result in order of descending age.
*/

select 
    w.id, 
    wp.age, 
    w.coins_needed, 
    w.power
from wands w
join wands_property wp
    on w.code = wp.code
where wp.is_evil = 0
    and w.coins_needed = (
        select min(w2.coins_needed)
        from wands w2
        join wands_property wp2
            on w2.code = wp2.code
        where wp2.is_evil = 0
          and w2.power = w.power
          and wp2.age = wp.age
    )
order by 
    w.power desc, 
    wp.age desc;

    
    