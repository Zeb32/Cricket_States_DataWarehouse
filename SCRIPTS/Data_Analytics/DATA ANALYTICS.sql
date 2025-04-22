------------------------------------------------------------------------------------------
--### **Intermediate Analytics Questions:**
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

--12. **Identify players who have more than 100 matches across all formats combined.**
SELECT Player_Name,
       Country,
       Matches
FROM GOLD.Batting_States
WHERE Matches > 100
ORDER BY Matches DESC

--13. **Find players who have both 10,000+ runs and 200+ wickets in international cricket.**
SELECT DISTINCT T.Player_Name,
                T.Country,
                T.Runs,
                L.Wickets
FROM Gold.Batting_States T
INNER JOIN GOLD.Bowling_States L ON T.Player_Name = L.Player
WHERE T.Runs > 10000
  AND L.Wickets > 200
ORDER BY T.Runs DESC 

--14. **Which player has the highest batting average but has played fewer than 50 matches?**
SELECT TOP 1 Player_Name,
           Country,
           Matches,
           Avg(Avg_ODI+Avg_T20+Avg_TEST) AS Aerage
FROM Gold.Batting_States
WHERE Matches <= 50
GROUP BY Player_Name,
         Country,
         Matches
ORDER BY Avg(Avg_ODI+Avg_T20+Avg_TEST) DESC 

--15. **Which bowlers consistently maintain an economy rate below 4.0 in ODIs?**
SELECT Player,
       Country,
       Economy
FROM Silver.Bowling_ODI
WHERE Economy < 4
ORDER BY Economy DESC 

--16. **Top 5 players with most sixes hit in T20 format.**
SELECT TOP 5 Player,
           Country,
           Sixes
FROM Silver.Batting_T20
ORDER BY Sixes DESC 

--17. **Top 5 players with most maidens Overs in T20 matches.**
SELECT top 5 Player,
           Country,
           Overs,
           Maidens
FROM Silver.Bowling_T20
ORDER BY Maidens DESC

--18. **Rank players based on 'Overall Performance Score' (example formula: 70% batting performance + 30% bowling performance).**
SELECT player,
       Country,
       Runs,
       Wickets,
       (0.7 * Runs + 0.3 * (Wickets * 20)) AS Overall_Performance,
       RANK() OVER (ORDER BY (0.7 * Runs + 0.3 * (Wickets * 20)) DESC) AS Performance_Rank
FROM gold.AllRound_States_ODI 

--19. **Which 10 player has the best 'Batting Impact Score' calculated as (Runs Scored * Strike Rate) / 1000?**
SELECT top 10 Player,
           Country,
           Runs,
           Srike_rate,
           round((Runs*Srike_rate)/1000, 2) AS Batting_Impact
FROM Silver.Batting_T20
ORDER BY round((Runs*Srike_rate)/1000, 2) DESC

----------------------------------------------------------------------------------------------

--20. **Cluster players into groups: 'Pure Batsman', 'All-Rounder','Pure Bowler' using batting and bowling stats.**

SELECT DISTINCT T.Player_Name,
                T.Country,
                T.Runs,
                L.Wickets,
                CASE
                    WHEN T.Runs >= 5000 AND L.Wickets <= 40 THEN 'Pure Batsman'
                    WHEN T.Runs <= 5000 AND L.Wickets >= 40 THEN 'Pure Bowler'
                    WHEN T.Runs >= 5000 AND L.Wickets >= 40 THEN 'All-Rounder'
                    ELSE 'Not Classified'
                END AS Player_Group
FROM Gold.Batting_States T
INNER JOIN Gold.Bowling_States L ON T.Player_Name = L.Player
ORDER BY RUNS DESC 

--21. **Calculate and visualize player consistency: Standard deviation of runs scored per match.**
SELECT Player_Name,
       ROUND(CAST(Runs AS FLOAT) / Matches, 2) AS Avg_Runs_Per_Match
FROM GOLD.Batting_States
WHERE Matches > 0
ORDER BY ROUND(CAST(Runs AS FLOAT) / Matches, 2) DESC;

--22. **Find correlation between batting strike rate and batting average.**
WITH Stats AS
  (SELECT [Avg_score] AS Batting_Avg,
          [Srike_rate] AS Strike_Rate
   FROM Silver.Batting_T20
   WHERE [Avg_score] IS NOT NULL
     AND [Srike_rate] IS NOT NULL) ,
     Averages AS
  (SELECT AVG(Batting_Avg) AS Avg_Batting_Avg,
          AVG(Strike_Rate) AS Avg_Strike_Rate
   FROM Stats)
SELECT ROUND(SUM((Strike_Rate - A.Avg_Strike_Rate) * (Batting_Avg - A.Avg_Batting_Avg)) / (SQRT(SUM(POWER(Strike_Rate - A.Avg_Strike_Rate, 2))) * SQRT(SUM(POWER(Batting_Avg - A.Avg_Batting_Avg, 2)))), 2) AS Correlation_Coefficient
FROM Stats
CROSS JOIN Averages A;

--23. **Predict the expected number of wickets for a bowler in the next 5 matches based on current form.**

SELECT DISTINCT Player,
                Matches,
                Wickets,
                ROUND(CASE
                          WHEN Matches > 0 THEN (CAST(Wickets AS FLOAT) / Matches) * 5
                          ELSE NULL
                      END, 0) AS Expected_Wickets_Next_5_Matches
FROM GOLD.Bowling_States
WHERE Wickets IS NOT NULL
ORDER BY Expected_Wickets_Next_5_Matches DESC;

--24. **Identify outliers: Players who have either extremely high or low performance compared to the average.**

SELECT Player,
       Avg_score,
       ROUND(Avg(Avg_score) over(), 2) AS OverallAvg
FROM Silver.Batting_ODI
GROUP BY Player,
         Avg_score
ORDER BY Avg_score DESC
