/*
https://leetcode.com/problems/biggest-single-number/ 

Table: MyNumbers
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
There is no primary key for this table. It may contain duplicates.
Each row of this table contains an integer.
A single number is a number that appeared only once in the MyNumbers table.
이 테이블에는 기본 키가 없습니다. 중복된 내용이 포함되어 있을 수 있습니다.
이 테이블의 각 행에는 정수가 포함되어 있습니다.
단일 숫자는 MyNumbers 테이블에 한 번만 나타나는 숫자입니다.


Write an SQL query to report the largest single number.
If there is no single number, report null.
The query result format is in the following example.
가장 큰 단일 숫자를 보고하는 SQL 쿼리를 작성하세요.
단일 숫자가 없으면 null을 보고합니다.
쿼리 결과 형식은 다음 예와 같습니다.


Example 1:
Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
Output: 
+-----+
| num |
+-----+
| 6   |
+-----+
Explanation:
The single numbers are 1, 4, 5, and 6.
Since 6 is the largest single number, we return it.
설명:
단일 숫자는 1, 4, 5, 6입니다.
6은 가장 큰 단일 숫자이므로 이를 반환합니다.


Example 2:
Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |
| 3   |
+-----+
Output: 
+------+
| num  |
+------+
| null |
+------+
Explanation:
There are no single numbers in the input table so we return null.
설명:
입력 테이블에 단일 숫자가 없으므로 null을 반환합니다.
*/

# [SETTING]
USE practice;
DROP TABLE MyNumbers;
CREATE TABLE MyNumbers
(
    num INT
);
INSERT INTO MyNumbers
    (num)
VALUES (8),
    (8),
    (3),
    (3),
    (1),
    (4),
    (5),
    (6);
SELECT *
FROM MyNumbers; 

# [WRONG]
SELECT MAX(num)
FROM MyNumbers
GROUP BY num -- GROUP BY를 사용하면, 해당 컬럼을 SELECT문에서 사용하는 것을 권장
HAVING COUNT(num) = 1; 

# [WRONG]
# 위 WRONG 쿼리는 아래 쿼리와 동일하다. 
# GROUP BY를 했기 때문에 num은 자기 자신 1개씩 나올텐데, 그 1개 중에 MAX이면 그 또한 자기 자신이다.
SELECT
    num,
    MAX(num)
FROM MyNumbers
GROUP BY num
HAVING COUNT(num) = 1; 

# [MYSQL]
SELECT
    MAX(num) AS num
FROM (
	SELECT
		num
	FROM MyNumbers
	GROUP BY num
	HAVING COUNT(num) = 1
) AS a; 
