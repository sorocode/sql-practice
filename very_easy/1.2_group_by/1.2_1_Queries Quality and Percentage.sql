/*
https://leetcode.com/problems/queries-quality-and-percentage/ 

Table: Queries
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
There is no primary key for this table, it may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5.
Query with rating less than 3 is a poor query.
이 테이블에는 기본 키가 없습니다. 중복된 행이 있을 수 있습니다.
이 테이블에는 데이터베이스의 일부 쿼리에서 수집된 정보가 포함되어 있습니다.
position 열의 값은 1부터 500까지입니다.
rating 열에는 1부터 5까지의 값이 있습니다.
rating이 3 미만인 쿼리는 잘못된 쿼리입니다.


We define query quality as: The average of the ratio between query rating and its position.
We also define poor query percentage as: The percentage of all queries with rating less than 3.
quality는 다음과 같이 정의합니다: 쿼리 rating과 해당 position 간의 비율 평균입니다.
poor query percentage는 다음과 같이 정의합니다: rating이 3 미만인 쿼리의 백분율입니다.


Write an SQL query to find each query_name, the quality and poor_query_percentage.
Both quality and poor_query_percentage should be rounded to 2 decimal places.
Return the result table in any order.
query_name별로 quality 및 poor_query_percentage 찾는 SQL 쿼리를 작성합니다.
quality와 poor_query_percentage 모두 소수점 이하 2자리로 반올림되어야 합니다.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+
Output: 
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+
Explanation: 
Dog queries quality is ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
Dog queries poor_query_percentage is (1 / 3) * 100 = 33.33
Cat queries quality equals ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
Cat queries poor_query_percentage is (1 / 3) * 100 = 33.33
설명:
Dog quality은 ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50입니다.
Dog poor_query_percentage는 (1 / 3) * 100 = 33.33입니다.
Cat quality은 ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66입니다.
Cat poor_query_percentage는 (1 / 3) * 100 = 33.33입니다.
*/

# [SETTING]
USE practice;
DROP TABLE Queries;
CREATE TABLE Queries (
  query_name VARCHAR(30),
  result VARCHAR(50),
  position INT,
  rating INT
);
INSERT INTO
  Queries (query_name, result, position, rating)
VALUES
  ('Dog', 'Golden Retriever', 1, 5),
  ('Dog', 'German Shepherd', 2, 5),
  ('Dog', 'Mule', 200, 1),
  ('Cat', 'Shirazi', 5, 2),
  ('Cat', 'Siamese', 3, 3),
  ('Cat', 'Sphynx', 7, 4);
SELECT *
FROM Queries;

# [KEY]
# CASE WHEN과 함께 GROUP BY 사용하면 매우 유용
# ROUND 함수: 소수점 몇 자리 수 기준으로 반올림
# (참고) CASE WHEN을 COUNT로도 사용 가능(COUNT(CASE WHEN rating < 3 THEN 1 END)/COUNT(*)) -> Easy 섹션에서 다시 다룰 예정

# [MYSQL]
SELECT
  query_name,
  ROUND(AVG(rating / position), 2) AS quality,
  ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END ) / COUNT(*) * 100, 2) AS poor_query_percentage -- SUM 사용
  # ROUND(COUNT(CASE WHEN rating < 3 THEN 1 END ) / COUNT(*) * 100, 2) AS poor_query_percentage -- COUNT 사용
FROM Queries
GROUP BY query_name;