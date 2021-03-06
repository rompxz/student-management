USE [auth_sp]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListData]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListData](
	[ListDataTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_ListData] PRIMARY KEY CLUSTERED 
(
	[ListDataTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListFund]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListFund](
	[ListDataId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[ListDataTypeId] [int] NULL,
 CONSTRAINT [PK_ListFund] PRIMARY KEY CLUSTERED 
(
	[ListDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locality]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locality](
	[LocalityId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[CityId] [int] NULL,
 CONSTRAINT [PK_Locality] PRIMARY KEY CLUSTERED 
(
	[LocalityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[InterestC#] [bit] NOT NULL,
	[InterestVB] [bit] NOT NULL,
	[InterestJava] [bit] NOT NULL,
	[GenderID] [int] NULL,
	[DOB] [datetime] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[FundTypeId] [int] NULL,
	[FeesPaymentId] [int] NULL,
	[Comments] [nvarchar](max) NULL,
	[Address] [nvarchar](1500) NULL,
	[LocalityId] [int] NULL,
	[CityId] [int] NULL,
	[PostCode] [nvarchar](50) NULL,
	[Photo] [image] NULL,
	[OriginalRowVersion] [timestamp] NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllCities]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetAllCities]

AS

BEGIN
	SELECT 
		[CityId],
		[Description]
	FROM
		[dbo].[Cities]
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllListData]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATe PROCEDURE [dbo].[usp_GetAllListData]
(
	@ListDataTypeId INT
)
AS

	BEGIN
		SELECT
			[ListDataId],
			[Description]
		FROM 
			[dbo].[ListFund]
		WHERE
			[ListDataTypeId] = @ListDataTypeId
	END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllLocalitiesByCityId]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetAllLocalitiesByCityId]
(
	@CityId INT
)
AS

BEGIN
	SELECT
		[LocalityId],
		[Description]
	FROM
		[dbo].[Locality]
	WHERE
		[CityId] = @CityId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCurrentRowVersion]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetCurrentRowVersion]
(
	@ID INT
)
AS

	BEGIN
		SELECT
			[OriginalRowVersion]
		FROM
			[dbo].[Students]
		WHERE
			[ID] = @ID

	END
GO
/****** Object:  StoredProcedure [dbo].[usp_StudentGellAllStudents]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_StudentGellAllStudents]

AS

	BEGIN
		SELECT
			st.[ID],
			st.[Name],
			st.[Email],
			CASE
				st.[GenderID]
				WHEN 1 THEN 'Male'
				WHEN 2 THEN 'Female'
			END AS 'Gender',
			CONVERT(varchar, st.[DOB], 103) AS 'Date of Birth',
			ISNULL(st.[Address], '') + ' ' +
			ISNULL(l.[Description], '') + ' ' + 
			ISNULL(c.[Description], '') + ' ' + 
			ISNULL(st.[PostCode], '') AS 'Address'
		FROM
			[dbo].[Students] st
		LEFT JOIN [dbo].[Locality] l ON st.[LocalityId] = l.[LocalityId]
		LEFT JOIN [dbo].[Cities] c ON st.[CityId] = c.[CityId]

	END
GO
/****** Object:  StoredProcedure [dbo].[usp_StudentGetStudentInfoById]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_StudentGetStudentInfoById]
(
	@ID INT /** StudentId **/
)

AS

	BEGIN
		SELECT 
			[ID]
			,[Name]
			,[Email]
			,[InterestC#]
			,[InterestVB]
			,[InterestJava]
			,[GenderID]
			,[DOB]
			,[StartTime]
			,[EndTime]
			,[FundTypeId]
			,[FeesPaymentId]
			,[Comments]
			,[Address]
			,[LocalityId]
			,[CityId]
			,[PostCode]
			,[Photo]
			,[OriginalRowVersion]
		FROM 
			[dbo].[Students]

		WHERE
			[ID] = @ID /** StudentId **/

	END
GO
/****** Object:  StoredProcedure [dbo].[usp_StudentsInsertDetails]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_StudentsInsertDetails]
(
	@Name NVARCHAR(50),
	@Email NVARCHAR(50),
	@InterestC# BIT,
    @InterestVB BIT,
    @InterestJava BIT,
	@GenderID INT,
	@DOB DATETIME = NULL,
	@StartTime DATETIME = NULL,
	@EndTime DATETIME = NULL,
	@FundTypeId INT,
	@FeesPaymentId INT,
	@Comments NVARCHAR(MAX),
	@Address NVARCHAR(1500),
	@LocalityId INT,
	@CityId INT,
	@PostCode NVARCHAR(50),
	@Photo IMAGE
)

AS

	BEGIN
		INSERT INTO [dbo].[Students]
		 (
			[Name],
			[Email],
			[InterestC#],
			[InterestVB],
			[InterestJava],
			[GenderID],
			[DOB],
			[StartTime],
			[EndTime],
			[FundTypeId],
			[FeesPaymentId],
			[Comments],
			[Address],
			[LocalityId],
			[CityId],
			[PostCode],
			[Photo]

		  )
		VALUES
		 (
			@Name,
			@Email,
			@InterestC#,
			@InterestVB,
			@InterestJava,
			@GenderID,
			@DOB,
			@StartTime,
			@EndTime,
			@FundTypeId,
			@FeesPaymentId,
			@Comments,
			@Address,
			@LocalityId,
			@CityId,
			@PostCode,
			@Photo
		  )
	END
GO
/****** Object:  StoredProcedure [dbo].[usp_StudentUpdateDetails]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_StudentUpdateDetails]
(
	@ID				INT, /** StudentId**/
	@Name			NVARCHAR(50),
	@Email			NVARCHAR(50),
	@InterestC#		BIT,
    @InterestVB		BIT,
    @InterestJava	BIT,
	@GenderID		INT,
	@DOB			DATETIME = NULL,
	@StartTime		DATETIME = NULL,
	@EndTime		DATETIME = NULL,
	@FundTypeId			INT,
	@FeesPaymentId	INT,
	@Comments		NVARCHAR(MAX),
	@Address		NVARCHAR(1500),
	@LocalityId			INT,
	@CityId			INT,
	@PostCode		NVARCHAR(50),
	@Photo			IMAGE
)

AS

	BEGIN
		
		UPDATE 
			[dbo].[Students]
		SET 
			[Name]			= @Name
			,[Email]		= @Email
			,[InterestC#]	= @InterestC#
			,[InterestVB]	= @InterestVB
			,[InterestJava] = @InterestJava
			,[GenderID]		= @GenderID
			,[DOB]			= @DOB
			,[StartTime]	= @StartTime
			,[EndTime]		= @EndTime
			,[FundTypeId]	= @FundTypeId
			,[FeesPaymentId] = @FeesPaymentId
			,[Comments]		= @Comments
			,[Address]		= @Address
			,[LocalityId]	= @LocalityId
			,[CityId]		= @CityId
			,[PostCode]		= @PostCode
			,[Photo]		= @Photo
		 WHERE
			[ID] = @ID

	END
GO
/****** Object:  StoredProcedure [dbo].[usp_UserCheckLoginDetails]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UserCheckLoginDetails]
(
	@IsUsernameCorrect BIT OUTPUT,
	@IsPasswordCorrect BIT OUTPUT,
	@IsActive BIT OUTPUT,
	@Username NVARCHAR(50),
	@Password NVARCHAR(50)
)
AS 

	BEGIN
		SET @IsUsernameCorrect = 0
		SET @IsPasswordCorrect = 0
		SET @IsActive = 0
	/** SELECT USERNAME AND PASSWORD AND CHECK IF ACTIVE OR NOT**/
		IF EXISTS(SELECT 
						*
					FROM
						
						[dbo].[Users]
					WHERE
						[Username] = @Username AND
						[Password] = @Password AND
						[IsActive] = 1)
			BEGIN
				SET @IsUsernameCorrect = 1
				SET @IsPasswordCorrect = 1
				SET @IsActive = 1
			END

	/** SELECT USERNAME AND PASSWORD **/
	ELSE
			IF EXISTS(SELECT
							*
						FROM
							[dbo].[Users]
						WHERE
							[Username] = @Username AND
							[Password] = @Password)
				BEGIN
					SET @IsUsernameCorrect = 1
					SET @IsPasswordCorrect = 1
				END
			ELSE
				BEGIN
					IF EXISTS(SELECT
									*
								FROM
									[dbo].[Users]
								WHERE
									[Username] = @Username)
					BEGIN
						SET @IsUsernameCorrect = 1
					END
				END
	END
GO
/****** Object:  StoredProcedure [dbo].[usp_UserDisableThisAccount]    Script Date: 4/26/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UserDisableThisAccount]
(
	@Username NVARCHAR(50)
)
AS

	BEGIN
		UPDATE
			[dbo].[Users]
		SET
			[IsActive] = 0
		WHERE 
			[Username] = @Username
	END
GO
