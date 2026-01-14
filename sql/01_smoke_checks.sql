USE AdventureWorksDW2025;
GO

SELECT DB_NAME() AS DatabaseName, 
COUNT(*) AS TotalTables
GO


SELECT 
    s.name AS schema_name, t.name AS table_name,
    SUM(p.rows) AS row_count
FROM sys.tables t
JOIN sys.schemas s 
    ON t.schema_id = s.schema_id
JOIN sys.partitions p 
    ON t.object_id = p.object_id
WHERE s.name = 'dbo'
AND p.index_id IN (0,1)
GROUP BY s.name,t.name
ORDER BY t.name DESC;
GO
