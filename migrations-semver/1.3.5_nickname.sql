-- For SQL Server 2016 and later (more concise)
BEGIN TRY
    EXEC sp_executesql N'
    IF NOT EXISTS (SELECT * FROM sys.columns 
                  WHERE name = ''nickname'' 
                  AND object_id = OBJECT_ID(''dbo.users''))
    ALTER TABLE [dbo].[users] 
    ADD nickname NVARCHAR(255) NOT NULL 
    CONSTRAINT DF_users_nickname DEFAULT '''' WITH VALUES;';
    PRINT 'Column [nickname] processed successfully.';
END TRY
BEGIN CATCH
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH
GO