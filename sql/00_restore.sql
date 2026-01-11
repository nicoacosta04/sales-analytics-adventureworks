USE master;
GO

RESTORE FILELISTONLY
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\Backup\AdventureWorksDW2025.bak';
GO

SELECT 
    SERVERPROPERTY('InstanceDefaultDataPath') AS DefaultDataPath,
    SERVERPROPERTY('InstanceDefaultLogPath') AS DefaultLogPath;

RESTORE DATABASE AdventureWorksDW2025
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\Backup\AdventureWorksDW2025.bak'
WITH
    MOVE N'AdventureWorksDW'     TO N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\AdventureWorksDW2025.mdf',
    MOVE N'AdventureWorksDW_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\AdventureWorksDW2025_log.ldf',
    REPLACE,
    RECOVERY,
    STATS = 5;
GO