/*
https://leetcode.com/problems/project-employees-i/ 

Table: Project
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
(project_id, employee_id)는 이 테이블의 기본 키입니다.
employee_id는 Employee 테이블의 외래 키입니다.
이 테이블의 각 행은 employee_id를 가진 직원이 project_id를 가진 프로젝트에서 작업 중임을 나타냅니다.


Table: Employee
+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table.
It's guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.
employee_id는 이 테이블의 기본 키입니다.
experience_years가 NULL이 아니라는 것이 보장됩니다.
이 테이블의 각 행에는 직원 한 명에 대한 정보가 포함되어 있습니다.


Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
Return the result table in any order.
각 프로젝트에 대한 모든 직원의 평균 경력 연수를 두 자리 숫자로 반올림하여 보고하는 SQL 쿼리를 작성합니다.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+
Output: 
+-------------+---------------+
| project_id  | average_years |
+-------------+---------------+
| 1           | 2.00          |
| 2           | 2.50          |
+-------------+---------------+
Explanation:
The average experience years for the first project is (3 + 2 + 1) / 3 = 2.00
and for the second project is (3 + 2) / 2 = 2.50
첫 번째 프로젝트의 평균 경험 기간은 (3 + 2 + 1) / 3 = 2.00입니다.
두 번째 프로젝트의 경우 (3 + 2) / 2 = 2.50입니다.
*/

# [SETTING]
USE practice;
DROP TABLE Project;
CREATE TABLE Project (
	project_id INT,
	employee_id INT
);
INSERT INTO
  Project (project_id, employee_id)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (2, 1),
  (2, 4);
SELECT *
FROM Project;

# [SETTING]
USE practice;
DROP TABLE Employee;
CREATE TABLE Employee (
  employee_id INT,
  name VARCHAR(255),
  experience_years INT
);
INSERT INTO
  Employee (employee_id, name, experience_years)
VALUES
  (1, 'Khaled', 3),
  (2, 'Ali', 2),
  (3, 'John', 1),
  (4, 'Doe', 2);
SELECT *
FROM Employee;

# [MYSQL]
SELECT
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project AS p
INNER JOIN Employee AS e
ON p.employee_id = e.employee_id
GROUP BY p.project_id; 