select month_name, sum(profile_visits) as Total_Profile_Visits, sum(new_followers) as Total_New_followers from dim_dates as dd
join fact_account as fa
on dd.date = fa.date
group by month_name;