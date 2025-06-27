/*
https://leetcode.com/problems/game-play-analysis-i/ 

Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
(player_id, event_date)는 이 테이블의 기본 키입니다.
이 표는 일부 게임의 플레이어 활동을 보여줍니다.
각 행은 특정 장치를 통해 로그인 한 후에, 로그아웃하기 전까지 플레이한 게임 횟수(0도 가능)의 기록입니다.


Write an SQL query to report the first login date for each player.
Return the result table in any order.
각 플레이어의 첫 번째 로그인 날짜를 보고하는 SQL 쿼리를 작성하세요.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
설명:
player_id가 1인 플레이어는 2016-03-01과 2016-05-02에 로그인 기록이 있습니다. 이 중 가장 이른 날짜는 2016-03-01입니다.
player_id가 2인 플레이어는 2017-06-25에 로그인 기록이 있습니다. 따라서 이 날짜가 첫 로그인 날짜입니다.
player_id가 3인 플레이어는 2016-03-02와 2018-07-03에 로그인 기록이 있습니다. 이 중 가장 이른 날짜는 2016-03-02입니다.
*/

# [SETTING]
USE practice;
DROP TABLE Activity;
CREATE TABLE Activity (
  player_id INT,
  device_id INT,
  event_date DATE,
  games_played INT
);
INSERT INTO
  Activity (player_id, device_id, event_date, games_played)
VALUES
  (1, 2, '2016-03-01', 5),
  (1, 2, '2016-05-02', 6),
  (2, 3, '2017-06-25', 1),
  (3, 1, '2016-03-02', 0),
  (3, 4, '2018-07-03', 5);
SELECT *
FROM Activity;

# [KEY]
# 어렵게 RANK 또는 ROW_NUMBER() 사용할 필요 없이,  MIN 집계 함수 이용해서 쉽게 풀기
# 'first' 문제는 MIN과 연결, 'last' 문제는 MAX와 연결

# [MYSQL]
SELECT
  player_id,
  MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;