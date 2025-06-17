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