
USE sen_307 ;


INSERT INTO Department (dept_name) VALUES
('Software Engineering'),
('Computer Science'),
('Artificial Intelligence'),
('Data Science'),
('Cybersecurity');

INSERT INTO Course (course_code, course_title, credit_units, description, dept_id) VALUES
('SEN307', 'Database Systems', 3,
'Relational database design, SQL queries, normalization, transactions and indexing using MySQL.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('SEN301', 'Software Architecture', 3,
'Architectural styles, design patterns, microservices and how to structure large software systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('COS301', 'Operating Systems', 3,
'Processes, threads, CPU scheduling, memory management and file systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('COS305', 'Computer Networks', 3,
'TCP/IP, routing, switching, LAN and WAN design and network protocols.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('AIN301', 'Introduction to Artificial Intelligence', 3,
'Intelligent agents, search algorithms, knowledge representation and reasoning.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN305', 'Machine Learning', 3,
'Supervised and unsupervised learning, neural networks, deep learning and model evaluation.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN307', 'Natural Language Processing', 3,
'Text processing, word embeddings, language models, sentiment analysis and chatbots.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('DTS301', 'Data Visualization and Analytics', 2,
'Exploratory data analysis, charts, dashboards and telling stories with data.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('DTS305', 'Big Data Technologies', 3,
'Distributed storage and processing of very large datasets with Hadoop and Spark.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('CYB301', 'Network Security', 3,
'Firewalls, cryptography, intrusion detection and protecting networks from attacks.',
(SELECT dept_id FROM Department WHERE dept_name = 'Cybersecurity'));


SELECT d.dept_name, COUNT(c.course_id) AS courses
FROM Department d LEFT JOIN Course c ON d.dept_id = c.dept_id
GROUP BY d.dept_name;

SELECT dept_id, dept_name FROM Department;
SELECT course_id, course_code FROM Course;

INSERT INTO Lecturer (staff_no, full_name, email, dept_id) VALUES
('VUA/ST/101', 'Dr Amaka Okafor', 'a.okafor@vua.edu.ng', 1),
('VUA/ST/102', 'Dr Musa Bello', 'm.bello@vua.edu.ng', 1),
('VUA/ST/103', 'Dr Chidi Okoro', 'c.okoro@vua.edu.ng', 2),
('VUA/ST/104', 'Prof Fatima Ahmed', 'f.ahmed@vua.edu.ng', 2),
('VUA/ST/105', 'Dr Tunde Adeleke', 't.adeleke@vua.edu.ng', 3),
('VUA/ST/106', 'Dr Grace Eze', 'g.eze@vua.edu.ng', 3),
('VUA/ST/107', 'Dr James Oche', 'j.oche@vua.edu.ng', 4),
('VUA/ST/108', 'Dr Zainab Ibrahim', 'z.ibrahim@vua.edu.ng', 4),
('VUA/ST/109', 'Dr Nnamdi Azikiwe', 'n.azikiwe@vua.edu.ng', 5),
('VUA/ST/110', 'Dr Sarah Johnson', 's.johnson@vua.edu.ng', 5);


INSERT INTO Student (matric_no, full_name, gender, date_of_birth, dept_id) VALUES
('20231234', 'Goodness Peters', 'M', '2004-06-15', 1),
('20231235', 'Ada Obi', 'F', '2005-03-14', 1),
('20231236', 'John Musa', 'M', '2004-11-02', 2),
('20231237', 'Aisha Bello', 'F', '2003-01-22', 2),
('20231238', 'Emmanuel Arthur', 'M', '2006-05-10', 3),
('20231239', 'Blessing Chukwu', 'F', '2005-09-19', 3),
('20231240', 'David Adeleke', 'M', '2007-07-04', 4),
('20231241', 'Chiamaka Nnamdi', 'F', '2004-12-12', 4),
('20231242', 'Ibrahim Danjuma', 'M', '2003-08-30', 5),
('20231243', 'Zainab Sani', 'F', '2006-02-18', 5),
('20231244', 'Oluwaseun Funsho', 'M', '2005-04-25', 1),
('20231245', 'Kemi Afolabi', 'F', '2004-10-05', 1),
('20231246', 'Tariq Mohammed', 'M', '2006-01-11', 2),
('20231247', 'Ngozi Okoro', 'F', '2003-07-20', 2),
('20231248', 'Samuel Etim', 'M', '2005-11-15', 3),
('20231249', 'Esther Paul', 'F', '2007-03-03', 3),
('20231250', 'Victor Ekeh', 'M', '2004-09-09', 4),
('20231251', 'Ruth Okon', 'F', '2005-06-21', 5),
('20231252', 'Kabiru Abubakar', 'M', '2004-04-12', 1),
('20231253', 'Miracle Nwachukwu', 'F', '2005-08-08', 2); 


INSERT INTO Enrolment (student_id, course_id) VALUES

(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1),

(1, 2), (2, 2), (3, 2), (4, 3), (5, 3), (6, 4), (7, 4),
(8, 5), (9, 5), (10, 6), (11, 6), (12, 7), (13, 7), (14, 8),
(15, 8), (16, 9), (17, 9), (18, 10), (1, 3), (2, 4), (3, 5),
(4, 6), (5, 7), (6, 8), (7, 9), (8, 10), (9, 1), (10, 2),
(11, 3), (12, 4), (13, 5), (14, 6), (15, 7);


INSERT INTO CourseAllocation (course_id, lecturer_id) VALUES
(1, 1), (1, 2), 
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


SET SQL_SAFE_UPDATES = 0;

SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = '20231234';

UPDATE Student SET dept_id = 2 WHERE matric_no = '20231234';

SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = '20231234';

SET SQL_SAFE_UPDATES = 1;

INSERT INTO Department (dept_name) VALUES ('Library and Information Science');

INSERT INTO Student (matric_no, full_name, dept_id)
VALUES ('20239999', 'Transfer Student',
(SELECT dept_id FROM Department WHERE dept_name = 'Library and Information Science'));
UPDATE Student
SET dept_id = (SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')
WHERE matric_no = '20239999';

DELETE FROM Department WHERE dept_name = 'Library and Information Science';

SELECT * FROM Department;

SELECT 'Departments' AS tbl, COUNT(*) AS total FROM Department
UNION ALL SELECT 'Lecturers', COUNT(*) FROM Lecturer
UNION ALL SELECT 'Students', COUNT(*) FROM Student
UNION ALL SELECT 'Courses', COUNT(*) FROM Course
UNION ALL SELECT 'Enrolments', COUNT(*) FROM Enrolment
UNION ALL SELECT 'Allocations', COUNT(*) FROM CourseAllocation;

DELETE FROM Department WHERE dept_name = 'Library and Information Science';
UPDATE Student
SET dept_id = (SELECT dept_id FROM Department
WHERE dept_name = 'Software Engineering')
WHERE matric_no = '20239999';
-- Step 2: now the delete succeeds
DELETE FROM Department WHERE dept_name = 'Library and Information Science';
SELECT * FROM Department;