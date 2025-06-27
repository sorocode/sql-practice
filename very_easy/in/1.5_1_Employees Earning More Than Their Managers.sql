/*
https://leetcode.com/problems/employees-earning-more-than-their-managers/

Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
id는 이 테이블의 기본 키 열입니다.
이 테이블의 각 행은 직원의 ID, 이름, 급여 및 관리자의 ID를 나타냅니다.


Write an SQL query to find the employees who earn more than their managers.
Return the result table in any order.
관리자보다 연봉이 더 높은 직원을 찾는 SQL 쿼리를 작성하세요.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Employee table:
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |
+----+-------+--------+-----------+
Output: 
+----------+
| Employee |
+----------+
| Joe      |
+----------+
Explanation: Joe is the only employee who earns more than his manager.
설명: Joe는 그의 관리자보다 더 많은 돈을 버는 유일한 직원입니다.
*/

# [SETTING]
USE practice;
DROP TABLE Employee;
CREATE TABLE Employee (
  id INT,
  name VARCHAR(255),
  salary INT,
  managerid INT
);
INSERT INTO
  Employee (id, name, salary, managerid)
VALUES
  (1, 'Joe', 70000, 3),
  (2, 'Henry', 80000, 4),
  (3, 'Sam', 60000, NULL),
  (4, 'Max', 90000, NULL);
SELECT *
FROM Employee;

# [KEY]
# [MYSQL1] SELF JOIN

# [PRACTICE]
SELECT *
FROM Employee AS e
INNER JOIN Employee AS m -- SELF JOIN
ON e.managerId = m.id;

# [MYSQL1]
SELECT
    e.name AS employee
FROM Employee AS e
INNER JOIN Employee AS m
ON e.managerId = m.id -- SELF JOIN
WHERE e.salary > m.salary;

# [KEY]
# [MYSQL2] IN: 바깥 table의 alias를 안쪽 table의 alias에 그대로 사용 가능
# 안그러면 in 안에 전체 테이블 다 읽어야 되는데, 그럼 너무 비효율적. 바깥 테이블 alias를 사용해서 in 절 안에 있는 데이터 양을 적게 해서 가져오는 셈.
# 그럼 의미에서 subquery에서 바깥 테이블을 가져올 수 있음

# [MYSQL2]
SELECT
    e.name AS employee
FROM Employee AS e
WHERE e.name IN (
	SELECT
		e.name -- 바깥 테이블 e를 사용
	FROM Employee AS m
	WHERE e.managerId = m.id -- 바깥 테이블 e를 사용
		AND e.salary > m.salary -- 바깥 테이블 e를 사용
);

# [WRONG]
# Jack은 manager가 있지만, 동시에 Mark의 manager이다. (manager 서열: Alan > Jack > Mark)
# 그래서 managerId IS NULL을 썼다고 해서 모든 manager들을 가져올 수 없다.
# [반례: counter example]
-- | id | name | salary | managerId |
-- | -- | ---- | ------ | --------- |
-- | 1  | Mark | 40000  | 3         |
-- | 3  | Jack | 30000  | 2         |
-- | 2  | Alan | 20000  | NULL      |
SELECT
  e.name AS employee
FROM Employee AS e
INNER JOIN (
	SELECT
	  id,
	  name,
	  salary
	FROM Employee
	WHERE managerid IS NULL
) AS m
ON e.managerid = m.id
WHERE e.salary > m.salary;