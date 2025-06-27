/*
https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/

Table: Employees
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key for this table.
Each row of this table contains the id and the name of an employee in a company.
id는 이 테이블의 기본 키입니다.
이 테이블의 각 행에는 회사 직원의 ID와 이름이 포함되어 있습니다.


Table: EmployeeUNI
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| unique_id     | int     |
+---------------+---------+
(id, unique_id) is the primary key for this table.
Each row of this table contains the id and the corresponding unique id of an employee in the company.
(id, Unique_id)는 이 테이블의 기본 키입니다.
이 테이블의 각 행에는 회사 직원의 ID와 해당 고유 ID가 포함되어 있습니다.
 

Write an SQL query to show the unique ID of each user. If a user does not have a unique ID replace just show null.
Return the result table in any order.
각 사용자의 고유 ID를 표시하는 SQL 쿼리를 작성합니다. 사용자에게 고유 ID가 없으면 null만 표시하면 됩니다.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Employees table:
+----+----------+
| id | name     |
+----+----------+
| 1  | Alice    |
| 7  | Bob      |
| 11 | Meir     |
| 90 | Winston  |
| 3  | Jonathan |
+----+----------+
EmployeeUNI table:
+----+-----------+
| id | unique_id |
+----+-----------+
| 3  | 1         |
| 11 | 2         |
| 90 | 3         |
+----+-----------+
Output: 
+-----------+----------+
| unique_id | name     |
+-----------+----------+
| null      | Alice    |
| null      | Bob      |
| 2         | Meir     |
| 3         | Winston  |
| 1         | Jonathan |
+-----------+----------+
Explanation: 
Alice and Bob do not have a unique ID, We will show null instead.
The unique ID of Meir is 2.
The unique ID of Winston is 3.
The unique ID of Jonathan is 1.
설명:
Alice와 Bob은 고유 ID가 없으므로 대신 null을 표시하겠습니다.
메이어의 고유 ID는 2이다.
Winston의 고유 ID는 3입니다.
Jonathan의 고유 ID는 1입니다.
*/

# [SETTING]
USE practice;
DROP TABLE Employees;
CREATE TABLE Employees (
	id INT,
	name VARCHAR(20)
);
INSERT INTO
  Employees (id, name)
VALUES
  (1, 'Alice'),
  (7, 'Bob'),
  (11, 'Meir'),
  (90, 'Winston'),
  (3, 'Jonathan');
SELECT *
FROM Employees;

# [SETTING]
USE practice;
DROP TABLE EmployeeUNI;
CREATE TABLE EmployeeUNI (
	id INT,
	unique_id INT
);
INSERT INTO
  EmployeeUNI (id, unique_id)
VALUES
  (3, 1),
  (11, 2),
  (90, 3);
SELECT *
FROM EmployeeUNI;

# [KEY]
# 'If a user does not have a unique ID replace just show null.'
# -> INNER JOIN이 아니라, LEFT OUTER JOIN 필요

# [MYSQL]
SELECT
  u.unique_id,
  e.name
FROM Employees AS e
LEFT OUTER JOIN EmployeeUNI AS u
ON e.id = u.id;