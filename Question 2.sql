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