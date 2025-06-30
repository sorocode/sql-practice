/*
https://leetcode.com/problems/sales-person/ 

Table: SalesPerson
+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| sales_id        | int     |
| name            | varchar |
| salary          | int     |
| commission_rate | int     |
| hire_date       | date    |
+-----------------+---------+
sales_id is the primary key column for this table.
Each row of this table indicates the name and the ID of a SalesPerson alongside their salary, commission rate, and hire date.
sales_id는 이 테이블의 기본 키 열입니다.
이 테이블의 각 행에는 영업사원의 ID, 이름, 급여, 수수료율, 채용 날짜가 표시됩니다.


Table: Company
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| com_id      | int     |
| name        | varchar |
| city        | varchar |
+-------------+---------+
com_id is the primary key column for this table.
Each row of this table indicates the name and the ID of a company and the city in which the company is located.
com_id는 이 테이블의 기본 키 열입니다.
이 테이블의 각 행은 회사의 ID, 이름, 회사가 위치한 도시를 나타냅니다.


Table: Orders
+-------------+------+
| Column Name | Type |
+-------------+------+
| order_id    | int  |
| order_date  | date |
| com_id      | int  |
| sales_id    | int  |
| amount      | int  |
+-------------+------+
order_id is the primary key column for this table.
com_id is a foreign key to com_id from the Company table.
sales_id is a foreign key to sales_id from the SalesPerson table.
Each row of this table contains information about one order.
This includes the ID of the company, the ID of the SalesPerson, the date of the order, and the amount paid.
order_id는 이 테이블의 기본 키 열입니다.
com_id는 Company 테이블의 com_id에 대한 외래 키입니다.
sales_id는 SalesPerson 테이블의 sales_id에 대한 외래 키입니다.
이 테이블의 각 행에는 하나의 주문에 대한 정보가 포함되어 있습니다.
여기에는 회사 ID, 영업사원 ID, 주문 날짜, 결제 금액이 포함됩니다.


Write an SQL query to report the names of all the SalesPersons who did not have any Orders related to the company with the name "RED".
Return the result table in any order.
이름이 "RED"인 회사와 관련된 주문이 없는 모든 영업사원의 이름을 보고하는 SQL 쿼리를 작성하세요.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
SalesPerson table:
+----------+------+--------+-----------------+------------+
| sales_id | name | salary | commission_rate | hire_date  |
+----------+------+--------+-----------------+------------+
| 1        | John | 100000 | 6               | 4/1/2006   |
| 2        | Amy  | 12000  | 5               | 5/1/2010   |
| 3        | Mark | 65000  | 12              | 12/25/2008 |
| 4        | Pam  | 25000  | 25              | 1/1/2005   |
| 5        | Alex | 5000   | 10              | 2/3/2007   |
+----------+------+--------+-----------------+------------+
Company table:
+--------+--------+----------+
| com_id | name   | city     |
+--------+--------+----------+
| 1      | RED    | Boston   |
| 2      | ORANGE | New York |
| 3      | YELLOW | Boston   |
| 4      | GREEN  | Austin   |
+--------+--------+----------+
Orders table:
+----------+------------+--------+----------+--------+
| order_id | order_date | com_id | sales_id | amount |
+----------+------------+--------+----------+--------+
| 1        | 1/1/2014   | 3      | 4        | 10000  |
| 2        | 2/1/2014   | 4      | 5        | 5000   |
| 3        | 3/1/2014   | 1      | 1        | 50000  |
| 4        | 4/1/2014   | 1      | 4        | 25000  |
+----------+------------+--------+----------+--------+
Output: 
+------+
| name |
+------+
| Amy  |
| Mark |
| Alex |
+------+
Explanation: 
According to orders 3 and 4 in the Orders table, it is easy to tell that only SalesPerson John and Pam have sales to company RED, so we report all the other names in the table SalesPerson.
설명:
Orders 테이블의 주문 3과 4에 따르면, 영업사원 John과 Pam만이 RED 회사에 판매를 했습니다. 따라서 나머지 영업사원인 Amy, Mark, Alex의 이름을 결과로 반환합니다.
*/

# [SETTING]
USE practice;
DROP TABLE SalesPerson;
CREATE TABLE SalesPerson
(
    sales_id        INT,
    name            VARCHAR(255),
    salary          INT,
    commission_rate INT,
    hire_date       DATE
);
INSERT INTO SalesPerson
    (sales_id, name, salary, commission_rate, hire_date)
VALUES (1, 'John', 100000, 6, '2006-04-01'),
    (2, 'Amy', 120000, 5, '2010-05-01'),
    (3, 'Mark', 65000, 12, '2008-12-24'),
    (4, 'Pam', 25000, 25, '2005-01-01'),
    (5, 'Alex', 50000, 10, '2007-02-03');
SELECT *
FROM SalesPerson; 

# [SETTING]
USE practice;
DROP TABLE Company;
CREATE TABLE Company
(
    com_id INT,
    name   VARCHAR(255),
    city   VARCHAR(255)
);
INSERT INTO Company
    (com_id, name, city)
VALUES (1, 'RED', 'Boston'),
    (2, 'ORANGE', 'New York'),
    (3, 'YELLOW', 'Boston'),
    (4, 'GREEN', 'Austin');
SELECT *
FROM Company; 

# [SETTING]
USE practice;
DROP TABLE Orders;
CREATE TABLE Orders
(
    order_id INT,
    dates    DATE,
    com_id   INT,
    sales_id INT,
    amount   INT
);
INSERT INTO Orders
    (order_id, dates, com_id, sales_id, amount)
VALUES (1, '2014-01-01', 3, 4, 100000),
    (2, '2014-02-01', 4, 5, 5000),
    (3, '2014-03-01', 1, 1, 50000),
    (4, '2014-04-01', 1, 4, 25000);
SELECT *
FROM Orders; 

# [PRACTICE]
# 서브쿼리: John(sales_id=1)과 Pam(sales_id=4) 출력
SELECT *
FROM Orders
WHERE com_id IN (
	SELECT
		com_id
	FROM Company
	WHERE name = 'RED'
);

# [MYSQL]
# 아직 영업을 하지 못한 Mark(sales_id=3), Amy(sales_id=2)
# -> 최종 query에도 이들이 포함된다.
SELECT
    name
FROM SalesPerson
WHERE sales_id NOT IN (
	SELECT
		sales_id
	FROM Orders
	WHERE com_id IN (
		SELECT
			com_id
		FROM Company
		WHERE name = 'RED'
	)
);

