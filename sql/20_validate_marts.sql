USE AdventureWorksDW2025;
GO
SELECT 'v_dim_date' AS table_name, COUNT(*) AS dim_date_count FROM mart.v_dim_date
UNION ALL
SELECT 'v_dim_product' AS table_name, COUNT(*) AS dim_product_count FROM mart.v_dim_product
UNION ALL
SELECT 'v_fact_sales' AS table_name, COUNT(*) AS fact_sales_count FROM mart.v_fact_sales;

GO

SELECT COUNT(*) AS row_count_sales_analytics
FROM mart.v_sales_analytics;

SELECT COUNT(*) AS row_count_sales_kpis
FROM mart.v_sales_kpis;