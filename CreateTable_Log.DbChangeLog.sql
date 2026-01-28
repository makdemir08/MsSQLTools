CREATE TABLE dbo.[DbChangeLog](
	[DbChangeLogId] [bigint] IDENTITY(1,1) NOT NULL,
	[EventType] [varchar](50) NULL,
	[PostTime] [datetime] NULL,
	[SPID] [int] NULL,
	[ServerName] [varchar](50) NULL,
	[LoginName] [varchar](50) NULL,
	[UserName] [varchar](50) NULL,
	[DatabaseName] [varchar](50) NULL,
	[SchemaName] [varchar](10) NULL,
	[ObjectName] [varchar](150) NULL,
	[ObjectType] [varchar](50) NULL,
	[CommandText] [text] NULL,
	[AuditDateTime] [datetime] NULL,
 CONSTRAINT [PK_DbChangeLog] PRIMARY KEY CLUSTERED 
(
	[DbChangeLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
