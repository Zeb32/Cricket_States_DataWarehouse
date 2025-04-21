----------------------------------------------------------------------
--### **Exploratory Analytics Questions:**
----------------------------------------------------------------------
----------------------------------------------------------------------

-- Use DataBase Cricket_State_Warehouse
USE Cricket_State_Warehouse

-- Explore all the Object in the DataBase
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore All Column 
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'AllRound_States_ODI'

--1. **Which player has scored the most runs across all formats?**
 -- 1st Method
SELECT TOP 1 Player_Name,
           Country,
           Runs
FROM Gold.Batting_States
ORDER BY Runs DESC 

-- 2nd Method
SELECT *
FROM
  (SELECT Player_Name,
          Country,
          Runs,
          ROW_NUMBER() over(ORDER BY Runs DESC) AS Ranking
   FROM Gold.Batting_States)A
WHERE Ranking = 1 

--2. **Which player has taken the most wickets across all formats?**
-- 1st Method
  SELECT TOP 1 Player,
             Country,
             Wickets
  FROM Gold.Bowling_States
ORDER BY Wickets DESC 

-- 2nd Method
SELECT *
FROM
  (SELECT Player,
          Country,
          Wickets,
          ROW_NUMBER() over(ORDER BY Wickets DESC) AS Ranking
   FROM Gold.Bowling_States)A
WHERE Ranking = 1

--3. **What is the average batting average by format (Test, ODI, T20)?**
SELECT ROUND(AVG(Avg_ODI), 2) AS ODI_AVG,
       ROUND(AVG(Avg_T20), 2) AS T20_AVG,
       ROUND(AVG(Avg_TEST), 2) AS TEST_AVG
FROM GOLD.Batting_States

--4. **Who has the best batting strike rate in T20 matches?**
 -- 1st Method
SELECT TOP 1 Player,
        Country,
        Srike_rate
FROM Silver.Batting_T20
ORDER BY Srike_rate DESC 

-- 2nd Method
SELECT *
FROM
  (SELECT Player,
          Country,
          Srike_rate,
          ROW_NUMBER() over(ORDER BY Srike_rate DESC) AS Ranking
   FROM Silver.Batting_T20)A
WHERE Ranking = 1 

--5. **List players who have a batting average greater than 50 in Test cricket.**
SELECT Player,
       Avg_score
FROM Silver.Batting_TEST
WHERE Avg_score > 50
ORDER BY Avg_score DESC 

--6. **Which players have centuries (100+ runs) in all three formats?**
SELECT O.Player,
	   O.Country,
       O.Hundreds ODI,
       T.Hundreds T20,
       S.Hundreds TEST
FROM Silver.Batting_ODI O
LEFT JOIN Silver.Batting_T20 T ON O.Player = T.Player
LEFT JOIN Silver.Batting_TEST S ON O.Player = S.Player
WHERE O.Hundreds > 0
  AND T.Hundreds > 0
  AND S.Hundreds > 0
ORDER BY 2 DESC

--7. **Which bowler has the best bowling average in ODIs?**
SELECT TOP 1 Player,
           Country,
           Average
FROM Silver.Bowling_ODI
ORDER BY Average ASC 

--8. **Which bowler has the best economy rate in T20s?**
SELECT TOP 1 Player,
           Country,
           Economy
FROM Silver.Bowling_T20
ORDER BY Economy ASC 

--9. **Find the player with the highest number of 5-wicket hauls in Test matches.**
SELECT TOP 1 Player,
           Country,
           Wickets,
           Five_wickets
FROM Silver.Bowling_TEST
ORDER BY Five_wickets DESC 

--10. **Compare total runs by format. (How many total runs scored in Test vs ODI vs T20?)**
SELECT O.Player,
       O.Country,
       O.Runs ODI,
       S.Runs TEST,
       T.Runs T20
FROM Silver.Batting_ODI O
LEFT JOIN Silver.Batting_T20 T ON O.Player = T.Player
LEFT JOIN Silver.Batting_TEST S ON O.Player = S.Player
ORDER BY O.Runs DESC 

--11. **Which player has the most ducks (0 runs) across all formats?**
SELECT TOP 1 Player_Name,
           Country,
           Ducks
FROM Gold.Batting_States
ORDER BY Ducks DESC

--------------------------------------------------------------------------------------------