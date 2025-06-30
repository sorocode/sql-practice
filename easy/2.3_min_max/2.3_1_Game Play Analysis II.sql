/*
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
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
(player_id, event_date)는 이 테이블의 기본 키입니다.
이 표는 일부 게임의 플레이어 활동을 보여줍니다.
각 행은 특정 장치를 통해 로그인 한 후에, 로그아웃하기 전까지 플레이한 게임 횟수(0도 가능)의 기록입니다.


Write a SQL query that reports the device that is first logged in for each player.
각 플레이어에 대해 처음 로그인된 장치를 보고하는 SQL 쿼리를 작성합니다.


Example:
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

Result table:
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+
설명:
player_id가 1인 플레이어는 2016-03-01과 2016-05-02에 로그인 기록이 있습니다. 이 중 가장 이른 날짜는 2016-03-01이며, 이 날짜에 사용된 장치는 device_id 2입니다.
player_id가 2인 플레이어는 2017-06-25에 로그인 기록이 있습니다. 따라서 이 날짜에 사용된 장치는 device_id 3입니다.
player_id가 3인 플레이어는 2016-03-02와 2018-07-03에 로그인 기록이 있습니다. 이 중 가장 이른 날짜는 2016-03-02이며, 이 날짜에 사용된 장치는 device_id 1입니다.
*/

# [SETTING]
USE practice;
DROP TABLE Activity;
CREATE TABLE Activity
(
    player_id    INT,
    device_id    INT,
    event_date   DATE,
    games_played INT
);
INSERT INTO Activity
    (player_id, device_id, event_date, games_played)
VALUES (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);
SELECT *
FROM Activity;  

# [PRACTICE]
SELECT
    player_id,
    MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

# [MYSQL1]
# MIN
SELECT
    a.player_id,
    a.device_id
FROM Activity AS a
INNER JOIN (
	SELECT
		player_id,
		MIN(event_date) AS min_date
	FROM Activity
	GROUP BY player_id
) aa
ON a.player_id = aa.player_id
    AND a.event_date = aa.min_date; -- 각 플레이어의 가장 이른 로그인 날짜와 연결
    
# [PRACTICE]
SELECT
    player_id,
    event_date,
    device_id,
    RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rk
FROM Activity
ORDER BY player_id, event_date; 

# [MYSQL2]
# RANK
SELECT
    player_id,
    device_id
FROM (
	SELECT
	  player_id,
	  device_id,
	  RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rk
FROM Activity
) AS a
WHERE rk = 1; 