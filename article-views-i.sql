/*
https://leetcode.com/problems/article-views-i/ 

Table: Views
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.
이 테이블에는 기본 키가 없습니다. 중복된 행이 있을 수 있습니다.
이 표의 각 행은 일부 독자가 특정 날짜에 기사(특정 작가가 쓴)를 봤음을 나타냅니다.
동일한 author_id와 viewer_id는 동일한 사람을 나타냅니다.


Write an SQL query to find all the authors that viewed at least one of their own articles.
Return the result table sorted by id in ascending order.
자신의 기사를 최소 한 번 이상 본 작가를 찾는 SQL 쿼리를 작성하세요.
id를 기준으로 오름차순으로 정렬된 결과 테이블을 반환합니다.


Example:
Input: 
Views table:
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 6         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |
| 3          | 4         | 4         | 2019-07-21 |
| 3          | 4         | 4         | 2019-07-21 |
+------------+-----------+-----------+------------+
Output: 
+------+
| id   |
+------+
| 4    |
| 7    |
+------+
*/

# [SETTING]
USE practice;
DROP TABLE Views;
CREATE TABLE Views (
  article_id INT,
  author_id INT,
  viewer_id INT,
  view_date DATE
);
INSERT INTO
  Views (article_id, author_id, viewer_id, view_date)
VALUES
  (1, 3, 5, '2019-08-01'),
  (1, 3, 6, '2019-08-02'),
  (2, 7, 7, '2019-08-01'),
  (2, 7, 6, '2019-08-02'),
  (4, 7, 1, '2019-07-22'),
  (3, 4, 4, '2019-07-21'),
  (3, 4, 4, '2019-07-21');
SELECT *
FROM Views;

# [KEY]
# 'There is no primary key for this table, it may have duplicate rows.' : DISTINCT 처리 필요
# Primary Key(=PK): 중복되어 나타날 수 없는 단일 값(unique) (e.g. 우리나라 국민의 주민등록번호)

# 쿼리 실행 순서: FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT

# [WRONG]
SELECT
  author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;

# [MYSQL] 
# DISTINCT 필요
SELECT
  DISTINCT (author_id) AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;