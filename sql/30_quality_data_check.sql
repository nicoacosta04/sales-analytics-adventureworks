USE AdventureWorksDW2025;
GO

SELECT COUNT (*) AS missing_dates
FROM mart.v_fact_sales f
LEFT JOIN mart.v_dim_date d
    ON f.order_date_key = d.date_key
WHERE d.date_key IS NULL;

SELECT COUNT (*) AS missing_products
FROM mart.v_fact_sales f
LEFT JOIN mart.v_dim_product p
    ON f.product_key = p.product_key
WHERE p.product_key IS NULL;

SELECT
    sales_order_number,
    sales_order_line_number,
    COUNT (*) AS duplicate_count
FROM mart.v_fact_sales
GROUP BY sales_order_number, sales_order_line_number
HAVING COUNT (*) > 1;

SELECT *
FROM mart.v_fact_sales
WHERE order_quantity < 0 
    OR revenue < 0 
    OR total_product_cost_COGS < 0 
    OR gross_margin_profit < 0 ;