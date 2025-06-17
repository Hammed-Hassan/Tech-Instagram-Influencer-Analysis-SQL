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