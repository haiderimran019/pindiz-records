-- 3_queries.sql
-- Run after 1_create.sql and 2_insert.sql.
-- Six SELECT queries. Take a screenshot of each result for docs/screenshots/.
-- Values you can change live are marked  -- CHANGE ME
-- Player IDs are on the Players page (101 = Mohammad Rizwan ... 119 = Jalat Khan).

USE pak_cricket;


-- Q1 (brief request 1): matches where a player met the target of 50 runs
SELECT performance_id, player_id, match_date, runs
FROM Performances
WHERE runs >= 50                       -- CHANGE ME (try 30)
ORDER BY runs DESC;


-- Q2 (brief request 2): all batting performances from strongest to weakest
-- The first row is the strongest, the last row is the weakest.
SELECT performance_id, player_id, match_date, runs
FROM Performances
WHERE runs IS NOT NULL
ORDER BY runs DESC;                    -- CHANGE ME (ASC = weakest first)


-- Q3 (uses AND): PSL 2026 matches where a player scored 30 or more
SELECT performance_id, player_id, match_date, runs
FROM Performances
WHERE match_date >= '2026-01-01' AND runs >= 30     -- CHANGE ME (try 20)
ORDER BY runs DESC;


-- Q4 (uses OR) COMPARE TWO PLAYERS: their last 10 matches side by side
-- Pick any 2 players: change the two IDs.
SELECT player_id, match_date, runs, wickets
FROM Performances
WHERE player_id = 101 OR player_id = 105            -- CHANGE ME (any 2 IDs)
ORDER BY player_id, match_date;


-- Q5 (uses OR and AND) COMPARE TWO PLAYERS: only their good matches
-- A good match = 30+ runs or 2+ wickets.
SELECT player_id, match_date, runs, wickets
FROM Performances
WHERE (player_id = 101 OR player_id = 105)          -- CHANGE ME (same 2 IDs)
  AND (runs >= 30 OR wickets >= 2)
ORDER BY player_id, match_date;


-- Q6 (WHERE + ORDER BY): every bowler in the squad
SELECT player_id, name, country
FROM Players
WHERE role = 'Bowler'                  -- CHANGE ME (Batter, All-rounder, Wicketkeeper)
ORDER BY name;
