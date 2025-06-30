/*
Table: Product
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
| unit_price   | int     |
+--------------+---------+
product_id is the primary key of this table.
product_id는 이 테이블의 기본 키입니다.


Table: Sales
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| seller_id   | int     |
| product_id  | int     |
| buyer_id    | int     |
| sale_date   | date    |
| quantity    | int     |
| price       | int     |
+------ ------+---------+
This table has no primary key, it can have repeated rows.
product_id is a foreign key to Product table.
이 테이블에는 기본 키가 없으며 반복되는 행이 있을 수 있습니다.
product_id는 Product 테이블의 외래 키입니다.


Write an SQL query that reports the best seller by total sales price, If there is a tie, report them all.
총 판매 가격을 기준으로 베스트셀러를 보고하는 SQL 쿼리를 작성하고, 동점인 경우 모두 보고합니다.


Example:
Product table:
+------------+--------------+------------+
| product_id | product_name | unit_price |
+------------+--------------+------------+
| 1          | S8           | 1000       |
| 2          | G4           | 800        |
| 3          | iPhone       | 1400       |
+------------+--------------+------------+
Sales table:
+-----------+------------+----------+------------+----------+-------+
| seller_id | product_id | buyer_id | sale_date  | quantity | price |
+-----------+------------+----------+------------+----------+-------+
| 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
| 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
| 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
| 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |
+-----------+------------+----------+------------+----------+-------+
Result table:
+-------------+
| seller_id   |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: Both sellers with id 1 and 3 sold products with the most total price of 2800.
설명: ID가 1과 3인 두 판매자 모두 총 가격이 2800으로 가장 높은 제품을 판매했습니다.
*/

# [SETTING]
USE practice;
DROP TABLE Sales;
CREATE TABLE Sales
(
    seller_id  INT,
    product_id INT,
    buyer_id   INT,
    sale_date  DATE,
    quantity   INT,
    price	   INT
);
INSERT INTO Sales
    (seller_id, product_id, buyer_id, sale_date, quantity, price)
VALUES (1, 1, 1, '2019-01-21', 2, 2000),
    (1, 2, 2, '2019-01-17', 1, 800),
    (2, 2, 3, '2019-01-02', 1, 800),
    (3, 3, 4, '2019-01-13', 2, 2800);
SELECT *
FROM Sales; 	    
        
# [SETTING]
USE practice;
DROP TABLE Product;
CREATE TABLE Product
(
    product_id   INT,
    product_name VARCHAR(255),
    unit_price   INT
);
INSERT INTO Product
    (product_id, product_name, unit_price)
VALUES (1, 'S8', 1000),
    (2, 'G4', 800),
    (3, 'iPhone', 1400);
SELECT *
FROM Product; 

# [PRACTICE]
SELECT
	seller_id,
	SUM(price) AS tot_price
FROM Sales
GROUP BY seller_id
ORDER BY tot_price DESC; 

# [PRACTICE]
# GROUP BY를 사용하였기 때문에, RANK의 ORDER BY 안에서 집계 함수 바로 사용 가능  
# RANK, DENSE_RANK, ROW_NUMBER 차이점 확인하기!
SELECT
	seller_id,
	SUM(price) AS tot_price,
	RANK() OVER (ORDER BY SUM(price) DESC) AS rk,
	DENSE_RANK() OVER (ORDER BY SUM(price) DESC) AS drk,
	ROW_NUMBER() OVER (ORDER BY SUM(price) DESC) AS rn
FROM Sales
GROUP BY seller_id
ORDER BY tot_price DESC; 

# [PRACTICE]
# RANK의 ORDER BY 안에 집계 함수를 사용하는 것이 헷갈리면, 서브 쿼리 사용해도 괜찮다.
SELECT *,
RANK() OVER (ORDER BY tot_price DESC) AS rk,
DENSE_RANK() OVER (ORDER BY tot_price DESC) AS drk,
ROW_NUMBER() OVER (ORDER BY tot_price DESC) AS rn
FROM
(
	SELECT
		seller_id,
		SUM(price) AS tot_price
	FROM Sales
	GROUP BY seller_id
) AS a
ORDER BY tot_price DESC; 

# [MYSQL]
SELECT
    seller_id,
    tot_price
FROM (
	SELECT
		seller_id,
		SUM(price) AS tot_price,
		RANK() OVER (ORDER BY SUM(price) DESC) AS rk,
		DENSE_RANK() OVER (ORDER BY SUM(price) DESC) AS drk
		FROM Sales
		GROUP BY seller_id
) AS a
WHERE rk = 1; -- rk=1 또는 drk=1 정답, ROW_NUMBER 사용은 불가능