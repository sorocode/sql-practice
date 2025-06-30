/*
Table: Cinema
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| seat_id       | int     |
| free          | bool    |
+---------------+---------+
The seat_id is an auto increment integer, and free is bool (1 means free, and 0 means occupied.).
Consecutive available seats are more than 2(inclusive) seats consecutively available.
seat_id는 자동 증가 integer이고 free는 bool입니다 (1은 비어 있음을 의미하고 0은 점유를 의미함).


Several friends at a cinema ticket office would like to reserve consecutive available seats.
Can you help to query all the consecutive available seats order by the seat_id using the following Cinema table?
영화관 매표소에 있는 여러 친구가 연속된 좌석을 예약하고 싶어합니다.
다음 Cinema 테이블을 사용하여, 연속 사용 가능한 모든 좌석을 seat_id 순서대로 쿼리를 작성하세요.
연속 이용 가능 좌석은 2석 이상 연속 이용 가능 좌석입니다.

Example:
Input: 
Cinema table:
+---------+------+
| seat_id | free |
|---------|------|
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
+---------+------+
Output: 
+---------+
| seat_id |
|---------|
| 3       |
| 4       |
| 5       |
+---------+
seat_id가 3, 4, 5인 좌석이 연속으로 비어 있습니다 (free 값이 1).
따라서 이 좌석들은 연속으로 이용 가능한 좌석으로, 친구들이 함께 예약할 수 있습니다.
이 좌석들은 seat_id 순서대로 정렬되어 있습니다.
*/

# [SETTING]
USE practice;
DROP TABLE Cinema;
CREATE TABLE Cinema
(
    seat_id INT,
    free    INT
);
INSERT INTO Cinema
    (seat_id, free)
VALUES (1, 1),
    (2, 0),
    (3, 1),
    (4, 1),
    (5, 1);
SELECT *
FROM Cinema; 

# [KEY]
# 'consecutive': (1) 이전 좌석과 지금 좌석 비교, (2) 지금 좌석과 이후 좌석 비교

# [PRACTICE]
SELECT
    seat_id,
    LAG(free) OVER (ORDER BY seat_id) AS prev_free,
    free,
    LEAD(free) OVER (ORDER BY seat_id) AS post_free
FROM Cinema
ORDER BY seat_id; 

# [MYSQL]
SELECT
    seat_id
FROM (
	SELECT
		seat_id,
		LAG(free) OVER (ORDER BY seat_id) AS prev_free,
		free,
		LEAD(free) OVER (ORDER BY seat_id) AS post_free
	FROM Cinema
) AS s
WHERE (free = 1 AND post_free = 1) OR (prev_free = 1 AND free = 1)
ORDER BY seat_id; 