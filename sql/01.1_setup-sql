USE AdventureWorksDW2025;
GO
IF NOT EXISTS (SELECT (1) FROM sys.schemas WHERE name = 'mart')
BEGIN
    EXEC('CREATE SCHEMA mart;');
END
GO