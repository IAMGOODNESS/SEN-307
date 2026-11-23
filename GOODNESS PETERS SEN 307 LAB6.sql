-- ============================================================================
------------------------------------------------------------------------
-- Task 1: Count the students enrolled in each course, grouped by course.
-- Include courses with zero students, ordered from highest to lowest.
--
-- Why LEFT JOIN with COUNT(e.student_id) gives 0 (not 1) for empty courses:
-- A LEFT JOIN preserves unmatched rows from Course and fills columns from
-- Enrolment with NULL. COUNT(column_name) ignores NULL values, so an unmatched
-- course produces 0 rather than counting the NULL row as 1. (By contrast,
-- COUNT(*) counts rows including NULLs, which would falsely return 1.)
-- ----------------------------------------------------------------------------
USE SEN_307;
SELECT
    c.course_id,
    c.course_title,
    COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_title
ORDER BY
    total_students DESC;


-- ----------------------------------------------------------------------------
-- Task 2: Find courses with more than a given number of students using HAVING.
-- Thresholds tested: 3, 5, and 7.
-- Note: HAVING filters groups *after* aggregation, unlike WHERE which filters
-- individual rows *before* grouping.
-- ----------------------------------------------------------------------------

-- Threshold > 3
SELECT
    c.course_id,
    c.course_title,
    COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_title
HAVING COUNT(e.student_id) > 3
ORDER BY
    total_students DESC;

-- Threshold > 5 (Worked Example)
SELECT
    c.course_id,
    c.course_title,
    COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_title
HAVING COUNT(e.student_id) > 5
ORDER BY
    total_students DESC;

-- Threshold > 7
SELECT
    c.course_id,
    c.course_title,
    COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_title
HAVING COUNT(e.student_id) > 7
ORDER BY
    total_students DESC;


-- ----------------------------------------------------------------------------
-- Task 3: Average number of courses taken per student (including 0 courses).
-- Inner query counts enrolments per student using LEFT JOIN so students with
-- no enrolments get a count of 0; outer query averages those counts to 2 d.p.
-- ----------------------------------------------------------------------------
SELECT ROUND(AVG(course_count), 2) AS avg_courses_per_student
FROM (
    SELECT
        s.student_id,
        COUNT(e.course_id) AS course_count
    FROM Student s
    LEFT JOIN Enrolment e
        ON s.student_id = e.student_id
    GROUP BY
        s.student_id
) AS per_student;


-- ----------------------------------------------------------------------------
-- Task 4 (Non-correlated subquery): Find students not enrolled in any course.
-- The inner query runs once to produce the set of enrolled student_ids.
-- Note: If Enrolment.student_id can ever contain NULLs, NOT IN can return
-- an empty set in SQL; filtering `WHERE student_id IS NOT NULL` inside the
-- subquery (or using NOT EXISTS / LEFT JOIN ... WHERE e.student_id IS NULL
-- as in Week 7 Task 3) avoids NULL pitfalls.
-- ----------------------------------------------------------------------------
SELECT
    s.student_id,
    s.full_name,
    s.dept_id
FROM Student s
WHERE s.student_id NOT IN (
    SELECT e.student_id
    FROM Enrolment e
    WHERE e.student_id IS NOT NULL
);


-- ----------------------------------------------------------------------------
-- Task 5 (Correlated subquery): For each department, find the student(s)
-- with the highest number of enrolments (ties included).
-- The inner MAX(...) subquery references s.dept_id from the outer query, so it
-- evaluates once per candidate student row to find the top enrolment count in
-- that student's department.
-- ----------------------------------------------------------------------------
SELECT
    d.dept_name,
    s.full_name,
    (
        SELECT COUNT(*)
        FROM Enrolment e
        WHERE e.student_id = s.student_id
    ) AS courses
FROM Student s
JOIN Department d
    ON s.dept_id = d.dept_id
WHERE (
    SELECT COUNT(*)
    FROM Enrolment e
    WHERE e.student_id = s.student_id
) = (
    SELECT MAX(dept_counts.enrolment_total)
    FROM (
        SELECT COUNT(*) AS enrolment_total
        FROM Student s2
        JOIN Enrolment e2
            ON s2.student_id = e2.student_id
        WHERE s2.dept_id = s.dept_id
        GROUP BY s2.student_id
    ) AS dept_counts
)
ORDER BY
    d.dept_name,
    s.full_name;