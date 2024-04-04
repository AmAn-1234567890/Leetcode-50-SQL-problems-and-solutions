/* 1907. Count Salary Categories

Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Accounts table:
+------------+--------+
| account_id | income |
+------------+--------+
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |
+------------+--------+
Output: 
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |
+----------------+----------------+
Explanation: 
Low Salary: Account 2.
Average Salary: No accounts.
High Salary: Accounts 3, 6, and 8.


*/

with cte as (
select *,
case
When income < 20000 then "Low Salary"
When income between 20000 and 50000 then "Average Salary"
When income > 50000 then "High Salary" end as category
from accounts
)
select categories.category, coalesce(cte.accounts_count, 0) as accounts_count
from (
    select 'Low Salary' as category
    union all
    select 'Average Salary'
    union all
    select 'High Salary'
) as categories
left join (
    select category, count(*) as accounts_count
    from cte
    group by category
) as cte on categories.category = cte.category;