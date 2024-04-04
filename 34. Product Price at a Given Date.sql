/*  1164. Product Price at a Given Date

Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+

*/

with cte as(
select * ,
date_add("2019-08-16", interval 0 day) as date_new
from products
order by product_id
),cte2 as(
select * ,
dense_rank() over(partition by product_id order by change_date desc) as rnk
from cte
where change_date <= date_new
),cte3 as(
select * from cte2
where rnk =1
)
select product_id, new_price as price
from cte3
union
select distinct product_id,
coalesce(10,new_price) as price
from products
where product_id not in 
(select distinct product_id from cte2);

