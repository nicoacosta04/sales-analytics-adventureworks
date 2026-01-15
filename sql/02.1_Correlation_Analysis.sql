SELECT
    product_category,
    (
        COUNT(*) * SUM(CAST(average_selling_price AS float) * CAST(total_units_sold AS float))
        - SUM(CAST(average_selling_price AS float)) * SUM(CAST(total_units_sold AS float))
    )
    /
    SQRT(
        (COUNT(*) * SUM(POWER(CAST(average_selling_price AS float), 2))
            - POWER(SUM(CAST(average_selling_price AS float)), 2))
        *
        (COUNT(*) * SUM(POWER(CAST(total_units_sold AS float), 2))
            - POWER(SUM(CAST(total_units_sold AS float)), 2))
    ) AS price_units_corr
FROM mart.v_price_analysis
GROUP BY product_category;
GO
