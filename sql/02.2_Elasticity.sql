WITH deltas AS (
    SELECT
        product_category,
        year_month,
        CAST(average_selling_price AS float) AS average_selling_price,
        CAST(total_units_sold AS float) AS total_units_sold,
        LAG(CAST(average_selling_price AS float)) OVER (
            PARTITION BY product_category
            ORDER BY year_month
        ) AS prev_avg_selling_price,
        LAG(CAST(total_units_sold AS float)) OVER (
            PARTITION BY product_category
            ORDER BY year_month
        ) AS prev_total_units_sold
    FROM mart.v_price_analysis
)

SELECT
    product_category,
    AVG(
        ((total_units_sold - prev_avg_selling_price) / NULLIF(prev_avg_selling_price,0)) /
        ((average_selling_price - prev_avg_selling_price) / NULLIF(prev_avg_selling_price,0))
    ) AS price_elasticity
FROM deltas
WHERE
    prev_total_units_sold IS NOT NULL
    AND prev_total_units_sold <> 0
    AND prev_avg_selling_price <> 0
    AND prev_avg_selling_price IS NOT NULL
GROUP BY product_category;