-- Simple version with basic checks
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'users' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    BEGIN TRY
        -- Enable identity insert if needed
        SET IDENTITY_INSERT [dbo].[users] ON;
        
        INSERT INTO [dbo].[users] (id, name, email)
        VALUES (1, 'me', 'me@me.com');
        
        SET IDENTITY_INSERT [dbo].[users] OFF;
        PRINT 'User record inserted successfully.';
    END TRY
    BEGIN CATCH
        SET IDENTITY_INSERT [dbo].[users] OFF;
        PRINT 'Error inserting user: ' + ERROR_MESSAGE();
    END CATCH
END
ELSE
BEGIN
    PRINT 'Table [dbo].[users] does not exist.';
END
GO