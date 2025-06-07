BEGIN TRY
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'users' AND schema_id = SCHEMA_ID('dbo'))
    BEGIN
        -- Check if record with ID=1 already exists
        IF EXISTS (SELECT 1 FROM [dbo].[users] WHERE id = 1)
        BEGIN
            -- Update existing record
            UPDATE [dbo].[users] 
            SET 
                name = ISNULL(name, 'default_name'),
                email = ISNULL(email, 'default@email.com'),
                phone = ISNULL(phone, ''),
                nickname = ISNULL(nickname, ''),
                comment = ISNULL(comment, '')
            WHERE id = 1;
            
            PRINT 'Updated existing record with ID=1.';
        END
        ELSE
        BEGIN
            -- Insert new record if ID doesn't exist
            DECLARE @is_identity BIT = 0;
            SELECT @is_identity = is_identity 
            FROM sys.columns 
            WHERE object_id = OBJECT_ID('dbo.users') 
            AND name = 'id';
            
            IF @is_identity = 1
                SET IDENTITY_INSERT [dbo].[users] ON;
            
            INSERT INTO [dbo].[users] (id, name, email, phone, nickname, comment)
            VALUES (1, 'default_name', 'default@email.com', '', '', '');
            
            IF @is_identity = 1
                SET IDENTITY_INSERT [dbo].[users] OFF;
            
            PRINT 'Inserted new record with ID=1.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Table [dbo].[users] does not exist.';
    END
END TRY
BEGIN CATCH
    IF (SELECT OBJECTPROPERTY(OBJECT_ID('dbo.users'), 'TableHasIdentity')) = 1
        SET IDENTITY_INSERT [dbo].[users] OFF;
    
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH
GO