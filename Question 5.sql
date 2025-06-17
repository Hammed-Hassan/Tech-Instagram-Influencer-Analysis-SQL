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