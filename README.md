# Insurance Analysis - Power BI

# 
### Introduction
This project serves as a practical demonstration of SQL skills for a social media analytics use case. The objective is to analyze a dataset from a successful social media channel, identify key trends, and derive actionable insights to inform a new client's social media strategy. By answering a series of targeted business questions, this analysis provides a foundation for optimizing content, understanding audience engagement, and measuring overall account performance.


# 
### Problem Statement
The Social Media Analytics Team at AtliQ is looking to improve the social media strategy for one of their clients. They are using data from a successful channel, Netflix India's Instagram, as a case study. The goal of this project is to use a provided dataset to answer a specific set of questions and, more importantly, to go beyond them to identify key trends and formulate strategic recommendations that can be adapted for a new client.


# Methodology
### Data Sourcing

### Tools used 
- Database: SQL (MySQL)
- Visualization & Reporting: The insights derived from the SQL queries will be used to create reports and a presentation for business stakeholders using Power BI. [Power Bi Dashboard](https://app.powerbi.com/view?r=eyJrIjoiNjEyMmUzMDgtNTUzMi00ZjkzLTg1ODEtZGFjY2VkYTMyNGNiIiwidCI6ImM2ZTU0OWIzLTVmNDUtNDAzMi1hYWU5LWQ0MjQ0ZGM1YjJjNCJ9)

### Analysis
The project involves writing efficient and readable SQL queries to answer a series of business questions. The analysis is divided into three key areas: content performance, account statistics, and audience engagement.

***Project Questions & SQL Solutions***
1. How many unique post types are found in the fact_content table?

```sql queries
select count( distinct post_type) from fact_content; 
```

2. What are the highest and lowest recorded impressions for each post type?

```sql queries
SELECT
    fc.post_type,
    MAX(fa.profile_visits) AS Max_Profile_Visits,
    MIN(fa.profile_visits) AS Min_Profile_Visits
FROM
    fact_content AS fc
JOIN
    fact_account AS fa
ON
    fc.date = fa.date
GROUP BY
    fc.post_type; 
```

3. Filter all the posts that were published on a weekend in the months of March and April and export them to a separate CSV file

```sql queries
select * from dim_dates
where weekday_or_weekend = "Weekend" and (month_name = "March" or month_name = "April"); 
```

4. Create a report to get the statistics for the account. The final output includes the following fields:

```sql queries
select month_name, sum(profile_visits) as Total_Profile_Visits, sum(new_followers) as Total_New_followers from dim_dates as dd
join fact_account as fa
on dd.date = fa.date
group by month_name; 
```
5. Write a CTE that calculates the total number of 'likes' for each 'post_category' during the month of 'July' and subsequently, arrange the 'post_category' values in descending order according to their total likes.

```sql queries
with Here as 
(
select post_category, sum(likes) as likes from fact_content as fc
join dim_dates as dd
on fc.date = dd.date
where month_name = "July"
group by post_category
)

select * from here
order by likes desc; 
```

6. Create a report that displays the unique post_category names alongside their respective counts for each month. The output should have three columns: month_name, post_category_names, post_category_count.

```sql queries
SELECT
    dd.month_name,
    GROUP_CONCAT(DISTINCT fc.post_category ORDER BY fc.post_category ASC SEPARATOR ' | ') AS post_category_names,
    COUNT(DISTINCT fc.post_category) AS post_category_count
FROM
    dim_dates AS dd
JOIN
    fact_content AS fc
ON
    dd.date = fc.date
GROUP BY
    dd.month_name; 
```

7. What is the percentage breakdown of total reach by post type? The final output includes the following fields: post_type, total_reach, reach_percentage.

```sql queries
WITH Here AS (
    SELECT
        post_type,
        SUM(reach) AS Total_Reach
    FROM
        fact_content
    GROUP BY
        post_type
)
SELECT
    post_type,
    Total_Reach,
    Total_Reach*100 / SUM(Total_Reach) OVER () AS Percentage_of_Total_Reach
FROM
    Here; 
```

8. Create a report that includes the quarter, total comments, and total saves recorded for each post category. Assign the following quarter groupings:
(January, February, March) → “Q1”
(April, May, June) → “Q2”
(July, August, September) → “Q3”
The final output columns should consist of: post_category, quarter, total_comments, total_saves.

```sql queries
SELECT
    post_category,
    CASE
        WHEN month_name = 'January' and month_name = 'February' and month_name = 'March' THEN 'Q1'
        WHEN month_name = 'April' and month_name = 'May' and month_name = 'June' THEN 'Q2'
        WHEN month_name = 'July' and month_name = 'August' and month_name = 'September' THEN 'Q3'
        ELSE 'Q4' 
    END AS Quarter, 
    sum(comments) as Total_Comments,
    sum(saves) as Total_Saves
FROM dim_dates dd
join fact_content fc
on dd.date = fc.date
group by post_category, Quarter; 
```

9. List the top three dates in each month with the highest number of new followers. The final output should include the following columns: month, date, new_followers.

```sql queries
with here as (
select 
month_name, dd.date, sum(new_followers) as New_Followers
from dim_dates dd
join fact_account fa
on dd.date = fa.date
group by month_name, dd.date
),

here1 as (
select 
month_name, date, New_Followers,
row_number() over(partition by month_name order by New_Followers desc) as RN
from here
)

select month_name, date, New_Followers
from here1
where RN <= 3
; 
```
