-- 1_create.sql
-- Run this FIRST. It makes the database and the 2 empty tables.
-- Safe to run again: it deletes the old tables before making new ones.

CREATE DATABASE IF NOT EXISTS pak_cricket;
USE pak_cricket;

DROP TABLE IF EXISTS Performances;
DROP TABLE IF EXISTS Players;

-- One row for every Pindiz player
CREATE TABLE Players (
    player_id   INT PRIMARY KEY,         -- our own number, starts at 101
    name        VARCHAR(50) NOT NULL,
    role        VARCHAR(20),             -- Batter, Bowler, All-rounder, Wicketkeeper
    country     VARCHAR(20)              -- Pakistan, England, New Zealand ...
);

-- One row for every match: each player's last 10 PSL matches
CREATE TABLE Performances (
    performance_id  INT PRIMARY KEY,     -- starts at 301
    player_id       INT NOT NULL,        -- same number as in Players
    match_date      DATE NOT NULL,
    runs            INT,                 -- NULL means "did not bat"
    wickets         INT                  -- NULL means "did not bowl"
);
