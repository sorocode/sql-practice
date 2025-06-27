/*
https://leetcode.com/problems/employees-whose-manager-left-the-company/ 

Table: Employees
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| manager_id  | int      |
| salary      | int      |
+-------------+----------+
employee_id is the primary key for this table.
This table contains information about the employees, their salary, and the ID of their manager.
Some employees do not have a manager (manager_id is null). 
employee_id 이 테이블의 기본 키입니다.
이 테이블에는 직원, 급여, 관리자 ID에 대한 정보가 포함되어 있습니다.
일부 직원에게는 관리자가 없습니다(manager_id가 null임).


Write an SQL query to report the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company.
When a manager leaves the company, their information is deleted from the Employees table.
Return the result table ordered by employee_id.
급여가 $30000 미만이고 관리자가 회사를 떠난 직원의 ID를 보고하는 SQL 쿼리를 작성하세요.
관리자가 회사를 떠나면 Employees 테이블에서 해당 정보가 삭제됩니다.
employee_id별로 정렬된 결과 테이블을 반환합니다.


Example:
Input:  
Employees table:
+-------------+-----------+------------+--------+
| employee_id | name      | manager_id | salary |
+-------------+-----------+------------+--------+
| 3           | Mila      | 9          | 60301  |
| 12          | Antonella | null       | 31000  |
| 13          | Emery     | null       | 67084  |
| 1           | Kalel     | 11         | 21241  |
| 9           | Mikaela   | null       | 50937  |
| 11          | Joziah    | 6          | 28485  |
+-------------+-----------+------------+--------+
Output: 
+-------------+
| employee_id |
+-------------+
| 11          |
+-------------+
Explanation: 
The employees with a salary less than $30000 are 1 (Kalel) and 11 (Joziah).
Kalel's manager is employee 11, who is still in the company (Joziah).
Joziah's manager is employee 6, who left the company because there is no row for employee 6 as it was deleted.
설명:
급여가 $30000 미만인 직원은 1(Kalel)과 11(Joziah)입니다.
Kalel의 관리자는 아직 회사에 있는 직원 11입니다(Joziah).
Joziah의 관리자는 직원 6인데, 직원 6이 삭제되어 해당 행이 없어 회사를 떠났습니다.
*/

# [SETTING]
USE practice;
DROP TABLE Employees;
CREATE TABLE Employees (
  employee_id INT,
  name VARCHAR(20),
  manager_id INT,
  salary INT
);
INSERT INTO
  Employees (employee_id, name, manager_id, salary)
VALUES
  (3, 'Mila', 9, 60301),
  (12, 'Antonella', NULL, 31000),
  (13, 'Emery', NULL, 67084),
  (1, 'Kalel', 11, 21241),
  (9, 'Mikaela', NULL, 50937),
  (11, 'Joziah', 6, 28485);
SELECT *
FROM Employees;

# [KEY]
# 'whose manager LEFT the company': 여집합의 개념인 NOT IN 고려

# [SUBQUERY]
# 현재 Employees 테이블에 있는 모든 employee_id를 반환
SELECT
	employee_id
FROM Employees;

# [MYSQL]
SELECT
    employee_id
FROM Employees
WHERE salary < 30000
  AND manager_id NOT IN (
	SELECT
		employee_id
	FROM Employees
)
ORDER BY employee_id; 

# [WRONG]
# 마치 manager_id와 employee_id가 서로 다른 row를 조회하는 셈 (manager_id != employee_id)
# Employees 테이블 조회했을 때 나왔던 manager_id=NULL이 여기서 나오지 않은 이유는 NULL은 특정 값과 비교자체가 안되기 때문
SELECT *
FROM Employees 
WHERE manager_id NOT IN (employee_id);

# (참고)[의도한 결과]
SELECT
	employee_id
FROM Employees
WHERE employee_id NOT IN (1);

# (참고)[의도하지 않은 결과]
# NOT IN에는 NULL이 포함되면 안됨
# -> NOT IN 절에 NULL 값이 포함되면, 모든 비교가 UNKNOWN으로 평가되어 예상치 못한 결과가 발생
SELECT
	employee_id
FROM Employees
WHERE employee_id NOT IN (1, NULL);
