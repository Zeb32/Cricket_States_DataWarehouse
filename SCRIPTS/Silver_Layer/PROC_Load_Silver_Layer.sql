-------------------------------------------------------------------------------------------
/* This Script Create Store Procedure for Silver Layer to Cleaned, Transform Data of Branze
Layer and Upload it Directly to Silver Layer, Folow The same Procedure first truncate the
Table and Then Insert the Data into Table */ ----------------------------------------------
-------------------------------------------------------------------------------------------
-- Craete Store Procedure "Silver_Load"

CREATE
OR
ALTER PROCEDURE Silver.Silver_Load AS 
BEGIN 
	PRINT '---------------------------------------------'
	--- Truncate and Insert Data into Silver.Batting_ODI
	PRINT 'Uploaded Data into Silver.Batting_ODI'
	TRUNCATE TABLE Silver.Batting_ODI; -- Truncate Table

	INSERT INTO Silver.Batting_ODI (-- Insert The Data
	 Id, Player,Country, Span, Matches, Innings, Not_out, Runs, High_score, Avg_score, Bf, Srike_rate, Hundreds, Fifties, Duck)
	SELECT Id,
		   Trim(LEFT(player, CHARINDEX('(', player) - 1)) AS Player,
		   CASE  
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%INDIA%' THEN 'INDIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%PAK%' THEN 'PAKISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SA%' THEN 'SOUTH AFRICA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%KEN%' THEN 'KENYA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BDESH%' THEN 'BANGLADESH'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SL%' THEN 'SRI LANKA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%NZ%' THEN 'NEW ZEALAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BMUDA%' THEN 'BERMUDA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%CAN%' THEN 'CANADA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ENG%' THEN 'ENGLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%IRE%' THEN 'IRELAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NEPAL%' THEN 'NEPAL'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NAM%' THEN 'NAMIBIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SCO%' THEN 'SCOTLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%WI%' THEN 'WEST INDIES'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AUS%' THEN 'AUSTRALIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%HKG%' THEN 'HONG KONG'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ZIM%' THEN 'ZIMBABEW'
				 ELSE SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1)
			END as Country,
		   trim(Span) AS Span,
		   Matches,
		   Innings,
		   Not_out,
		   Runs,
		   CASE
			   WHEN High_score like '%*%' THEN cast(replace(high_Score, '*', '') AS int)
			   ELSE cast(high_score AS int)
		   END AS High_score,
		   cast(Avg_score AS float) AS Avg_Score,
		   Bf AS BF,
		   cast(Srike_rate AS float) AS Srike_rate,
		   Hundreds,
		   Fifties,
		   Duck
	FROM Bronze.Batting_ODI
	WHERE Matches > 0
	  AND Innings > 0
	  AND Runs > 0; 
 
	 --- Truncate and Insert Data into Silver.Batting_T2O
	 PRINT 'Uploaded Data into Silver.Batting_T20'
	  TRUNCATE TABLE Silver.Batting_T20;
	  INSERT INTO Silver.Batting_T20 (Id, Player,Country, Span, Matches, Innings, Not_out, Runs, High_score, Avg_score, BF, Srike_rate, Hundreds, Fifties, Ducks, Fourse, Sixes)
	SELECT Id,
		   Trim(LEFT(player, CHARINDEX('(', player) - 1)) AS Player,
		   CASE  
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%INDIA%' THEN 'INDIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%PAK%' THEN 'PAKISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SA%' THEN 'SOUTH AFRICA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%KEN%' THEN 'KENYA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BDESH%' THEN 'BANGLADESH'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SL%' THEN 'SRI LANKA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%NZ%' THEN 'NEW ZEALAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BMUDA%' THEN 'BERMUDA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%CAN%' THEN 'CANADA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ENG%' THEN 'ENGLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%IRE%' THEN 'IRELAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NEPAL%' THEN 'NEPAL'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NAM%' THEN 'NAMIBIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SCO%' THEN 'SCOTLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%WI%' THEN 'WEST INDIES'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AUS%' THEN 'AUSTRALIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%HKG%' THEN 'HONG KONG'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ZIM%' THEN 'ZIMBABEW'
				 ELSE SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1)
			END as Country,
		   Trim(Span) AS Span,
		   Matches,
		   Innings,
		   Not_out,
		   Runs,
		   CASE
			   WHEN High_score like '%*%' THEN cast(replace(high_Score, '*', '') AS int)
			   ELSE cast(high_score AS int)
		   END AS High_score,
		   CASE
			   WHEN Avg_score = '-' THEN NULL
			   WHEN Avg_Score IS NULL THEN NULL
			   WHEN try_cast(Avg_Score AS float) IS NULL THEN NULL
			   ELSE cast(Avg_Score AS float)
		   END AS Avg_score,
		   Bf AS BF,
		   CASE
			   WHEN Srike_rate = '-' THEN NULL
			   WHEN Srike_rate IS NULL THEN NULL
			   WHEN try_cast(Srike_rate AS float) IS NULL THEN NULL
			   ELSE cast(Srike_rate AS float)
		   END AS Srike_rate,
		   Hundreds,
		   Fifties,
		   Ducks,
		   Fourse,
		   Sixes
	FROM Bronze.Batting_T20
	WHERE Matches > 0
	  AND Innings > 0
	  AND Runs > 0; 
  
	  --- Truncate and Insert Data into Silver.Batting_TEST
	  PRINT 'Uploaded Data into Silver.Batting_TEST'
	  TRUNCATE TABLE Silver.Batting_TEST;
	  INSERT INTO Silver.Batting_TEST (Id, Player,Country, Span, Matches, Innings, Not_out, Runs, High_score, Avg_score, Hundreds, Fifties, Ducks)
	SELECT Id,
		   Trim(LEFT(player, CHARINDEX('(', player) - 1)) AS Player,
		   CASE  
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%INDIA%' THEN 'INDIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%PAK%' THEN 'PAKISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SA%' THEN 'SOUTH AFRICA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%KEN%' THEN 'KENYA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BDESH%' THEN 'BANGLADESH'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SL%' THEN 'SRI LANKA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%NZ%' THEN 'NEW ZEALAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BMUDA%' THEN 'BERMUDA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%CAN%' THEN 'CANADA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ENG%' THEN 'ENGLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%IRE%' THEN 'IRELAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NEPAL%' THEN 'NEPAL'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NAM%' THEN 'NAMIBIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SCO%' THEN 'SCOTLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%WI%' THEN 'WEST INDIES'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AUS%' THEN 'AUSTRALIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%HKG%' THEN 'HONG KONG'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ZIM%' THEN 'ZIMBABEW'
				 ELSE SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1)
			END as Country,
		   tRIM(Span) AS Span,
		   Matches,
		   Innings,
		   Not_out,
		   Runs,
		   CASE
			   WHEN High_score like '%*%' THEN cast(replace(high_Score, '*', '') AS int)
			   ELSE cast(high_score AS int)
		   END AS High_score,
		   CASE
			   WHEN Avg_score = '-' THEN NULL
			   WHEN Avg_Score IS NULL THEN NULL
			   WHEN try_cast(Avg_Score AS float) IS NULL THEN NULL
			   ELSE cast(Avg_Score AS float)
		   END AS AvgScore,
		   Hundreds,
		   Fifties,
		   Ducks
	FROM Bronze.Batting_TEST
	WHERE Matches > 0
	  AND Innings > 0
	  AND Runs > 0;
	  
	  PRINT '--------------------------------------------'
	  --- Truncate and Insert Data into Silver.Bowling_ODI
	  PRINT 'Uploaded Data into Silver.Bowling_ODI'
	  TRUNCATE TABLE Silver.Bowling_ODI;
	  INSERT INTO Silver.Bowling_ODI (Id, Player,Country, Span, Matches, Innings, Balls, Runs, Wickets, BBI, Average, Economy, Strike_rate, Four_wickets, Five_wickets)
	SELECT Id,
		   Trim(LEFT(player, CHARINDEX('(', player) - 1)) AS Player,
		   CASE  
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%INDIA%' THEN 'INDIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%PAK%' THEN 'PAKISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SA%' THEN 'SOUTH AFRICA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%KEN%' THEN 'KENYA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BDESH%' THEN 'BANGLADESH'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SL%' THEN 'SRI LANKA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%NZ%' THEN 'NEW ZEALAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BMUDA%' THEN 'BERMUDA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%CAN%' THEN 'CANADA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ENG%' THEN 'ENGLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%IRE%' THEN 'IRELAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NEPAL%' THEN 'NEPAL'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NAM%' THEN 'NAMIBIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SCO%' THEN 'SCOTLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%WI%' THEN 'WEST INDIES'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AUS%' THEN 'AUSTRALIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%HKG%' THEN 'HONG KONG'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ZIM%' THEN 'ZIMBABEW'
				 ELSE SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1)
			END as Country,
		   Trim(Span) AS Span,
		   Matches,
		   Innings,
		   Balls,
		   Runs,
		   Wickets,
		   CASE
			   WHEN Bbi = '-' THEN NULL
			   WHEN Bbi IS NULL THEN NULL
			   WHEN try_cast(Bbi AS DATE) IS NULL THEN NULL
			   ELSE cast(Bbi AS DATE)
		   END AS BBI,
		   CASE
			   WHEN AVG = '-' THEN NULL
			   WHEN AVG IS NULL THEN NULL
			   WHEN try_cast(AVG AS float) IS NULL THEN NULL
			   ELSE cast(AVG AS float)
		   END AS Average,
		   CASE
			   WHEN Economy = '-' THEN NULL
			   WHEN Economy IS NULL THEN NULL
			   WHEN try_cast(Economy AS float) IS NULL THEN NULL
			   ELSE cast(Economy AS float)
		   END AS Economy,
		   CASE
			   WHEN Strike_rate = '-' THEN NULL
			   WHEN Strike_rate IS NULL THEN NULL
			   WHEN try_cast(Strike_rate AS float) IS NULL THEN NULL
			   ELSE cast(Strike_rate AS float)
		   END AS Strike_rate,
		   Four_wickets,
		   Five_wickets
	FROM Bronze.Bowling_ODI
	WHERE Matches > 0
	  AND Innings > 0
	  AND Runs > 0
	  AND Wickets > 0; 
  
	  --- Truncate and Insert Data into Silver.Bowling_T20
	  PRINT 'Uploaded Data into Silver.Bowling_T20'
	  TRUNCATE TABLE Silver.Bowling_T20;
	  INSERT INTO Silver.Bowling_T20 (Id, Player,Country, Span, Matches, Innings, Overs, Maidens, Runs, Wickets, BBI, Average, Economy, Strike_rate, Four_wickets, Five_wickets)
	SELECT Id,
		   Trim(LEFT(player, CHARINDEX('(', player) - 1)) AS Player,
		   CASE  
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%INDIA%' THEN 'INDIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%PAK%' THEN 'PAKISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SA%' THEN 'SOUTH AFRICA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%KEN%' THEN 'KENYA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BDESH%' THEN 'BANGLADESH'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SL%' THEN 'SRI LANKA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%NZ%' THEN 'NEW ZEALAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BMUDA%' THEN 'BERMUDA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%CAN%' THEN 'CANADA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ENG%' THEN 'ENGLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%IRE%' THEN 'IRELAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NEPAL%' THEN 'NEPAL'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NAM%' THEN 'NAMIBIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SCO%' THEN 'SCOTLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%WI%' THEN 'WEST INDIES'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AUS%' THEN 'AUSTRALIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%HKG%' THEN 'HONG KONG'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ZIM%' THEN 'ZIMBABEW'
				 ELSE SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1)
			END as Country,
		   Trim(Span) AS Span,
		   Matches,
		   Innings,
		   Cast(Overs AS float) AS Overs,
		   Maidens,
		   Runs,
		   Wickets,
		   Bbi AS BBI,
		   CASE
			   WHEN AVG = '-' THEN NULL
			   WHEN AVG IS NULL THEN NULL
			   WHEN try_cast(AVG AS float) IS NULL THEN NULL
			   ELSE cast(AVG AS float)
		   END AS Average,
		   CASE
			   WHEN Economy = '-' THEN NULL
			   WHEN Economy IS NULL THEN NULL
			   WHEN try_cast(Economy AS float) IS NULL THEN NULL
			   ELSE cast(Economy AS float)
		   END AS Economy,
		   CASE
			   WHEN Strike_rate = '-' THEN NULL
			   WHEN Strike_rate IS NULL THEN NULL
			   WHEN try_cast(Strike_rate AS float) IS NULL THEN NULL
			   ELSE cast(Strike_rate AS float)
		   END AS Strike_rate,
		   Four_wickets,
		   Five_wickets
	FROM Bronze.Bowling_T20
	WHERE Matches > 0
	  AND Innings > 0
	  AND Runs > 0
	  AND Wickets > 0; 
  
	  --- Truncate and Insert Data into Silver.Bowling_TEST
	  PRINT 'Uploaded Data into Silver.Bowling_TEST'
	  TRUNCATE TABLE Silver.Bowling_TEST;
	  INSERT INTO Silver.Bowling_TEST (Id, Player,Country, Span, Matches, Innings, Overs, Runs, Wickets, Bbi, Bbm, Average, Economy, Strike_rate, Four_wickets, Five_wickets)
	SELECT Id,
		   Trim(LEFT(player, CHARINDEX('(', player) - 1)) AS Player,
		   CASE  
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%INDIA%' THEN 'INDIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%PAK%' THEN 'PAKISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SA%' THEN 'SOUTH AFRICA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%KEN%' THEN 'KENYA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BDESH%' THEN 'BANGLADESH'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SL%' THEN 'SRI LANKA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%NZ%' THEN 'NEW ZEALAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%BMUDA%' THEN 'BERMUDA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%CAN%' THEN 'CANADA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ENG%' THEN 'ENGLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AFG%' THEN 'AFGHANISTAN'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%IRE%' THEN 'IRELAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NEPAL%' THEN 'NEPAL'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%NAM%' THEN 'NAMIBIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%SCO%' THEN 'SCOTLAND'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%WI%' THEN 'WEST INDIES'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%AUS%' THEN 'AUSTRALIA'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%HKG%' THEN 'HONG KONG'
				 WHEN SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE  '%ZIM%' THEN 'ZIMBABEW'
				 ELSE SUBSTRING(player,CHARINDEX('(', player) + 1,CHARINDEX(')', player) - CHARINDEX('(', player) - 1)
			END as Country,
		   Trim(Span) AS Span,
		   Matches,
		   Innings,
		   Cast(Overs AS Int) Overs,
		   Runs,
		   Wickets,
		   BBI,
		   BBM,
		   CASE
			   WHEN AVG = '-' THEN NULL
			   WHEN AVG IS NULL THEN NULL
			   WHEN try_cast(AVG AS float) IS NULL THEN NULL
			   ELSE cast(AVG AS float)
		   END AS Average,
		   CASE
			   WHEN Economy = '-' THEN NULL
			   WHEN Economy IS NULL THEN NULL
			   WHEN try_cast(Economy AS float) IS NULL THEN NULL
			   ELSE cast(Economy AS float)
		   END AS Economy,
		   CASE
			   WHEN Strike_rate = '-' THEN NULL
			   WHEN Strike_rate IS NULL THEN NULL
			   WHEN try_cast(Strike_rate AS float) IS NULL THEN NULL
			   ELSE cast(Strike_rate AS float)
		   END AS Strike_rate,
		   Four_wickets,
		   Five_wickets
	FROM Bronze.Bowling_TEST
	WHERE Matches > 0
	  AND Innings > 0
	  AND Runs > 0
	  AND Wickets > 0; 
END 
  
  
  EXEC Silver.Silver_Load -- Execute the Procedure
