-- SQL Server doesn't support CREATE TABLE IF NOT EXISTS directly, so we use this pattern
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'users' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    CREATE TABLE [dbo].[users] (
        -- In SQL Server, use IDENTITY instead of SERIAL
        id INT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(255) NOT NULL,  -- NVARCHAR is preferred in SQL Server for Unicode support
        email NVARCHAR(255) NOT NULL UNIQUE,
        
        -- Optional: Add common audit columns
        created_at DATETIME2 DEFAULT SYSDATETIME(),
        updated_at DATETIME2 NULL
    );
    
    PRINT 'Table [dbo].[users] created successfully.';
END
ELSE
BEGIN
    PRINT 'Table [dbo].[users] already exists.';
END
GO