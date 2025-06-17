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