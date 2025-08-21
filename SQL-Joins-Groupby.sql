select * from students;
select * from examinations;
select * from subjects;
select * from teachers;

-- Inner Join
select s.student_name, e.exam_id, e.score
from students s
join examinations e
on s.student_id = e.student_id;

-- Left Join
select s.student_name, e.exam_id
from students s
left join examinations e
on s.student_id = e.student_id;

-- Right Join
select * from examinations;

select e.exam_id,s.student_name 
from students s
right join examinations e
on s.student_id = e.student_id;

-- Joining multiple joins
select * from students;

select * from examinations;

select * from subjects;

select * from teachers;

-- Let's say we want to get the student_name, examination_id, Subject_name, Teacher_name

select s.student_name, e.exam_id, e.score, sub.subject_name, t.teacher_name
from students s
left join examinations e on s.student_id = e.student_id
left join subjects sub on e.subject_id = sub.subject_id
left join teachers t on e.teacher_id = t.teacher_id ;

-- List all students who have taken at least one exam. Show student_name and score.

select s.student_name, count(e.exam_id) as exam_count
from students s
left join examinations e
on s.student_id = e.student_id
group by s.student_name
having count(e.exam_id) >= 1;

-- In PostGRE SQL you cannot use the Alias in having clause. But in MYSQl you can. 
-- You cannot use aliases with where and having
-- MySQl with where we can't. But with having we can. 


-- Full Outer Join (Inner Join + All remaining rows from the (left join + right join))
select s.student_name, e.exam_id, e.score
from students s
full outer join examinations e
on s.student_id = e.student_id;

-- Cross join

select s.student_name, sub.subject_name
from students s
cross join subjects sub;

-- Self join

select s.student_name, l.student_name as santa_name
from students s
join students l
on s.student_id + 1  = l.student_id;

select s.student_name, l.student_name as santa_name
from students s
join students l
on s.student_id - 1  = l.student_id;

-- Group By

--Count how many exams each student took.
select s.student_id, count(exam_id)
from students s 
left join examinations e
on s.student_id = e.student_id
group by s.student_id
order by s.student_id;

-- Count exams per student per subject.

select * from students;
select * from examinations;
select * from subjects;

select s.student_name, count(exam_id) as num_of_exams
from students s
left join examinations e
on s.student_id = e.student_id
group by s.student_name;


-- Exams per subject
select * from examinations;

select e.student_id, e.subject_id, count(e.subject_id)
from examinations e
left join subjects sub
on e.subject_id = sub.subject_id
group by e.student_id, e.subject_id
order by e.student_id;

-- Count exams per student per subject.

SELECT 
    s.student_name, 
    sub.subject_name, 
    s.student_id,
    COUNT(e.subject_id) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
    ON s.student_id = e.student_id
   AND sub.subject_id = e.subject_id
GROUP BY s.student_name, sub.subject_name, s.student_id
ORDER BY s.student_name, sub.subject_name;


-- List all students who have taken at least one exam.

select * from students;
select * from examinations;

-- Find the tables needed - students and examinations
-- Find the columns needed - s.student_name, 
-- What join is needed - left
-- Find the aggregations needed - count(exam_id)
-- Group By - student_id
-- Filter - where count(exam_id) > = 1

select s.student_id, s.student_name, count(e.exam_id) exam_count
from students s
left join examinations e
on s.student_id = e.student_id
group by s.student_id, s.student_name
having count(e.exam_id) >= 2
order by s.student_id;


-- Show all exams with student names and subject names.

-- Tables - students, subjects
-- Columns - student_name, subject_name, exam_id
-- Join - student_id, subject_id

select * from examinations;

select e.exam_id, s.student_name, sub.subject_name
from examinations e
left join students s
on e.student_id = s.student_id
left join subjects sub
on e.subject_id = sub.subject_id;

select e.exam_id, s.student_name, sub.subject_name
from examinations e
join students s
on e.student_id = s.student_id
join subjects sub
on e.subject_id = sub.subject_id;

-- Count exams per student (exclude students with 0 exams).

-- Tables - students, examinations
-- Columns - student_name, count(exam_id)
-- Join - left join
-- Group by - student_name
-- Having count(exam_id) >= 1

select s.student_id, s.student_name, count(e.exam_id) exam_count
from students s
join examinations e
on s.student_id = e.student_id
group by s.student_id, s.student_name -- To avoid issues if two students have the same name
order by s.student_name;

select s.student_id, s.student_name, count(e.exam_id) exam_count
from students s
left join examinations e
on s.student_id = e.student_id
group by s.student_id, s.student_name
having count(e.exam_id)>=1
order by s.student_name;

-- Find all subjects that have at least one student enrolled.

-- Tables - subjects, examinations
-- Columns - subject_id, subject_name, count(student_id)
-- Join - inner
-- aggregate - count
-- group by - 
-- having

select * from subjects;

select sub.subject_id, sub.subject_name, count(e.exam_id) as student_count
from subjects sub
left join examinations e
on sub.subject_id = e.subject_id
group by sub.subject_id, sub.subject_name
having count(e.exam_id)>=1
order by sub.subject_id;


select subject_id, count(student_id)
from examinations
group by subject_id;

-- Show students and their total number of exams per subject

-- Tables - examinations
-- Columns - student_id, count(exam_id)
-- Group by - student_id

select student_id, count(exam_id)
from examinations
group by student_id
order by student_id;

-- Tables - students, examinations
-- Columns - student_id, count(exam_id) as examination_count
-- Join - left 
-- Group by - student_id

select s.student_id, s.student_name, count(e.exam_id)
from students s
left join examinations e
on s.student_id = e.student_id
group by s.student_id, s.student_name;

-- Show students and their total number of exams per subject

-- Tables - students, examinations
-- Columns - student_id, student_name, subject_id, count(exam_id)
-- Group by - student_id, student_name, subject_id

select * from examinations;

select student_id, subject_id, count(subject_id)
from examinations
group by student_id, subject_id
order by student_id, subject_id;

select s.student_id, s.student_name, count(e.subject_id)
from students s
left join examinations e
on s.student_id = e.student_id
group by s.student_id, s.student_name;

-- Students × Subjects including 0 exams

-- Tables - students, examinations
-- Columns - dtudent_id, student_name, subject_id, 

select s.student_id, s.student_name, sub.subject_name
from students s
cross join subjects sub;

select s.student_id, s.student_name, sub.subject_name, count(e.subject_id)
from students s
cross join subjects sub
left join examinations e
on s.student_id = e.student_id
group by s.student_id, s.student_name, sub.subject_name;

select s.student_id, s.student_name, sub.subject_name, count(e.subject_id)
from students s
cross join subjects sub
left join examinations e
on s.student_id = e.student_id and sub.subject_id = e.subject_id
group by s.student_id, s.student_name, sub.subject_name;

