--------------------------------------------------------------------------
/* This DDL Script Drop Tables in in Bronze Schema if Thay Exist and Then 
Create Table for all our Data Sets */
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- This Code Drop The Table if Exist in Tha DataBase Already
IF Object_id ('Bronze.Batting_ODI', 'U') IS NOT NULL
  DROP TABLE bronze.Batting_ODI;

GO
-- This Code Craete Table in Tha DataBase
CREATE TABLE bronze.Batting_ODI
  (
     Id         INT,
     Player     VARCHAR(50),
     Span       VARCHAR(50),
     Matches    INT,
     Innings    INT,
     Not_out    INT,
     Runs       INT,
     High_score varchar(50),
     Avg_score  varchar(50),
     Bf         INT,
     Srike_rate varchar(50),
     Hundreds   INT,
     Fifties    INT,
     Duck       INT
  );

GO

IF Object_id ('Bronze.Batting_T20', 'U') IS NOT NULL
  DROP TABLE bronze.Batting_T20;

GO

CREATE TABLE bronze.Batting_T20
  (
     Id         INT,
     Player     VARCHAR(50),
     Span       VARCHAR(50),
     Matches    INT,
     Innings    INT,
     Not_out    INT,
     Runs       INT,
     High_score varchar(50),
     Avg_score  varchar(50),
     Bf         INT,
     Srike_rate varchar(50),
     Hundreds   INT,
     Fifties    INT,
     Ducks      INT,
     Fourse     INT,
     Sixes      INT,
  );

GO

IF Object_id ('Bronze.Batting_TEST', 'U') IS NOT NULL
  DROP TABLE bronze.Batting_TEST;

GO

CREATE TABLE bronze.Batting_TEST
  (
     Id         INT,
     Player     VARCHAR(50),
     Span       VARCHAR(50),
     Matches    INT,
     Innings    INT,
     Not_out    INT,
     Runs       INT,
     High_score varchar(50),
     Avg_score  varchar(50),
     Hundreds   INT,
     Fifties    INT,
     Ducks      INT
  );

GO

IF Object_id ('Bronze.Bowling_ODI', 'U') IS NOT NULL
  DROP TABLE bronze.Bowling_ODI;

GO

CREATE TABLE bronze.Bowling_ODI
  (
     Id           INT,
     Player       VARCHAR(50),
     Span         VARCHAR(50),
     Matches      INT,
     Innings      INT,
     Balls        INT,
     Runs         INT,
     Wickets      INT,
     Bbi          varchar(50),
     Avg          varchar(50),
     Economy      varchar(50),
     Strike_rate  varchar(50),
     Four_wickets varchar(50),
     Five_wickets INT
  );

GO

IF Object_id ('Bronze.Bowling_T20', 'U') IS NOT NULL
  DROP TABLE bronze.Bowling_T20;

go

CREATE TABLE bronze.Bowling_T20
  (
     Id           INT,
     Player       VARCHAR(50),
     Span         VARCHAR(50),
     Matches      INT,
     Innings      INT,
     Overs        VARCHAR(50),
     Maidens      INT,
     Runs         INT,
     Wickets      INT,
     Bbi          varchar(50),
     Avg          varchar(50),
     Economy      varchar(50),
     Strike_rate  varchar(50),
     Four_wickets INT,
     Five_wickets INT
  );

GO

IF Object_id ('Bronze.Bowling_TEST', 'U') IS NOT NULL
  DROP TABLE bronze.Bowling_TEST;

GO

CREATE TABLE bronze.Bowling_TEST
  (
     Id           INT,
     Player       VARCHAR(50),
     Span         VARCHAR(50),
     Matches      INT,
     Innings      INT,
     Overs        VARCHAR(50),
     Runs         INT,
     Wickets      INT,
     Bbi          varchar(50),
     Bbm          varchar(50),
     Avg          varchar(50),
     Economy      varchar(50),
     Strike_rate  varchar(50),
     Four_wickets INT,
     Five_wickets INT
  );

GO