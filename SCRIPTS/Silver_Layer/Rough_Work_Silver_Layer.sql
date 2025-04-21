/*This Code Update all the Value to Null which is ether string in numaric data and cannot converted
 or null when we forecd it float but cannot wit try cast*/ 
 -- but Permanently Update the Table

UPDATE [Cricket_State_Warehouse].[Bronze].[Batting_ODI]
	SET [Avg_score] = NULL
	WHERE [Avg_score] = '-'
	  OR [Avg_score] IS NULL
	  OR TRY_CAST([Avg_score] AS FLOAT) IS NULL;


UPDATE [Cricket_State_Warehouse].[Bronze].[Batting_ODI]
	SET Srike_rate = NULL
	WHERE Srike_rate = '-'
	  OR [Avg_score] IS NULL
	  OR TRY_CAST(Srike_rate AS FLOAT) IS NULL;


/* This Code does the Same as Above but Just Clean the Data in Silver Layer not
permanently Update the Table in Bronze*/
SELECT Player,
       Avg_score,
       CASE
           WHEN Avg_score = '-' THEN NULL
           WHEN Avg_Score IS NULL THEN NULL
           WHEN try_cast(Avg_Score AS float) IS NULL THEN NULL
           ELSE cast(Avg_Score AS float)
       END AS AvgScore
FROM Bronze.Batting_T20
WHERE Avg_score = '-' 


-- This Filter Out the 0 from all these Categries
  SELECT *
  FROM Bronze.Batting_T20 WHERE Matches <= 0
	  OR Innings <= 0
	  OR Runs <= 0 
  

/* It Replace the * value with Nothing in the data for Expamlple
if the data have 200* it removes the Star */
CASE
    WHEN High_score like '%*%' THEN cast(replace(high_Score, '*', '') AS int)
    ELSE cast(high_score AS int)
    END AS High_score, 
	
/* With this Code We Mape the Data from Abreviation to Full Name of the Country
This Could be Shorter but our Data is not Claened that swe need to includ the
Code Every Where*/
  SELECT player,
         SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) AS Cntry_Code,
         CASE
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%INDIA%' THEN 'INDIA'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%PAK%' THEN 'PAKISTAN'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%AFG%' THEN 'AFGHANISTAN'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%SA%' THEN 'SOUTH AFRICA'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%KEN%' THEN 'KENYA'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%BDESH%' THEN 'BANGLADESH'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%SL%' THEN 'SRI LANKA'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%NZ%' THEN 'NEW ZEALAND'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%BMUDA%' THEN 'BERMUDA'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%CAN%' THEN 'CANADA'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%ENG%' THEN 'ENGLAND'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%AFG%' THEN 'AFGHANISTAN'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%IRE%' THEN 'IRELAND'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%NEPAL%' THEN 'NEPAL'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%NAM%' THEN 'NAMIBIA'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%SCO%' THEN 'SCOTLAND'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%WI%' THEN 'WEST INDIES'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%AUS%' THEN 'AUSTRALIA'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%HKG%' THEN 'HONG KONG'
             WHEN SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1) LIKE '%ZIM%' THEN 'ZIMBABEW'
             ELSE SUBSTRING(player, CHARINDEX('(', player) + 1, CHARINDEX(')', player) - CHARINDEX('(', player) - 1)
         END AS Country
  FROM Bronze.Batting_ODI 
  

  -- This Code Give us the information of Table like Column, Data Type etc
  SELECT COLUMN_NAME,
         DATA_TYPE,
         CHARACTER_MAXIMUM_LENGTH
  FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Bowling_T20'
  AND TABLE_SCHEMA = 'silver';