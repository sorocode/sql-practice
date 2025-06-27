/*
https://leetcode.com/problems/duplicate-emails/ 

Table: Person
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
id는 이 테이블의 기본 키 열입니다.
이 테이블의 각 행에는 이메일이 포함되어 있습니다. 이메일에는 대문자가 포함되지 않습니다.


Write an SQL query to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.
Return the result table in any order.
모든 중복 이메일을 보고하는 SQL 쿼리를 작성하세요. 이메일 필드가 NULL이 아니라는 것이 보장됩니다.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Person table:
+----+---------+
| id | email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
Output: 
+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Explanation: a@b.com is repeated two times.
설명: a@b.com이 두 번 반복됩니다.
*/

# [SETTING]
USE practice;
DROP TABLE Person;
CREATE TABLE Person (
	id INT,
	email VARCHAR(255)
);
INSERT INTO
  Person (id, email)
VALUES
  (1, 'a@b.com'),
  (2, 'c@d.com'),
  (3, 'a@b.com');
SELECT *
FROM Person;

# [MYSQL]
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1;