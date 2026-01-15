USE AdventureWorksDW2025;
GO

--CONFIRMATION FOR DIM AND FACT VIEWS
SELECT 'v_dim_date' AS table_name, COUNT(*) AS dim_date_count FROM mart.v_dim_date
UNION ALL
SELECT 'v_dim_product' AS table_name, COUNT(*) AS dim_product_count FROM mart.v_dim_product
UNION ALL
SELECT 'v_fact_sales' AS table_name, COUNT(*) AS fact_sales_count FROM mart.v_fact_sales;

GO

-- CONFIRMATION FOR v_sales_analytics VIEW
SELECT COUNT(*) AS row_count_sales_analytics
FROM mart.v_sales_analytics;
--CONFIRMATION FOR v_sales_kpis VIEW
SELECT COUNT(*) AS row_count_sales_kpis
FROM mart.v_sales_kpis;

-- CONFIRMATION FOR v_price_analysis VIEW
SELECT *
FROM mart.v_price_analysis
WHERE average_selling_price IS NULL;
GO  

SELECT COUNT (*) AS total_price_analysis_rows
FROM mart.v_price_analysis;
GO

--CONFIRMATION FOR ELASTICITY CALCULATION
SELECT *
FROM mart.v_price_elasticity
SELECT *
FROM mart.v_price_elasticity
WHERE price_elasticity IS NULL;