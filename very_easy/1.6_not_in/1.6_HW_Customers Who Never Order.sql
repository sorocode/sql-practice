/*
https://leetcode.com/problems/customers-who-never-order/ 

Table: Customers
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID and name of a customer.
id는 이 테이블의 기본 키 열입니다.
이 테이블의 각 행은 고객의 ID와 이름을 나타냅니다.

 
Table: Orders
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
id is the primary key column for this table.
customerId is a foreign key of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.
id는 이 테이블의 기본 키 열입니다.
customerId는 Customers 테이블 ID의 외래 키입니다.
이 테이블의 각 행은 주문 ID와 주문한 고객의 ID를 나타냅니다.


Write an SQL query to report all customers who never order anything.
Return the result table in any order.
아무것도 주문하지 않은 모든 고객을 보고하는 SQL 쿼리를 작성하세요.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Customers table:
+----+-------+
| id | name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Orders table:
+----+------------+
| id | customerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Output: 
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
*/

# [SETTING]
USE practice;
DROP TABLE Customers;
CREATE TABLE Customers (
	id INT,
	name VARCHAR(255)
);
INSERT INTO
  Customers (id, name)
VALUES
  (1, 'Joe'),
  (2, 'Henry'),
  (3, 'Sam'),
  (4, 'Max');
SELECT *
FROM Customers;

# [SETTING]
USE practice;
DROP TABLE Orders;
CREATE TABLE Orders (
	id INT,
	customerid INT
);
INSERT INTO
  Orders (id, customerid)
VALUES
  (1, 3),
  (2, 1);
SELECT *
FROM Orders;

# [KEY]
# 'all customers who NEVER order anything': 여집합의 NOT IN 고려

# [MYSQL]
SELECT
  name AS customers
FROM Customers
WHERE id NOT IN (
    SELECT
      customerid
    FROM Orders
);
