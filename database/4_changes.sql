-- 4_changes.sql
-- Shows UPDATE, ALTER TABLE and DELETE.
-- Every change has a SELECT BEFORE and a SELECT AFTER. Screenshot both.

USE pak_cricket;


-- ===== 1. UPDATE (targeted, with WHERE) =====
-- Demo: pretend Mohammad Rizwan's match 305 (0 runs vs Quetta Gladiators) was 55 instead.
-- Watch it appear in Q1 (runs >= 50) after the change.

-- BEFORE
SELECT * FROM Performances WHERE performance_id = 305;
SELECT performance_id, player_id, runs FROM Performances WHERE runs >= 50 ORDER BY runs DESC;

UPDATE Performances
SET runs = 55                          -- CHANGE ME
WHERE performance_id = 305;            -- CHANGE ME

-- AFTER: 305 now shows up in the Q1 result
SELECT * FROM Performances WHERE performance_id = 305;
SELECT performance_id, player_id, runs FROM Performances WHERE runs >= 50 ORDER BY runs DESC;

-- Put the real value back, so our data stays true
UPDATE Performances SET runs = 0 WHERE performance_id = 305;


-- ===== 2. ALTER TABLE =====
-- Add a new column to say if a player is Active or Rested.

-- BEFORE
SELECT * FROM Players WHERE player_id = 101;

ALTER TABLE Players ADD status VARCHAR(10);

UPDATE Players SET status = 'Active' WHERE player_id = 101;

-- AFTER: Players now has a status column
SELECT * FROM Players WHERE player_id = 101;


-- ===== 3. DELETE (only on a clearly labelled test row) =====
-- TEST ROW: this is not real data. It exists only to show DELETE.
INSERT INTO Performances VALUES (999, 101, '2026-01-01', 0, NULL);  -- TEST ROW

-- BEFORE
SELECT * FROM Performances WHERE performance_id = 999;

DELETE FROM Performances
WHERE performance_id = 999;

-- AFTER: no rows come back
SELECT * FROM Performances WHERE performance_id = 999;
