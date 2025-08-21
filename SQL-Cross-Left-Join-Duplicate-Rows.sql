select * from students;
select * from examinations;
select * from subjects;

select * from students
cross join subjects;

select s.student_id, s.student_name, sub.subject_name, sub.subject_id, e.exam_id
from students s
cross join subjects sub
left join examinations e
on s.student_id = e.student_id; --If there are multiple matches in the right table, SQL creates one output row for each match.

/*
What LEFT JOIN tells SQL:

Start with all rows from the left table.

	SQL will keep every single row from the left table, no matter what.

Look in the right table for matching rows based on the ON condition.

	Matching means: the columns you compare (e.g., left_table.id = right_table.id) are equal.

Attach matching right table data to the left row.

	If there is no match, SQL fills the right table columns with NULL.

If there are multiple matches in the right table, SQL creates one output row for each match.
*/

select s.student_id, s.student_name, sub.subject_name, sub.subject_id, e.exam_id
from students s
cross join subjects sub
left join examinations e
on s.student_id = e.student_id and sub.subject_id = e.subject_id;

-- Important concept to remember when using left and right joins,

-- 1. Start with all rows from the left table

-- Look for matches in the right table using the ON condition.

-- Attach matching right table rows.
	-- If multiple matches exist → multiple output rows.
	-- If no match → NULLs in left table columns.


-- Multiple matches in the “starting” table → duplicate rows

