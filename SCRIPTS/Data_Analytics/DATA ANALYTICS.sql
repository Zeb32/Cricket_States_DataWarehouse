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

--19. **Find out players whose performance has improved over time (based on batting average year over year).**
--OUR DATA DONT HAVE ANY YEARLY DATA

--20. **Which 10 player has the best 'Batting Impact Score' calculated as (Runs Scored * Strike Rate) / 1000?**
SELECT top 10 Player,
           Country,
           Runs,
           Srike_rate,
           round((Runs*Srike_rate)/1000, 2) AS Batting_Impact
FROM Silver.Batting_T20
ORDER BY round((Runs*Srike_rate)/1000, 2) DESC

----------------------------------------------------------------------------------------------

--### **Advanced Analytics Questions (Deeper Analysis):**
--21. **Using a moving average, analyze the trend of a player's batting average across their career.**
--22. **Perform a year-by-year comparison of a team's overall bowling strike rate.**
--23. **Predict which current players are likely to reach 10,000 runs first using trend analysis.**
--24. **Cluster players into groups: 'Pure Batsman', 'Bowling All-Rounder', 'Batting All-Rounder', 'Pure Bowler' using batting and bowling stats.**
--25. **Calculate and visualize player consistency: Standard deviation of runs scored per match.**
--26. **Find correlation between batting strike rate and batting average.**
--27. **Perform a time series analysis on the number of centuries scored per year in ODIs.**
--28. **Predict the expected number of wickets for a bowler in the next 5 matches based on current form.**
--29. **Identify outliers: Players who have either extremely high or low performance compared to the average.**
--30. **Use linear regression to estimate runs scored based on balls faced and strike rate.**