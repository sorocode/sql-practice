/*
https://leetcode.com/problems/triangle-judgement/ 

Table: Triangle
+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
(x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
(x, y, z)는 이 테이블의 기본 키 열입니다.
이 테이블의 각 행에는 세 개의 선분 길이가 포함되어 있습니다.


Write an SQL query to report for every three line segments whether they can form a triangle.
Return the result table in any order.
세 개의 선분마다 삼각형을 형성할 수 있는지 보고하는 SQL 쿼리를 작성하세요.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Triangle table:
+----+----+----+
| x  | y  | z  |
+----+----+----+
| 13 | 15 | 30 |
| 10 | 20 | 15 |
+----+----+----+
Output: 
+----+----+----+----------+
| x  | y  | z  | triangle |
+----+----+----+----------+
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
+----+----+----+----------+
*/

# [SETTING]
USE practice;
DROP TABLE Triangle;
CREATE TABLE Triangle (
	x INT,
	y INT,
	z INT
);
INSERT INTO
  Triangle (x, y, z)
VALUES
  (13, 15, 30),
  (10, 20, 15);
SELECT *
FROM Triangle;

# [MYSQL]
SELECT
  x,
  y,
  z,
  CASE
    WHEN x + y <= z THEN 'No'
    WHEN y + z <= x THEN 'No'
    WHEN z + x <= y THEN 'No'
    ELSE 'Yes'
  END AS triangle
FROM Triangle;