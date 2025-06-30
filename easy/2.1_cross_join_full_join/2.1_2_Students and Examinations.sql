/*
https://leetcode.com/problems/students-and-examinations/ 

Table: Students
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
student_id is the primary key for this table.
Each row of this table contains the ID and the name of one student in the school.
student_id는 이 테이블의 기본 키입니다.
이 테이블의 각 행에는 학교에 다니는 학생의 ID와 이름이 포함되어 있습니다.


Table: Subjects
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+
subject_name is the primary key for this table.
Each row of this table contains the name of one subject in the school.
subject_name은 이 테이블의 기본 키입니다.
이 테이블의 각 행에는 학교의 과목 이름이 포함되어 있습니다.


Table: Examinations
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+
There is no primary key for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
이 테이블에는 기본 키가 없습니다. 중복된 내용이 포함되어 있을 수 있습니다.
학생 테이블의 각 학생은 과목 테이블의 모든 강좌를 수강합니다.
이 테이블의 각 행은 ID가 student_id인 학생이 subject_name의 시험에 참석했음을 나타냅니다.


Write an SQL query to find the number of times each student attended each exam.
Return the result table ordered by student_id and subject_name.
각 학생이 각 시험에 참석한 횟수를 알아보는 SQL 쿼리를 작성하세요.
student_id와 subject_name으로 정렬된 결과 테이블을 반환합니다.


Example:
Input: 
Students table:
+------------+--------------+
| student_id | student_name |
+------------+--------------+
| 1          | Alice        |
| 2          | Bob          |
| 6          | Alex         |
| 13         | John         |
+------------+--------------+
Subjects table:
+--------------+
| subject_name |
+--------------+
| Math         |
| Physics      |
| Programming  |
+--------------+
Examinations table:
+------------+--------------+
| student_id | subject_name |
+------------+--------------+
| 1          | Math         |
| 1          | Math         |
| 1          | Math         |
| 1          | Physics      |
| 1          | Physics      |
| 1          | Programming  |
| 2          | Math         |
| 2          | Programming  |
| 13         | Math         |
| 13         | Physics      |
| 13         | Programming  |
+------------+--------------+
Output: 
+------------+--------------+--------------+----------------+
| student_id | student_name | subject_name | attended_exams |
+------------+--------------+--------------+----------------+
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |
+------------+--------------+--------------+----------------+
Explanation: 
The result table should contain all students and all subjects.
Alice attended the Math exam 3 times, the Physics exam 2 times, and the Programming exam 1 time.
Bob attended the Math exam 1 time, the Programming exam 1 time, and did not attend the Physics exam.
Alex did not attend any exams.
John attended the Math exam 1 time, the Physics exam 1 time, and the Programming exam 1 time.
설명:
결과 테이블에는 모든 학생과 모든 과목이 포함되어야 합니다.
Alice는 수학 시험에 3번, 물리학 시험에 2번, 프로그래밍 시험에 1번 참석했습니다.
Bob은 수학 시험에 1번, 프로그래밍 시험에 1번 참석했지만 물리학 시험에는 참석하지 않았습니다.
Alex는 어떤 시험에도 참석하지 않았습니다.
John은 수학 시험에 1번, 물리학 시험에 1번, 프로그래밍 시험에 1번 참석했습니다.
*/

# [SETTING]
USE practice;
DROP TABLE Students;
CREATE TABLE Students
(
    student_id   INT,
    student_name VARCHAR(20)
);
INSERT INTO Students
    (student_id, student_name)
VALUES (1, 'Alice'),
    (2, 'Bob'),
    (6, 'Alex'),
    (13, 'John');
SELECT *
FROM Students;

# [SETTING]
USE practice;
DROP TABLE Subjects;
CREATE TABLE Subjects
(
    subject_name VARCHAR(20)
);
INSERT INTO Subjects
    (subject_name)
VALUES ('Math'),
    ('Physics'),
    ('Programming');
SELECT *
FROM Subjects;

# [SETTING]
USE practice;
DROP TABLE Examinations;
CREATE TABLE Examinations
(
    student_id   INT,
    subject_name VARCHAR(20)
);
INSERT INTO Examinations
    (student_id, subject_name)
VALUES (1, 'Math'),
    (1, 'Math'),
    (1, 'Math'),
    (1, 'Physics'),
    (1, 'Physics'),
    (1, 'Programming'),
    (2, 'Math'),
    (2, 'Programming'),
    (13, 'Math'),
    (13, 'Physics'),
    (13, 'Programming');
SELECT *
FROM Examinations; 

# [PRACTICE]
SELECT *
FROM Students, -- CROSS JOIN
Subjects;

# [MYSQL1]
SELECT
    a.student_id,
    a.student_name,
    b.subject_name,
    (
		SELECT
			COUNT(*)
		FROM Examinations AS c
		WHERE a.student_id = c.student_id
			AND b.subject_name = c.subject_name
    ) AS attended_exams
FROM Students AS a, -- CROSS JOIN
Subjects AS b
ORDER BY student_id, subject_name; 

# [MYSQL2]
SELECT
    a.student_id,
    a.student_name,
    a.subject_name,
    COUNT(e.subject_name) AS attended_exams
    # IFNULL(COUNT(e.subject_name), 0) AS attended_exams -- 옳은 풀이이지만 IFNULL 사용 불필요. 원래 NULL 데이터에 대해서는 count=0으로 나온다.
FROM (
	SELECT
		student_id,
		student_name,
		subject_name
	FROM Students, -- CROSS JOIN
	Subjects
) AS a
LEFT OUTER JOIN (
	SELECT
		student_id,
		subject_name
	FROM Examinations
) AS e
ON a.student_id = e.student_id
    AND a.subject_name = e.subject_name
GROUP BY a.student_id, a.student_name, a.subject_name
ORDER BY a.student_id, a.subject_name; 