USE AdventureWorksDW2025;
GO

CREATE OR ALTER VIEW mart.v_dim_date AS
SELECT
    DateKey AS date_key,
    FullDateAlternateKey AS full_date,
    CalendarYear AS calendar_year,
    CalendarQuarter AS calendar_quarter,
    MonthNumberOfYear AS month_number,
    EnglishMonthName AS month_name,
    CONVERT(CHAR(7), FullDateAlternateKey, 120) AS year_month
FROM dbo.DimDate
WHERE FullDateAlternateKey IS NOT NULL;
GO

CREATE OR ALTER VIEW mart.v_dim_product AS
SELECT
    p.ProductKey AS product_key,
    p.EnglishProductName AS product_name,
    p.ProductLine AS product_line,
    p.Color AS product_color,
    p.StandardCost AS standard_cost,
    p.Size AS product_size,
    p.ModelName AS model_name,
    p.ListPrice AS list_price,
    sc.EnglishProductSubcategoryName AS product_subcategory,
    c.EnglishProductCategoryName AS product_category
FROM dbo.DimProduct AS p
LEFT JOIN dbo.DimProductSubcategory AS sc
    ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
LEFT JOIN dbo.DimProductCategory AS c
    ON sc.ProductCategoryKey = c.ProductCategoryKey;
GO

CREATE OR ALTER VIEW mart.v_fact_sales AS
SELECT
    fis.SalesOrderNumber AS sales_order_number,
    fis.SalesOrderLineNumber AS sales_order_line_number,
    fis.OrderDateKey AS order_date_key,
    fis.DueDateKey AS due_date_key,
    fis.ShipDateKey AS ship_date_key,
    fis.CustomerKey AS customer_key,
    fis.ProductKey AS product_key,
    fis.PromotionKey AS promotion_key,
    fis.SalesTerritoryKey AS sales_territory_key,
    fis.OrderQuantity AS order_quantity,
    fis.UnitPrice AS unit_price,
    fis.ExtendedAmount AS extended_amount,
    fis.DiscountAmount AS discount_amount,
    fis.SalesAmount AS revenue,
    fis.TotalProductCost AS total_product_cost_COGS,
    (fis.SalesAmount - fis.TotalProductCost) AS gross_margin_profit
FROM dbo.FactInternetSales AS fis
GO

CREATE OR ALTER VIEW mart.v_sales_analytics AS
SELECT
    d.calendar_year,
    d.year_month,
    p.product_category,
    p.product_subcategory,
    f.sales_order_number,
    f.sales_order_line_number,
    f.order_quantity,
    f.revenue,
    f.total_product_cost_COGS,
    f.gross_margin_profit
FROM mart.v_fact_sales f
JOIN mart.v_dim_date d
    ON f.order_date_key = d.date_key
JOIN mart.v_dim_product p
    ON f.product_key = p.product_key;
GO

CREATE OR ALTER VIEW mart.v_sales_kpis AS
SELECT
    d.calendar_year,
    d.year_month,
    p.product_category,
    p.product_subcategory,
    SUM(f.order_quantity) AS total_units_sold,
    SUM(f.revenue) AS total_revenue,
    SUM(f.total_product_cost_COGS) AS total_COGS,
    SUM(f.gross_margin_profit) AS total_gross_profit,
    ROUND(
        SUM(f.gross_margin_profit) / NULLIF(SUM(f.revenue), 0),
        4
    ) AS gross_margin_percentage
FROM mart.v_fact_sales f
JOIN mart.v_dim_date d
    ON f.order_date_key = d.date_key
JOIN mart.v_dim_product p
    ON f.product_key = p.product_key
GROUP BY
    d.calendar_year,
    d.year_month,
    p.product_category,
    p.product_subcategory;
GO