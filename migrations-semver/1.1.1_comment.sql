-- SQL Server doesn't support IF EXISTS/IF NOT EXISTS directly in ALTER TABLE, so we use this pattern
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'users' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    IF NOT EXISTS (SELECT * FROM sys.columns 
                  WHERE name = 'comment' 
                  AND object_id = OBJECT_ID('dbo.users'))
    BEGIN
        -- Add column with default constraint
        ALTER TABLE [dbo].[users] 
        ADD comment NVARCHAR(255) NOT NULL 
        CONSTRAINT DF_users_comment DEFAULT '' WITH VALUES;
        
        PRINT 'Column [comment] added to [dbo].[users] with default empty string.';
    END
    ELSE
    BEGIN
        PRINT 'Column [comment] already exists in [dbo].[users].';
    END
END
ELSE
BEGIN
    PRINT 'Table [dbo].[users] does not exist.';
END
GO