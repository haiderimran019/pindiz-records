-- 5_checks.sql
-- Data quality checks (booklet "Findings" rule).
-- We check for: 1) a missing value  2) a duplicate ID  3) an impossible number
-- All checks use TEST ROWS (IDs 900+). Our real data is never changed.

-- MySQL Workbench tip: the duplicate-ID check stops the script ON PURPOSE.
-- Run this file one block at a time (Ctrl+Enter on each statement),
-- or turn on "Continue on SQL Error" in the Query menu.

USE pak_cricket;


-- ===== CHECK 1: missing value =====
-- TEST ROW: a player with no role
INSERT INTO Players (player_id, name, role, country) VALUES (901, 'Test Player One', NULL, 'Pakistan');  -- TEST ROW

-- Find it
SELECT * FROM Players WHERE role IS NULL;

-- Fix it
UPDATE Players SET role = 'Batter' WHERE player_id = 901;

-- Check again: no rows should come back
SELECT * FROM Players WHERE role IS NULL;


-- ===== CHECK 2: duplicate ID =====
-- TEST ROW: try to add a second player with ID 101.
-- MySQL REFUSES this with an error like:
--   Error 1062: Duplicate entry '101' for key 'PRIMARY'
-- The PRIMARY KEY protects the table. Screenshot the error.
INSERT INTO Players (player_id, name, role, country) VALUES (101, 'Test Player Two', 'Batter', 'Pakistan');  -- TEST ROW (fails on purpose)

-- Fix: use the next free ID instead
INSERT INTO Players (player_id, name, role, country) VALUES (902, 'Test Player Two', 'Batter', 'Pakistan');  -- TEST ROW

-- Check: each ID appears once
SELECT player_id, name FROM Players WHERE player_id IN (101, 902);


-- ===== CHECK 3: impossible number =====
-- TEST ROW: a match with minus 3 wickets (impossible)
INSERT INTO Performances VALUES (903, 102, '2026-01-01', 5, -3);  -- TEST ROW

-- Find impossible values (negative runs or wickets, or more than 10 wickets in one T20 match)
SELECT * FROM Performances
WHERE runs < 0 OR wickets < 0 OR wickets > 10;

-- Fix it: delete the bad row
DELETE FROM Performances WHERE performance_id = 903;

-- Check again: no rows should come back
SELECT * FROM Performances
WHERE runs < 0 OR wickets < 0 OR wickets > 10;


-- ===== Clean up: remove the other test rows =====
DELETE FROM Players WHERE player_id IN (901, 902);
