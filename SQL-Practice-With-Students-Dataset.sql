-- View the table

select * from student_grades;

select * from students;


-- Show students who get lunch

select * from students
where school_lunch="Yes";

-- Sort the students by GPA

select * from students
order by gpa desc;

-- Show the average gpa for each grade level

select grade_level, avg(gpa)
from students
group by grade_level;

-- Show the grade levels with an average gpa below 3.3

select grade_level, avg(gpa)
from students
group by grade_level
having avg(gpa) < 3.3;

-- Show all the students who got lunch and had a gpa more than 3.3

select * from students;

select * from students
where school_lunch = 'Yes' and gpa > 3.3;

-- Count the students who got lunch and had a gpa more than 3.3

select count(*) from students
where school_lunch = 'Yes' and gpa > 3.3;

-- Order unique GPA values

select distinct gpa 
from students;

-- Join the students_grades and students

select * from students;
select * from student_grades;

select s.id, s.student_name, sg.class_name, sg.final_grade
from students s
left join student_grades sg
on s.id = sg.student_id;


