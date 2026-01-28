USE [master]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [trgDbChangeLog]
ON ALL SERVER
FOR	
CREATE_TABLE
,CREATE_PROCEDURE
,CREATE_DATABASE
,CREATE_FUNCTION
,CREATE_INDEX
,CREATE_LINKED_SERVER
,CREATE_TRIGGER
,CREATE_USER
,CREATE_VIEW
,DROP_TABLE
,DROP_PROCEDURE
,DROP_DATABASE
,DROP_FUNCTION
,DROP_INDEX
,DROP_LINKED_SERVER
,DROP_TRIGGER
,DROP_USER
,DROP_VIEW
,ALTER_TABLE
,ALTER_PROCEDURE
,ALTER_DATABASE
,ALTER_FUNCTION
,ALTER_INDEX
,ALTER_LINKED_SERVER
,ALTER_TRIGGER
,ALTER_USER
,ALTER_VIEW

AS
BEGIN
    DECLARE @EventData XML
		,@EventType nvarchar(50)
		,@PostTime datetime
		,@SPID int
		,@ServerName nvarchar(50)
		,@LoginName nvarchar(50)
		,@UserName nvarchar(50)
		,@DatabaseName nvarchar(50)
		,@ShemaName nvarchar(10)
		,@ObjectName nvarchar(150)
		,@ObjectType nvarchar(50)
		,@CommandText nvarchar(max)
		,@AuditDateTime datetime
	

	SET @EventData = EVENTDATA()
	SET @EventType = (@EventData.value('(/EVENT_INSTANCE/EventType)[1]','nvarchar(50)'))
	SET @PostTime =(@EventData.value('(/EVENT_INSTANCE/PostTime)[1]','nvarchar(50)'))
	SET @SPID =@@SPID
	SET @ServerName =(@EventData.value('(/EVENT_INSTANCE/ServerName)[1]','nvarchar(50)'))
	SET @LoginName =(@EventData.value('(/EVENT_INSTANCE/LoginName)[1]','nvarchar(50)'))
	SET @UserName =(@EventData.value('(/EVENT_INSTANCE/UserName)[1]','nvarchar(50)'))
	SET @DatabaseName =(@EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]','nvarchar(50)'))
	SET @ShemaName =(@EventData.value('(/EVENT_INSTANCE/ShemaName)[1]','nvarchar(50)'))
	SET @ObjectName =(@EventData.value('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(50)'))
	SET @ObjectType =(@EventData.value('(/EVENT_INSTANCE/ObjectType)[1]','nvarchar(50)'))
	SET @CommandText = (@EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]','nvarchar(50)'))
	SET @AuditDateTime = GETDATE()

	INSERT INTO	[Log].[dbo].[DbChangeLog] (EventType,PostTime,SPID,ServerName,LoginName,UserName,DatabaseName,SchemaName,ObjectName,ObjectType,CommandText,AuditDateTime) 
	VALUES (@EventType,@PostTime,@SPID,@ServerName,@LoginName,@UserName,@DatabaseName,@ShemaName,@ObjectName,@ObjectType,@CommandText,@AuditDateTime)
END
GO

ENABLE TRIGGER [trgDbChangeLog] ON ALL SERVER
GO
