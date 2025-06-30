/*
Table: Delivery
+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the primary key of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
delivery_id는 이 테이블의 기본 키입니다.
테이블에는 특정 날짜에 주문한 고객의 음식 배달 정보와 원하는 배송 날짜(동일한 주문 날짜 또는 그 이후) 정보를 포함합니다.


If the preferred delivery date of the customer is the same as the order date then the order is called 'immediate'
otherwise it called 'scheduled'.
Write an SQL query to find the percentage of 'immediate' orders in the table, rounded to 2 decimal places.
고객이 원하는 배송 날짜가 주문 날짜와 동일한 경우 'immediate'라고 합니다.
그렇지 않으면 'scheduled'라고 합니다.
테이블에서 소수점 이하 2자리까지 반올림된 'immediate' 주문의 백분율을 찾는 SQL 쿼리를 작성하세요.


Example:
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 5           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-11                  |
| 4           | 3           | 2019-08-24 | 2019-08-26                  |
| 5           | 4           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
+-------------+-------------+------------+-----------------------------+
Result table:
+----------------------+
| immediate_percentage |
+----------------------+
| 33.33                |
+----------------------+
Explanation: The orders with delivery id 2 and 3 are immediate while the others are scheduled.
설명: 배송 ID가 2와 3인 주문은 즉시 주문이고 나머지 주문은 예약입니다.
*/

# [SETTING]
USE practice;
DROP TABLE Delivery;
CREATE TABLE Delivery
(
    delivery_id                 INT,
    customer_id                 INT,
    order_date                  DATE,
    customer_pref_delivery_date DATE
);
INSERT INTO Delivery
    (delivery_id, customer_id, order_date, customer_pref_delivery_date)
VALUES (1, 1, '2019-08-01', '2019-08-02'),
    (2, 5, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-11'),
    (4, 3, '2019-08-24', '2019-08-26'),
    (5, 4, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13');
SELECT *
FROM Delivery; 

# [MYSQL1]
# SUM 집계 함수 사용
SELECT
    ROUND((SUM(CASE WHEN order_date = customer_pref_delivery_date
            THEN 1 ELSE 0 END) / COUNT(*) * 100), 2) AS immediate_percentage -- ELSE 0 안써도 결과 동일
FROM Delivery; 

# [MYSQL2]
# COUNT 집계 함수 사용
# 참고: https://stackoverflow.com/questions/40101963/can-we-write-case-statement-without-having-else-statement
# -> 집계 함수는 null을 무시한다.
SELECT
    ROUND((COUNT(CASE WHEN order_date = customer_pref_delivery_date 
            THEN 1 end) / COUNT(*) * 100), 2) AS immediate_percentage -- ELSE는 자동으로 null로 취급 -> null은 집계에 포함이 안된다.
FROM Delivery; 


# [WRONG]
# COUNT 쓸 때 ELSE 0을 써버리면, 0으로 나온 row에 대해서도 COUNT에 포함되기 때문에, 걸국 전체 개수 COUNT(*)와 의미가 같아진다.
SELECT
    ROUND((COUNT(CASE WHEN order_date = customer_pref_delivery_date
            THEN 1 ELSE 0 END) / COUNT(*) * 100), 2) AS immediate_percentage
FROM Delivery; 