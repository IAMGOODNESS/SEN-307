
USE sen_307; 

SELECT s.matric_no, s.full_name, d.dept_name
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Software Engineering'
ORDER BY s.full_name ASC;


SELECT c.course_code, c.course_title, l.full_name AS lecturer_name
FROM Course c
INNER JOIN CourseAllocation ca ON c.course_id = ca.course_id
INNER JOIN Lecturer l ON ca.lecturer_id = l.lecturer_id;


SELECT s.matric_no, s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name;
SELECT s.matric_no, s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
WHERE c.course_title IS NULL
ORDER BY s.full_name;

SELECT s.matric_no, s.full_name, s.gender, s.date_of_birth, d.dept_name
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id
WHERE s.gender = 'F' 
  AND s.dept_id IN (1, 3) 
  AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31'
ORDER BY s.date_of_birth ASC;
SELECT enrolment_id, student_id, course_id 
FROM Enrolment 
ORDER BY enrolment_id ASC 
LIMIT 10 OFFSET 0;


SELECT enrolment_id, student_id, course_id 
FROM Enrolment 
ORDER BY enrolment_id ASC 
LIMIT 10 OFFSET 10;

SELECT s.matric_no, s.full_name, c.course_title
FROM Enrolment e
RIGHT JOIN Student s ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name;