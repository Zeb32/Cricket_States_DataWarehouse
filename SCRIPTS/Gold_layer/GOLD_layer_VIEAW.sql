----------------------------------------------------------
/* This Script for Gold Layer Create Views to Joine Tables
which will represent important States */ 
----------------------------------------------------------
----------------------------------------------------------
 -- Drop View if Exist
IF Object_id ('Gold.Batting_States', 'V') IS NOT NULL
DROP VIEW Gold.Batting_States;

GO

-- Create View

CREATE VIEW Gold.Batting_States AS
SELECT O.Player AS Player_Name,
	   O.Country,
       COALESCE(O.Matches, 0)+COALESCE(t.Matches, 0)+ COALESCE(s.Matches, 0) AS Matches,
       COALESCE(O.runs, 0)+COALESCE(t.runs, 0)+ COALESCE(s.runs, 0) AS Runs,
       O.High_score AS ODI_HS,
       T.High_score AS T20_HS,
       S.High_score AS TEST_HS,
       O.Avg_score AS Avg_ODI,
       T.Avg_score AS Avg_T20,
       S.Avg_score AS Avg_TEST,
       COALESCE(O.hundreds, 0)+COALESCE(t.hundreds, 0)+ COALESCE(s.hundreds, 0) AS Hundreds,
       COALESCE(O.fifties, 0)+COALESCE(t.fifties, 0)+ COALESCE(s.fifties, 0) AS Fifties,
       COALESCE(O.Duck, 0)+COALESCE(t.Ducks, 0)+ COALESCE(s.Ducks, 0) AS Ducks
FROM Silver.Batting_ODI O
LEFT JOIN Silver.Batting_T20 T ON O.Player = T.Player
LEFT JOIN Silver.Batting_TEST S ON S.Player = O.Player;

GO

-- Drop View if Exist
IF OBJECT_ID ('Gold.Bowling_States', 'V') IS NOT NULL
DROP VIEW Gold.Bowling_States;

GO

-- Create View

CREATE VIEW Gold.Bowling_States AS
SELECT O.Player,
	   O.Country,
       COALESCE(O.Matches, 0)+COALESCE(T.Matches, 0)+ COALESCE(S.Matches, 0) AS Matches,
       COALESCE(O.Wickets, 0)+COALESCE(T.Wickets, 0)+ COALESCE(S.Wickets, 0) AS Wickets,
       o.Average AS ODI_Avg,
       T.Average AS T20_Avg,
       S.Average AS TEST_Avg,
       COALESCE(O.Four_Wickets, 0)+COALESCE(T.Four_Wickets, 0)+ COALESCE(S.Four_Wickets, 0) AS Four_Wickets,
       COALESCE(O.Five_wickets, 0)+COALESCE(T.Five_wickets, 0)+ COALESCE(S.Five_wickets, 0) AS Five_wickets,
       O.Economy AS ODI_Eco,
       T.Economy AS T20_Eco,
       S.Economy AS TEST_Eco
FROM Silver.Bowling_ODI O
LEFT JOIN Silver.Bowling_T20 T ON O.Player = T.Player
LEFT JOIN Silver.Bowling_TEST S ON S.Player = O.Player;

GO

-- Drop View if Exist
IF OBJECT_ID ('Gold.AllRound_States_ODI', 'V') IS NOT NULL
DROP VIEW Gold.AllRound_States_ODI;

GO

-- Create View

CREATE VIEW Gold.AllRound_States_ODI AS
SELECT T.Player,
	   T.Country,
       T.Span,
       T.Matches,
       T.Runs,
       T.High_score,
       T.Hundreds,
       T.Fifties,
       L.Wickets,
       L.Economy
FROM Silver.Batting_ODI T
INNER JOIN Silver.Bowling_ODI L ON T.Player = L.Player;

GO

-- Drop View if Exist
IF OBJECT_ID ('Gold.AllRound_States_T20', 'V') IS NOT NULL
DROP VIEW Gold.AllRound_States_T20;

GO

-- Create View

CREATE VIEW Gold.AllRound_States_T20 AS
SELECT T.Player,
	   T.Country,
       T.Span,
       T.Matches,
       T.Runs,
       T.Not_out,
       T.Srike_rate,
       T.High_score,
       T.Hundreds,
       T.Fifties,
       T.Sixes,
       L.Maidens,
       L.Wickets,
       L.Economy
FROM Silver.Batting_T20 T
INNER JOIN Silver.Bowling_T20 L ON T.Player = L.Player
GO

-- Drop View if Exist
IF OBJECT_ID ('Gold.AllRound_States_TEST', 'V') IS NOT NULL
DROP VIEW Gold.AllRound_States_TEST;

GO

-- Create View

CREATE VIEW Gold.AllRound_States_TEST AS
SELECT DISTINCT T.Player,
				T.Country,
                T.Span,
                T.Matches,
                T.Runs,
                T.Not_out,
                T.High_score,
                T.Avg_score,
                T.Hundreds,
                L.Overs,
                L.Wickets,
                L.Economy,
                L.Four_wickets,
                L.Five_wickets
FROM Silver.Batting_TEST T
INNER JOIN Silver.Bowling_TEST L ON T.Player = L.Player;
GO
