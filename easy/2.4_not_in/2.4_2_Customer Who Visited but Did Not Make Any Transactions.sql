/*
https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/ 

Table: Visits
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
visit_id is the primary key for this table.
This table contains information about the customers who visited the mall.
Visit_id는 이 테이블의 기본 키입니다.
해당 테이블에는 쇼핑몰을 방문한 고객에 대한 정보가 포함되어 있습니다.


Table: Transactions
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
transaction_id is the primary key for this table.
This table contains information about the transactions made during the visit_id.
transaction_id는 이 테이블의 기본 키입니다.
이 테이블에는 visit_id 동안 발생한 거래에 대한 정보가 포함되어 있습니다.


Write a SQL query to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
Return the result table sorted in any order.
거래 없이 방문한 사용자의 ID와 이러한 유형의 방문 횟수를 찾는 SQL 쿼리를 작성하세요.
임의의 순서로 정렬된 결과 테이블을 반환합니다.


Example:
Input: 
Visits
+----------+-------------+
| visit_id | customer_id |
+----------+-------------+
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |
+----------+-------------+
Transactions
+----------------+----------+--------+
| transaction_id | visit_id | amount |
+----------------+----------+--------+
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |
+----------------+----------+--------+
Output: 
+-------------+----------------+
| customer_id | count_no_trans |
+-------------+----------------+
| 54          | 2              |
| 30          | 1              |
| 96          | 1              |
+-------------+----------------+
Explanation: 
Customer with id = 23 visited the mall once and made one transaction during the visit with id = 12.
Customer with id = 9 visited the mall once and made one transaction during the visit with id = 13.
Customer with id = 30 visited the mall once and did not make any transactions.
Customer with id = 54 visited the mall three times. During 2 visits they did not make any transactions, and during one visit they made 3 transactions.
Customer with id = 96 visited the mall once and did not make any transactions.
As we can see, users with IDs 30 and 96 visited the mall one time without making any transactions.
Also, user 54 visited the mall twice and did not make any transactions.
설명:
ID = 23인 고객은 쇼핑몰을 한 번 방문하고, transaction_id = 12에서 1번의 거래를 했습니다.
ID = 9인 고객은 쇼핑몰을 한 번 방문하고, transaction_id = 13에서 1번의 거래를 했습니다.
ID = 30인 고객은 쇼핑몰을 한 번 방문했지만 거래를 하지 않았습니다.
ID = 54인 고객은 쇼핑몰을 세 번 방문했습니다. 두 번의 방문 동안 어떤 거래도 하지 않았고, 한 번의 방문 동안 transaction_id = 2,3, 9에서 세 번의 거래를 했습니다.
ID = 96인 고객은 쇼핑몰을 한 번 방문했지만 거래를 하지 않았습니다.
즉, ID 30과 96의 사용자는 거래 없이 한 번 쇼핑몰을 방문했습니다. 또한, 사용자 54는 쇼핑몰을 두 번 방문했지만 거래를 하지 않았습니다.
*/

# [SETTING]
USE practice;
DROP TABLE Visits;
CREATE TABLE Visits
(
    visit_id    INT,
    customer_id INT
);
INSERT INTO Visits
    (visit_id, customer_id)
VALUES (1, 23),
    (2, 9),
    (4, 30),
    (5, 54),
    (6, 96),
    (7, 54),
    (8, 54);
SELECT *
FROM Visits; 

# [SETTING]
USE practice;
DROP TABLE Transactions;
CREATE TABLE Transactions
(
    transaction_id INT,
    visit_id       INT,
    amount         INT
);
INSERT INTO Transactions
    (transaction_id, visit_id, amount)
VALUES (2, 5, 310),
    (3, 5, 300),
    (9, 5, 200),
    (12, 1, 910),
    (13, 2, 970);
SELECT *
FROM Transactions; 

# [PRACTICE]
SELECT *
FROM Visits AS v
LEFT OUTER JOIN Transactions AS t
ON v.visit_id = t.visit_id;

# [MYSQL1]
# LEFT OUTER JOIN
SELECT
    v.customer_id,
    COUNT(v.visit_id) AS count_no_trans
FROM Visits AS v
LEFT OUTER JOIN Transactions AS t
ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id; 

# [PRACTICE]
SELECT
	visit_id
FROM Transactions;

# [PRACTICE]
SELECT *
FROM Visits
WHERE visit_id NOT IN (
	SELECT
		visit_id
	FROM Transactions
);

# [MYSQL2]
# NOT IN
SELECT
    customer_id,
    COUNT(visit_id) AS count_no_trans
FROM Visits
WHERE visit_id NOT IN (
	SELECT
		visit_id
	FROM Transactions
)
GROUP BY customer_id; 