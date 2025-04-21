--------------------------------------------------------------------------
/* This DDL Script Drop Tables in in silver Schema if Thay Exist and Then 
Create Table for all our Data Sets */
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- This Code Drop The Table if Exist in Tha DataBase Already
IF Object_id ('silver.Batting_ODI', 'U') IS NOT NULL
  DROP TABLE silver.Batting_ODI;

GO
-- This Code Craete Table in Tha DataBase
CREATE TABLE silver.Batting_ODI
  (
     Id         INT,
     Player     VARCHAR(50),
	 Country    VARCHAR(50),
     Span       VARCHAR(50),
     Matches    INT,
     Innings    INT,
     Not_out    INT,
     Runs       INT,
     High_score INT,
     Avg_score  FLOAT,
     Bf         INT,
     Srike_rate FLOAT,
     Hundreds   INT,
     Fifties    INT,
     Duck       INT
  );

GO

IF Object_id ('silver.Batting_T20', 'U') IS NOT NULL
  DROP TABLE silver.Batting_T20;

GO

CREATE TABLE silver.Batting_T20
  (
     Id         INT,
     Player     VARCHAR(50),
	 Country    VARCHAR(50),
     Span       VARCHAR(50),
     Matches    INT,
     Innings    INT,
     Not_out    INT,
     Runs       INT,
     High_score INT,
     Avg_score  FLOAT,
     Bf         INT,
     Srike_rate FLOAT,
     Hundreds   INT,
     Fifties    INT,
     Ducks      INT,
     Fourse     INT,
     Sixes      INT,
  );

GO

IF Object_id ('silver.Batting_TEST', 'U') IS NOT NULL
  DROP TABLE silver.Batting_TEST;

GO

CREATE TABLE silver.Batting_TEST
  (
     Id         INT,
     Player     VARCHAR(50),
	 Country    VARCHAR(50),
     Span       VARCHAR(50),
     Matches    INT,
     Innings    INT,
     Not_out    INT,
     Runs       INT,
     High_score INT,
     Avg_score  FLOAT,
     Hundreds   INT,
     Fifties    INT,
     Ducks      INT
  );

GO

IF Object_id ('silver.Bowling_ODI', 'U') IS NOT NULL
  DROP TABLE silver.Bowling_ODI;

GO

CREATE TABLE silver.Bowling_ODI
  (
     Id           INT,
     Player       VARCHAR(50),
	 Country      VARCHAR(50),
     Span         VARCHAR(50),
     Matches      INT,
     Innings      INT,
     Balls        INT,
     Runs         INT,
     Wickets      INT,
     Bbi          DATE,
     Average      FLOAT,
     Economy      FLOAT,
     Strike_rate  FLOAT,
     Four_wickets INT,
     Five_wickets INT
  );

GO

IF Object_id ('silver.Bowling_T20', 'U') IS NOT NULL
  DROP TABLE silver.Bowling_T20;

go

CREATE TABLE silver.Bowling_T20
  (
     Id           INT,
     Player       VARCHAR(50),
	 Country      VARCHAR(50),
     Span         VARCHAR(50),
     Matches      INT,
     Innings      INT,
     Overs        FLOAT,
     Maidens      INT,
     Runs         INT,
     Wickets      INT,
     Bbi          VARCHAR(50),
     Average      FLOAT,
     Economy      FLOAT,
     Strike_rate  FLOAT,
     Four_wickets INT,
     Five_wickets INT
  );

GO

IF Object_id ('silver.Bowling_TEST', 'U') IS NOT NULL
  DROP TABLE silver.Bowling_TEST;

GO

CREATE TABLE silver.Bowling_TEST
  (
     Id           INT,
     Player       VARCHAR(50),
	 Country      VARCHAR(50),
     Span         VARCHAR(50),
     Matches      INT,
     Innings      INT,
     Overs        INT,
     Runs         INT,
     Wickets      INT,
     Bbi          VARCHAR(50),
     Bbm          VARCHAR(50),
     Average      FLOAT,
     Economy      FLOAT,
     Strike_rate  FLOAT,
     Four_wickets INT,
     Five_wickets INT
  );

GO