/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      Wildfire_Logical.DM1
 *
 * Date Created : Tuesday, November 10, 2020 21:49:52
 * Target DBMS : Microsoft Azure SQL DB
 */

CREATE DATABASE WildfireData
go
/* 
 * TABLE: Date_Dimension 
 */

CREATE TABLE Date_Dimension(
    Date_ID           bigint      NOT NULL,
    Fire_Year         int         NULL,
    Discovery_Date    date        NULL,
    Discovery_DOY     int         NULL,
    Discovery_Time    int		  NULL,
    Cont_Date         date        NULL,
    Cont_DOY          int         NULL,
    Cont_Time         int		  NULL,
    CONSTRAINT PK_DateID PRIMARY KEY NONCLUSTERED (Date_ID)
)
go



IF OBJECT_ID('Date_Dimension') IS NOT NULL
    PRINT '<<< CREATED TABLE Date_Dimension >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Date_Dimension >>>'
go

/* 
 * TABLE: Fire 
 */

CREATE TABLE Fire(
    Fire_ID					   int			   NOT NULL,
	Fire_Code                  varchar(50)     NULL,
    Fire_Name                  varchar(255)    NULL,
    ICS_209_Incident_Number    varchar(255)    NULL,
    ICS_209_Name               varchar(255)    NULL,
    MTBS_ID                    varchar(255)    NULL,
    MTBS_Fire_Name             varchar(50)     NULL,
    CONSTRAINT PK_Fire PRIMARY KEY NONCLUSTERED (Fire_ID)
)
go



IF OBJECT_ID('Fire') IS NOT NULL
    PRINT '<<< CREATED TABLE Fire >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Fire >>>'
go

/* 
 * TABLE: Fire_Causes 
 */

CREATE TABLE Fire_Causes(
    Cause_Code           int            NOT NULL,
    Cause_Description    varchar(50)    NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (Cause_Code)
)
go



IF OBJECT_ID('Fire_Causes') IS NOT NULL
    PRINT '<<< CREATED TABLE Fire_Causes >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Fire_Causes >>>'
go

/* 
 * TABLE: Fire_Size 
 */

CREATE TABLE Fire_Size(
    Fire_Size_Class    varchar(10)    NOT NULL,
    Fire_Size          float          NOT NULL,
    CONSTRAINT PK_Fire_Size PRIMARY KEY NONCLUSTERED (Fire_Size,Fire_Size_Class)
)
go



IF OBJECT_ID('Fire_Size') IS NOT NULL
    PRINT '<<< CREATED TABLE Fire_Size >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Fire_Size >>>'
go

/* 
 * TABLE: [Geography Dimension] 
 */

CREATE TABLE [Geography_Dimension](
    Geography_ID    int             NOT NULL,
    Latitude        float           NULL,
    Longitude       float           NULL,
    State           varchar(10)     NULL,
    Zipcode         varchar(10)     NULL,
    Area_Name       varchar(100)    NULL,
    CONSTRAINT PK5 PRIMARY KEY NONCLUSTERED (Geography_ID)
)
go



IF OBJECT_ID('Geography Dimension') IS NOT NULL
    PRINT '<<< CREATED TABLE Geography Dimension >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Geography Dimension >>>'
go

/* 
 * TABLE: Land_Owners 
 */

CREATE TABLE Land_Owners(
    Owner_Code           int            NOT NULL,
    Owner_Description    varchar(10)    NULL,
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (Owner_Code)
)
go



IF OBJECT_ID('Land_Owners') IS NOT NULL
    PRINT '<<< CREATED TABLE Land_Owners >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Land_Owners >>>'
go

/* 
 * TABLE: NWCG_Data 
 */

CREATE TABLE NWCG_Data(
    Unit_ID            varchar(20)     NOT NULL,
    Name               varchar(100)    NULL,
    Gacc               varchar(20)     NULL,
    Wildland_Role      varchar(100)    NULL,
    Unit_Type          varchar(50)     NULL,
    Department         varchar(10)     NULL,
    Agency             varchar(10)     NULL,
    State              varchar(3)      NULL,
    Country            varchar(3)      NULL,
    Geographic_Area    varchar(3)      NULL,
    Code               varchar(10)     NULL,
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (Unit_ID)
)
go



IF OBJECT_ID('NWCG_Data') IS NOT NULL
    PRINT '<<< CREATED TABLE NWCG_Data >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE NWCG_Data >>>'
go

/* 
 * TABLE: Wildfire_Data 
 */

CREATE TABLE Wildfire_Data(
    Object_ID                int            NOT NULL,
    Unit_ID                  varchar(20)    NOT NULL,
    Cause_Code               int            NOT NULL,
    Owner_Code               int            NOT NULL,
    Date_ID                  int            NOT NULL,
    Geography_ID             int            NOT NULL,
    Fire_ID					 int			NOT NULL,
    Fire_Size_Class          varchar(10)    NOT NULL,
    Source_Reporting_Unit    varchar(30)    NULL,
    Source_Reporting_Name    varchar(255)    NULL,
    CONSTRAINT PK_Wildfire_Data PRIMARY KEY NONCLUSTERED (Object_ID)
)
go



IF OBJECT_ID('Wildfire_Data') IS NOT NULL
    PRINT '<<< CREATED TABLE Wildfire_Data >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Wildfire_Data >>>'
go

/* 
 * TABLE: Wildfire_Data 
 */

ALTER TABLE Wildfire_Data ADD CONSTRAINT RefNWCG_Data2 
    FOREIGN KEY (Unit_ID)
    REFERENCES NWCG_Data(Unit_ID)
go

ALTER TABLE Wildfire_Data ADD CONSTRAINT RefFire_Causes3 
    FOREIGN KEY (Cause_Code)
    REFERENCES Fire_Causes(Cause_Code)
go

ALTER TABLE Wildfire_Data ADD CONSTRAINT RefLand_Owners4 
    FOREIGN KEY (Owner_Code)
    REFERENCES Land_Owners(Owner_Code)
go

ALTER TABLE Wildfire_Data ADD CONSTRAINT FK_DateID 
    FOREIGN KEY (Date_ID)
    REFERENCES Date_Dimension(Date_ID)
go

ALTER TABLE Wildfire_Data ADD CONSTRAINT RefGeography_Dimension6 
    FOREIGN KEY (Geography_ID)
    REFERENCES [Geography Dimension](Geography_ID)
go

ALTER TABLE Wildfire_Data ADD CONSTRAINT RefFire8 
    FOREIGN KEY (Fire_ID)
    REFERENCES Fire(Fire_ID)
go

ALTER TABLE Wildfire_Data ADD CONSTRAINT RefFire_Size
    FOREIGN KEY (Fire_Size,Fire_Size_Class)
    REFERENCES Fire_Size(Fire_Size,Fire_Size_Class)
go


