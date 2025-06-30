/*
https://leetcode.com/problems/user-activity-for-the-past-30-days-i/ 

Table: Activity
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
The activity_type column is an ENUM of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.
이 테이블에는 기본 키가 없습니다. 중복된 행이 있을 수 있습니다.
activity_type 열은 ('open_session', 'end_session', 'scroll_down', 'send_message') 유형의 ENUM입니다.
표에는 소셜 미디어 웹사이트의 사용자 활동이 나와 있습니다.
각 세션은 정확히 한 명의 사용자에게 속합니다.


Write an SQL query to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively.
A user was active on someday if they made at least one activity on that day.
Return the result table in any order.
2019년 7월 27일까지 30일 동안의 일일 활성 사용자 수를 찾는 SQL 쿼리를 작성하세요.
사용자가 해당 날짜에 하나 이상의 활동을 수행한 경우 해당 날짜에 활성 상태 입니다.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+
Output: 
+------------+--------------+ 
| day        | active_users |
+------------+--------------+ 
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+ 
설명:
2019-07-20:
user_id 1는 3개의 활동 (open_session, scroll_down, end_session)을 하고, user_id 2는 1개의 활동 (open_session)을 하였습니다.
총 2명의 고유한 활성 사용자가 있습니다.

2019-07-21:
user_id 2는 2개의 활동 (send_message, end_session), user_id 3는 3개의 활동 (open_session, send_message, end_session)을 하였습니다.
총 2명의 고유한 활성 사용자가 있습니다.
*/

# [SETTING]
USE practice;
DROP TABLE Activity;
CREATE TABLE Activity
(
    user_id       INT,
    session_id    INT,
    activity_date DATE,
    activity_type VARCHAR(255)
);
INSERT INTO Activity
    (user_id, session_id, activity_date, activity_type)
VALUES (1, 1, '2019-07-20', 'open_session'),
    (1, 1, '2019-07-20', 'scroll_down'),
    (1, 1, '2019-07-20', 'end_session'),
    (2, 4, '2019-07-20', 'open_session'),
    (2, 4, '2019-07-21', 'send_message'),
    (2, 4, '2019-07-21', 'end_session'),
    (3, 2, '2019-07-21', 'open_session'),
    (3, 2, '2019-07-21', 'send_message'),
    (3, 2, '2019-07-21', 'end_session'),
    (4, 3, '2019-06-25', 'open_session'),
    (4, 3, '2019-06-25', 'end_session');
SELECT *
FROM Activity; 

# [WRONG DATE]
SELECT
    '2019-07-27' AS dt,
    '2019-07-27' - 30 AS dt_sub,
    '2019-07-27' + 30 AS dt_add;
    

# [RIGHT DATE]
# DATE_SUB 함수, DATE_ADD 함수
SELECT
    '2019-07-27' AS dt,
    DATE_SUB('2019-07-27', INTERVAL 30 DAY) AS dt_sub,
    DATE_ADD('2019-07-27', INTERVAL 30 DAY) AS dt_add;
    

# [MYSQL]
# '30일 동안': 한 쪽은 등호 있고, 한 쪽은 등호가 없어야지 기간이 30일이 된다.
SELECT
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE DATE_SUB('2019-07-27', INTERVAL 30 DAY) < activity_date
AND activity_date <= '2019-07-27'
GROUP BY activity_date;