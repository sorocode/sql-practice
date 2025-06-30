/*
https://leetcode.com/problems/average-selling-price/ 

Table: Prices
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
(product_id, start_date, end_date) is the primary key for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods.
That means there will be no two intersecting periods for the same product_id.
(product_id, start_date, end_date)는 이 테이블의 기본 키입니다.
이 테이블의 각 행은 start_date부터 end_date까지의 기간 동안 product_id의 가격을 나타냅니다.
각 product_id에 대해 두 개의 겹치는 기간이 없습니다.
이는 동일한 product_id에 대해 겹치는 기간이 없음을 의미합니다.


Table: UnitsSold
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
There is no primary key for this table, it may contain duplicates.
Each row of this table indicates the date, units, and product_id of each product sold. 
이 테이블에는 기본 키가 없으며 중복된 내용이 포함될 수 있습니다.
이 테이블의 각 행은 판매된 각 제품의 날짜, 단위 및 product_id를 나타냅니다.


Write an SQL query to find the average selling price for each product.
average_price should be rounded to 2 decimal places.
Return the result table in any order.
각 제품의 평균 판매 가격을 구하는 SQL 쿼리를 작성하세요.
average_price는 소수점 이하 2자리로 반올림되어야 합니다.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
| 3          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+
UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+
Output: 
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
| 3          |   0           |
+------------+---------------+
Explanation: 
Average selling price = Total Price of Product / Number of products sold.
Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96
설명:
평균판매가격 = 총 상품가격 / 판매된 상품수
제품 1의 평균 판매 가격 = ((100 * 5) + (15 * 20)) / 115 = 6.96
제품 2의 평균 판매 가격 = ((200 * 15) + (30 * 30)) / 230 = 16.96
제품 3의 평균 판매 가격 = 팔린 제품이 없으므로 0
*/

# [SETTING]
USE practice;
DROP TABLE Prices;
CREATE TABLE Prices
(
    product_id INT,
    start_date DATE,
    end_date   DATE,
    price      INT
);
INSERT INTO Prices
    (product_id, start_date, end_date, price)
VALUES (1, '2019-02-17', '2019-02-28', 5),
    (1, '2019-03-01', '2019-03-22', 20),
    (2, '2019-02-01', '2019-02-20', 15),
    (2, '2019-02-21', '2019-03-31', 30),
    (3, '2019-02-21', '2019-03-31', 30);
SELECT *
FROM Prices;

# [SETTING]
USE practice;
DROP TABLE UnitsSold;
CREATE TABLE UnitsSold
(
    product_id    INT,
    purchase_date DATE,
    units         INT
);
INSERT INTO UnitsSold
    (product_id, purchase_date, units)
VALUES (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200),
    (2, '2019-03-22', 30);
SELECT *
FROM UnitsSold; 

# [PRACTICE - product_id=3이 나오기 위해서, LEFT OUTER JOIN 사용 필요]

# 실행 순서:
# 1. ON 조건을 기준으로 '조인'한다.
# 하지만 중복된 product_id가 있으므로, 조인하는 과정에서 행의 개수가 늘어난다.
SELECT *
FROM Prices AS p
LEFT OUTER JOIN UnitsSold AS u
ON p.product_id = u.product_id
ORDER BY p.product_id, p.start_date, u.purchase_date; 

# 2. WHERE 조건을 기준으로 '필터링' 한다.
# [BUT IT IS WRONG!] product_id=3이 WHERE 조건으로 인해서 사라진다.
# WHERE 조건에 오른쪽 테이블의 조건이 있기 때문에, INNER JOIN처럼 변해버린다.
SELECT *
FROM Prices AS p
LEFT OUTER JOIN UnitsSold AS u
ON p.product_id = u.product_id
WHERE p.start_date <= u.purchase_date
  AND u.purchase_date <= p.end_date; 
  
# [PRACTICE]
# product_id=3이 나오기 위해서, 날짜 조건을 ON에 걸어준다.
# Prices 데이터는 기본적으로 모두 나오되, ON 조건을 만족하지 않는 UnitsSold 데이터는 NULL로 나온다.
SELECT *
FROM Prices AS p
LEFT OUTER JOIN UnitsSold AS u
ON p.product_id = u.product_id
    AND p.start_date <= u.purchase_date
    AND u.purchase_date <= p.end_date; 
    
# [MYSQL]
SELECT
    p.product_id,
    IFNULL(ROUND(SUM(u.units * p.price) / SUM(u.units), 2), 0)
        AS average_price
FROM Prices AS p
LEFT OUTER JOIN UnitsSold AS u
ON p.product_id = u.product_id
    AND p.start_date <= u.purchase_date
    AND u.purchase_date <= p.end_date -- AND u.purchase_date BETWEEN p.start_date AND p.end_date 동일
GROUP BY p.product_id;