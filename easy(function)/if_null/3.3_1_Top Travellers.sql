/*
https://leetcode.com/problems/top-travellers/ 

Table: Users
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key for this table.
name is the name of the user.
id는 이 테이블의 기본 키입니다.
name은 사용자의 이름입니다.


Table: Rides
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| user_id       | int     |
| distance      | int     |
+---------------+---------+
id is the primary key for this table.
user_id is the id of the user who traveled the distance "distance".
id는 이 테이블의 기본 키입니다.
user_id는 distance 거리를 이동한 사용자의 ID입니다.
 
 
Write an SQL query to report the distance traveled by each user.
Return the result table ordered by travelled_distance in descending order,
if two or more users traveled the same distance, order them by their name in ascending order.
각 사용자가 이동한 거리를 보고하는 SQL 쿼리를 작성합니다.
travelled_distance 기준으로 정렬된 결과 테이블을 내림차순으로 반환하고,
두 명 이상의 사용자가 동일한 거리를 이동한 경우 이름을 기준으로 오름차순으로 정렬합니다.


Example:
Input: 
Users table:
+------+-----------+
| id   | name      |
+------+-----------+
| 1    | Alice     |
| 2    | Bob       |
| 3    | Alex      |
| 4    | Donald    |
| 7    | Lee       |
| 13   | Jonathan  |
| 19   | Elvis     |
+------+-----------+
Rides table:
+------+----------+----------+
| id   | user_id  | distance |
+------+----------+----------+
| 1    | 1        | 120      |
| 2    | 2        | 317      |
| 3    | 3        | 222      |
| 4    | 7        | 100      |
| 5    | 13       | 312      |
| 6    | 19       | 50       |
| 7    | 7        | 120      |
| 8    | 19       | 400      |
| 9    | 7        | 230      |
+------+----------+----------+
Output: 
+----------+--------------------+
| name     | travelled_distance |
+----------+--------------------+
| Elvis    | 450                |
| Lee      | 450                |
| Bob      | 317                |
| Jonathan | 312                |
| Alex     | 222                |
| Alice    | 120                |
| Donald   | 0                  |
+----------+--------------------+
Explanation: 
Elvis and Lee traveled 450 miles, Elvis is the top traveler as his name is alphabetically smaller than Lee.
Bob, Jonathan, Alex, and Alice have only one ride and we just order them by the total distances of the ride.
Donald did not have any rides, the distance traveled by him is 0.
설명:
Elvis와 Lee는 450마일을 여행했습니다. Elvis는 Lee보다 알파벳순으로 이름이 작기 때문에 최고의 여행자입니다.
Bob, Jonathan, Alex, Alice는 한 번만 이동했으며 총 탑승 거리를 기준으로 순서를 지정합니다.
Donald는 이동하지 않았으므로 그가 이동한 거리는 0입니다.
*/

# [SETTING]
USE practice;
DROP TABLE Users;
CREATE TABLE Users
(
    id   INT,
    name VARCHAR(30)
);
INSERT INTO Users
    (id, name)
VALUES (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Alex'),
    (4, 'Donald'),
    (7, 'Lee'),
    (13, 'Jonathan'),
    (19, 'Elvis');
SELECT *
FROM Users; 

# [SETTING]
USE practice;
DROP TABLE Rides;
CREATE TABLE Rides
(
    id       INT,
    user_id  INT,
    distance INT
);
INSERT INTO Rides
    (id, user_id, distance)
VALUES (1, 1, 120),
    (2, 2, 317),
    (3, 3, 222),
    (4, 7, 100),
    (5, 13, 312),
    (6, 19, 50),
    (7, 7, 120),
    (8, 19, 400),
    (9, 7, 230);
SELECT *
FROM Rides; 

# [PRACTICE]
SELECT *
FROM Users AS u
LEFT OUTER JOIN Rides AS r
ON u.id = r.user_id; 

# [REFERENCE]
# COUNT: IFNULL을 사용하지 않으면, COUNT(NULL)=0으로 나온다 (말 그대로 개수가 0개 이기 때문에)
# SUM: IFNULL을 사용하지 않으면, SUM(NULL)=NULL로 나온다
SELECT
    u.name AS name,
    COUNT(r.distance) AS test1, -- 결과: [Donald] COUNT=0
    COUNT(u.id) AS test2,       -- 결과: [Donald] COUNT=1
    SUM(r.distance) AS test3 -- 결과: [Donald] SUM=NULL
FROM Users AS u
LEFT OUTER JOIN Rides AS r
ON u.id = r.user_id
GROUP BY u.id, u.name; -- u.name만 쓰는 것은 비추천. 동명이인이 나올 수 있기 때문에

# [WRONG]
SELECT
    u.name,
    SUM(r.distance) AS travelled_distance -- 결과: NULL -> 틀림!
FROM Users AS u
LEFT OUTER JOIN Rides AS r
ON u.id = r.user_id
GROUP BY u.id, u.name -- u.name만 쓰는 것은 비추천. 동명이인이 나올 수 있기 때문에
ORDER BY travelled_distance DESC, name;

# [MYSQL]
SELECT
    u.name,
    IFNULL(SUM(r.distance), 0) AS travelled_distance
FROM Users AS u
LEFT OUTER JOIN Rides AS r
ON u.id = r.user_id
GROUP BY u.id, u.name -- u.name만 쓰는 것은 비추천. 동명이인이 나올 수 있기 때문에
ORDER BY travelled_distance DESC, name;