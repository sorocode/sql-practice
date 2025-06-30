/*
https://leetcode.com/problems/employees-with-missing-information/ 

Table: Employees
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the name of the employee whose ID is employee_id.
employee_id는 이 테이블의 기본 키입니다.
이 테이블의 각 행은 ID가 employee_id인 직원의 이름을 나타냅니다.


Table: Salaries
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| salary      | int     |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the salary of the employee whose ID is employee_id.
employee_id는 이 테이블의 기본 키입니다.
이 테이블의 각 행은 ID가 employee_id인 직원의 급여를 나타냅니다.


Write an SQL query to report the IDs of all the employees with missing information.
The information of an employee is missing if:
- The employee's name is missing, or
- The employee's salary is missing.
Return the result table ordered by employee_id in ascending order.
정보가 누락된 모든 직원의 ID를 보고하는 SQL 쿼리를 작성하세요.
직원 정보가 누락된 경우는 다음과 같습니다:
- 직원의 이름이 누락
- 직원의 급여가 누락
employee_id를 기준으로 오름차순으로 정렬된 결과 테이블을 반환합니다.


Example:
Input: 
Employees table:
+-------------+----------+
| employee_id | name     |
+-------------+----------+
| 2           | Crew     |
| 4           | Haven    |
| 5           | Kristian |
+-------------+----------+
Salaries table:
+-------------+--------+
| employee_id | salary |
+-------------+--------+
| 1           | 22517  |
| 4           | 63539  |
| 5           | 76071  |
+-------------+--------+
Output: 
+-------------+
| employee_id |
+-------------+
| 1           |
| 2           |
+-------------+
Explanation: 
Employees 1, 2, 4, and 5 are working at this company.
The name of employee 1 is missing.
The salary of employee 2 is missing.
설명:
직원 1, 2, 4, 5는 이 회사에서 근무하고 있습니다.
직원 1의 이름이 누락되었습니다.
직원 2의 급여가 누락되었습니다.
*/

# [SETTING]
USE practice;
DROP TABLE Employees;
CREATE TABLE Employees
(
    employee_id INT,
    name        VARCHAR(30)
);
INSERT INTO Employees
    (employee_id, name)
VALUES (2, 'Crew'),
    (4, 'Haven'),
    (5, 'Kristian');
SELECT *
FROM Employees;

# [SETTING]
USE practice;
DROP TABLE Salaries;
CREATE TABLE Salaries
(
    employee_id INT,
    salary      INT
);
INSERT INTO Salaries
    (employee_id, salary)
VALUES (1, 22517),
	(4, 63539),
	(5, 76071);
SELECT *
FROM Salaries; 

# [PRACTICE]
SELECT *
FROM Employees AS a
LEFT OUTER JOIN Salaries AS b
ON a.employee_id = b.employee_id;

SELECT *
FROM Employees AS a
LEFT OUTER JOIN Salaries AS b
ON a.employee_id = b.employee_id
WHERE b.employee_id IS NULL;

# [PRACTICE]
SELECT *
FROM Salaries AS a
LEFT OUTER JOIN Employees AS b
ON a.employee_id = b.employee_id;

SELECT *
FROM Salaries AS a
LEFT OUTER JOIN Employees AS b
ON a.employee_id = b.employee_id
WHERE b.employee_id IS NULL;

#[MYSQL]
# MYSQL에서는 FULL OUTER JOIN을 지원하지 않아서, 이렇게 대체로 FULL OUTER JOIN 로직을 작성한다.
SELECT
    a.employee_id
FROM Employees AS a
LEFT OUTER JOIN Salaries AS b
ON a.employee_id = b.employee_id
WHERE b.employee_id IS NULL

UNION

SELECT
    a.employee_id
FROM Salaries AS a
LEFT OUTER JOIN Employees AS b
ON a.employee_id = b.employee_id
WHERE b.employee_id IS NULL
ORDER BY employee_id; 

/*
# [ORACLE]
SELECT
	CASE
		WHEN e.employee_id IS NULL THEN s.employee_id
		WHEN s.employee_id IS NULL THEN e.employee_id
	END AS employee_id
FROM Employees e
FULL OUTER JOIN Salaries s
ON e.employee_id = s.employee_id
WHERE e.employee_id IS NULL
	OR s.employee_id IS NULL
ORDER BY employee_id;
*/
