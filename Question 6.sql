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