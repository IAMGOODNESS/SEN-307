-- =========================================================================
-- VUA-SEN307 Lab 5: SELECT, Filtering and Joins
-- Name: Goody Peters
-- Matric: 20231234 (or your active matric number/schema suffix)
-- =========================================================================

-- Set database context
USE sen_307; -- Update to your exact database schema name if different (e.g., sen307_20231234)


-- =========================================================================
-- Task 1: Students in one department, sorted A-Z
-- =========================================================================
-- Explanation: Joins the Student table to the Department table on dept_id, 
-- filters rows belonging exclusively to 'Software Engineering', and sorts 
-- the results alphabetically by the student's full name.

SELECT s.matric_no, s.full_name, d.dept_name
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Software Engineering'
ORDER BY s.full_name ASC;


-- =========================================================================
-- Task 2: Courses with their lecturers (INNER JOIN)
-- =========================================================================
-- Explanation: Links the Course table through the intermediate CourseAllocation 
-- table to the Lecturer table using multiple INNER JOINs. This retrieves every 
-- course title along with its assigned lecturer(s). Courses with multiple lecturers 
-- (such as Course 1) appear multiple times as separate rows.

SELECT c.course_code, c.course_title, l.full_name AS lecturer_name
FROM Course c
INNER JOIN CourseAllocation ca ON c.course_id = ca.course_id
INNER JOIN Lecturer l ON ca.lecturer_id = l.lecturer_id;


-- =========================================================================
-- Task 3: Students and their courses (LEFT JOIN)
-- =========================================================================
-- Explanation: Uses LEFT JOIN starting from Student so that all students are 
-- listed regardless of whether they have active course enrolments. Unenrolled 
-- students show NULL values for course fields.

SELECT s.matric_no, s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name;

-- Extension: Showing ONLY students with no course enrolments (Unenrolled students)
SELECT s.matric_no, s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
WHERE c.course_title IS NULL
ORDER BY s.full_name;


-- =========================================================================
-- Task 4: Filtering with AND / OR / IN / BETWEEN
-- =========================================================================
-- Explanation: Combines multiple filter operators. It filters for female students 
-- ('F') who belong either to Software Engineering or Artificial Intelligence (dept_id IN (1, 3)) 
-- and were born between January 1, 2004, and December 31, 2005.

SELECT s.matric_no, s.full_name, s.gender, s.date_of_birth, d.dept_name
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id
WHERE s.gender = 'F' 
  AND s.dept_id IN (1, 3) 
  AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31'
ORDER BY s.date_of_birth ASC;


-- =========================================================================
-- Task 5: Paginating enrolments with LIMIT and OFFSET
-- =========================================================================
-- Explanation: Implements server-side pagination. ORDER BY is mandatory with 
-- LIMIT/OFFSET because relational database tables are unordered sets; without an 
-- explicit sort key, the database engine cannot guarantee which rows fall into 
-- page 1 versus page 2 across different query executions.

-- Page 1: Rows 1 to 10
SELECT enrolment_id, student_id, course_id 
FROM Enrolment 
ORDER BY enrolment_id ASC 
LIMIT 10 OFFSET 0;

-- Page 2: Rows 11 to 20
SELECT enrolment_id, student_id, course_id 
FROM Enrolment 
ORDER BY enrolment_id ASC 
LIMIT 10 OFFSET 10;


-- =========================================================================
-- CHALLENGE (Optional): Task 3 rewritten with RIGHT JOIN
-- =========================================================================
-- Explanation: 
-- This achieves the exact same output as the LEFT JOIN query by reversing 
-- the table flow (starting from Enrolment and RIGHT JOINING to Student).
-- 
-- Readability Note: The LEFT JOIN version (starting from Student) is generally 
-- much easier to read and reason about because the primary subject ("every student") 
-- is declared first on the left side of the query.

SELECT s.matric_no, s.full_name, c.course_title
FROM Enrolment e
RIGHT JOIN Student s ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name;