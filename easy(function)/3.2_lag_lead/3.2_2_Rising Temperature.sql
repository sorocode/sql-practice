/*
https://leetcode.com/problems/rising-temperature/ 

Table: Weather
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature on a certain day.
id는 이 테이블의 기본 키입니다.
이 표에는 특정 날짜의 기온에 대한 정보가 포함되어 있습니다.


Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
Return the result table in any order.
이전 날짜(어제)에 비해 기온이 더 높은 모든 날짜의 ID를 찾는 SQL 쿼리를 작성하세요.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
| 5  | 2015-01-14 | 5           |
| 6  | 2015-01-16 | 7           |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
설명:
2015-01-02에는 전날보다 기온이 높아졌습니다(10->25).
2015-01-04년에는 전날보다 기온이 높아졌습니다(20->30).
*/

# [SETTING]
USE practice;
DROP TABLE Weather;
CREATE TABLE Weather
(
    id          INT,
    recordDate DATE,
    temperature INT
);
INSERT INTO Weather
    (id, recordDate, temperature)
VALUES (1, '2015-01-01', 10),
    (2, '2015-01-02', 25),
    (3, '2015-01-03', 20),
    (4, '2015-01-04', 30),
    (5, '2015-01-14', 5), # 데이터 추가함
    (6, '2015-01-16', 7); # 데이터 추가함
SELECT *
FROM Weather; 

# [PRACTICE]
SELECT
    id,
    recordDate,
    temperature,
    LAG(recordDate) OVER (ORDER BY recordDate) AS pre_rd, -- 각 날짜의 이전 날짜
    LAG(temperature) OVER (ORDER BY recordDate) pre_t -- 각 날짜의 이전 기온
FROM Weather
ORDER BY recordDate;
        
# [MYSQL1]
# lag ('이전 날짜(어제)' 단어를 통해 연결 가능)
SELECT
    id
FROM (
SELECT
		id,
		recordDate,
		temperature,
		LAG(recordDate) OVER (ORDER BY recordDate) AS pre_rd,  -- 각 날짜의 이전 날짜
		LAG(temperature) OVER (ORDER BY recordDate) AS pre_t -- 각 날짜의 이전 기온
	FROM Weather
) AS a
WHERE DATE_ADD(pre_rd, INTERVAL 1 DAY) = recordDate -- 안쓸경우, '2015-01-14', '2015-01-16'에서 예외 상황 발생
AND pre_t < temperature;


##### 만약 LAG, LEAD 함수를 지원하지 않는 경우 (ex. 낮은 버전의 SQLLite DB 엔진)
# [PRACTICE]
SELECT *
FROM Weather AS w1
INNER JOIN Weather AS w2
ON DATE_ADD(w1.recordDate, INTERVAL -1 DAY) = w2.recordDate;

# [MYSQL2]
# self join
SELECT w1.id
FROM Weather AS w1
INNER JOIN Weather AS w2
ON DATE_ADD(w1.recordDate, INTERVAL -1 DAY) = w2.recordDate
WHERE w1.temperature > w2.temperature;

# 참고: https://stackoverflow.com/questions/53630542/alternatives-to-lead-and-lag-in-sqlite
# [PRACTICE]
SELECT
    id,
    recordDate AS rd,
    temperature AS t,
    (
    SELECT
         t1.recordDate
     FROM Weather t1
     WHERE t1.recordDate < a.recordDate # 이전 날짜들 중에서
     ORDER BY t1.recordDate DESC
     LIMIT 1
    ) AS pre_rd,
    (
    SELECT
         t1.temperature
     FROM Weather t1
     WHERE t1.recordDate < a.recordDate # 이전 날짜들 중에서
     ORDER BY t1.recordDate DESC
     LIMIT 1
    ) AS pre_t
FROM Weather AS a; 

# [MYSQL3]
SELECT
    id
FROM (
	SELECT
          id,
          recordDate AS rd,
          temperature AS t,
          (
          SELECT
               t1.recordDate
           FROM Weather t1
           WHERE t1.recordDate < a.recordDate # 이전 날짜들 중에서
           ORDER BY t1.recordDate DESC
           LIMIT 1
          ) AS pre_rd,
          (
          SELECT
               t1.temperature
           FROM Weather t1
           WHERE t1.recordDate < a.recordDate # 이전 날짜들 중에서
           ORDER BY t1.recordDate DESC
           LIMIT 1
          ) AS pre_t
      FROM Weather AS a
) AS t
WHERE DATE_ADD(pre_rd, INTERVAL 1 DAY) = rd # 안쓸경우, '2015-01-14', '2015-01-16'에서 예외 상황 발생
AND pre_t < t; 

