-- 2_insert.sql
-- Run after 1_create.sql. Fills the 2 tables with REAL data.
-- Source: ESPNcricinfo Statsguru, collected November 2026.
-- Players: the Pindiz squad for PSL 2026 (official team page, thepindiz.com).
-- Performances: each player's last 10 PSL matches (from the last 2 years).

USE pak_cricket;


-- ===== Players =====
-- (player_id, name, role, country)
INSERT INTO Players VALUES (101, 'Mohammad Rizwan'    , 'Wicketkeeper' , 'Pakistan');
INSERT INTO Players VALUES (102, 'Naseem Shah'        , 'Bowler'       , 'Pakistan');
INSERT INTO Players VALUES (103, 'Mohammad Amir'      , 'Bowler'       , 'Pakistan');
INSERT INTO Players VALUES (104, 'Daryl Mitchell'     , 'All-rounder'  , 'New Zealand');
INSERT INTO Players VALUES (105, 'Sam Billings'       , 'Wicketkeeper' , 'England');
INSERT INTO Players VALUES (106, 'Yasir Khan'         , 'Batter'       , 'Pakistan');
INSERT INTO Players VALUES (107, 'Kamran Ghulam'      , 'Batter'       , 'Pakistan');
INSERT INTO Players VALUES (108, 'Rishad Hossain'     , 'Bowler'       , 'Bangladesh');
INSERT INTO Players VALUES (109, 'Asif Afridi'        , 'All-rounder'  , 'Pakistan');
INSERT INTO Players VALUES (110, 'Dian Forrester'     , 'All-rounder'  , 'South Africa');
INSERT INTO Players VALUES (111, 'Abdullah Fazal'     , 'Batter'       , 'Pakistan');
INSERT INTO Players VALUES (112, 'Usman Khawaja'      , 'Batter'       , 'Australia');
INSERT INTO Players VALUES (113, 'Amad Butt'          , 'All-rounder'  , 'Pakistan');
INSERT INTO Players VALUES (114, 'Cole McConchie'     , 'All-rounder'  , 'New Zealand');
INSERT INTO Players VALUES (115, 'Mohammad Amir Khan' , 'Bowler'       , 'Pakistan');
INSERT INTO Players VALUES (116, 'Shahzaib Khan'      , 'Batter'       , 'Pakistan');
INSERT INTO Players VALUES (117, 'Saad Masood'        , 'All-rounder'  , 'Pakistan');
INSERT INTO Players VALUES (118, 'Razaullah Khan'     , 'Bowler'       , 'Pakistan');
INSERT INTO Players VALUES (119, 'Jalat Khan'         , 'Bowler'       , 'Pakistan');


-- ===== Performances =====
-- (performance_id, player_id, match_date, runs, wickets)
-- runs NULL = did not bat, wickets NULL = did not bowl

-- Mohammad Rizwan
INSERT INTO Performances VALUES (301, 101, '2026-03-28',   41, NULL);
INSERT INTO Performances VALUES (302, 101, '2026-04-02',   21, NULL);
INSERT INTO Performances VALUES (303, 101, '2026-04-04',    2, NULL);
INSERT INTO Performances VALUES (304, 101, '2026-04-06',   19, NULL);
INSERT INTO Performances VALUES (305, 101, '2026-04-10',    0, NULL);
INSERT INTO Performances VALUES (306, 101, '2026-04-16',   15, NULL);
INSERT INTO Performances VALUES (307, 101, '2026-04-18',    9, NULL);
INSERT INTO Performances VALUES (308, 101, '2026-04-21',   26, NULL);
INSERT INTO Performances VALUES (309, 101, '2026-04-23',   45, NULL);
INSERT INTO Performances VALUES (310, 101, '2026-04-26',   26, NULL);

-- Naseem Shah
INSERT INTO Performances VALUES (311, 102, '2025-04-20', NULL, 2);
INSERT INTO Performances VALUES (312, 102, '2025-04-30',   11, 0);
INSERT INTO Performances VALUES (313, 102, '2025-05-02',    1, 1);
INSERT INTO Performances VALUES (314, 102, '2025-05-03',    1, 2);
INSERT INTO Performances VALUES (315, 102, '2025-05-07',    5, 1);
INSERT INTO Performances VALUES (316, 102, '2025-05-21',    0, 0);
INSERT INTO Performances VALUES (317, 102, '2025-05-23',    0, 0);
INSERT INTO Performances VALUES (318, 102, '2026-03-28', NULL, 0);
INSERT INTO Performances VALUES (319, 102, '2026-04-02', NULL, 1);
INSERT INTO Performances VALUES (320, 102, '2026-04-23', NULL, 1);

-- Mohammad Amir
INSERT INTO Performances VALUES (321, 103, '2026-03-28', NULL, 1);
INSERT INTO Performances VALUES (322, 103, '2026-04-02', NULL, 1);
INSERT INTO Performances VALUES (323, 103, '2026-04-04', NULL, 1);
INSERT INTO Performances VALUES (324, 103, '2026-04-06', NULL, 2);
INSERT INTO Performances VALUES (325, 103, '2026-04-10',    0, 2);
INSERT INTO Performances VALUES (326, 103, '2026-04-16',    2, 1);
INSERT INTO Performances VALUES (327, 103, '2026-04-18',    4, 2);
INSERT INTO Performances VALUES (328, 103, '2026-04-21', NULL, 0);
INSERT INTO Performances VALUES (329, 103, '2026-04-23', NULL, 2);
INSERT INTO Performances VALUES (330, 103, '2026-04-26',    0, 0);

-- Daryl Mitchell
INSERT INTO Performances VALUES (331, 104, '2025-05-04',    0, 2);
INSERT INTO Performances VALUES (332, 104, '2026-03-28',   23, NULL);
INSERT INTO Performances VALUES (333, 104, '2026-04-02',   65, 3);
INSERT INTO Performances VALUES (334, 104, '2026-04-04',   19, 0);
INSERT INTO Performances VALUES (335, 104, '2026-04-06',   17, 0);
INSERT INTO Performances VALUES (336, 104, '2026-04-10',   30, 0);
INSERT INTO Performances VALUES (337, 104, '2026-04-16',    0, NULL);
INSERT INTO Performances VALUES (338, 104, '2026-04-18',   11, 0);
INSERT INTO Performances VALUES (339, 104, '2026-04-21',   58, NULL);
INSERT INTO Performances VALUES (340, 104, '2026-04-23',   32, 1);

-- Sam Billings
INSERT INTO Performances VALUES (341, 105, '2026-03-28',   18, NULL);
INSERT INTO Performances VALUES (342, 105, '2026-04-02',   58, NULL);
INSERT INTO Performances VALUES (343, 105, '2026-04-04',    7, NULL);
INSERT INTO Performances VALUES (344, 105, '2026-04-06',   56, NULL);
INSERT INTO Performances VALUES (345, 105, '2026-04-10',    1, NULL);
INSERT INTO Performances VALUES (346, 105, '2026-04-16',   26, NULL);
INSERT INTO Performances VALUES (347, 105, '2026-04-18',    7, NULL);
INSERT INTO Performances VALUES (348, 105, '2026-04-21',   29, NULL);
INSERT INTO Performances VALUES (349, 105, '2026-04-23',    2, NULL);
INSERT INTO Performances VALUES (350, 105, '2026-04-26',   23, NULL);

-- Yasir Khan
INSERT INTO Performances VALUES (351, 106, '2025-05-05',   10, NULL);
INSERT INTO Performances VALUES (352, 106, '2025-05-18',   45, NULL);
INSERT INTO Performances VALUES (353, 106, '2026-03-28',   83, NULL);
INSERT INTO Performances VALUES (354, 106, '2026-04-02',    8, NULL);
INSERT INTO Performances VALUES (355, 106, '2026-04-04',    2, NULL);
INSERT INTO Performances VALUES (356, 106, '2026-04-06',    5, NULL);
INSERT INTO Performances VALUES (357, 106, '2026-04-10',   22, NULL);
INSERT INTO Performances VALUES (358, 106, '2026-04-16',   24, NULL);
INSERT INTO Performances VALUES (359, 106, '2026-04-18',   58, NULL);
INSERT INTO Performances VALUES (360, 106, '2026-04-21',    4, NULL);

-- Kamran Ghulam
INSERT INTO Performances VALUES (361, 107, '2025-04-23',   13, NULL);
INSERT INTO Performances VALUES (362, 107, '2025-04-26',   52, NULL);
INSERT INTO Performances VALUES (363, 107, '2025-04-29',    3, NULL);
INSERT INTO Performances VALUES (364, 107, '2025-05-01',   29, NULL);
INSERT INTO Performances VALUES (365, 107, '2026-03-28',   37, NULL);
INSERT INTO Performances VALUES (366, 107, '2026-04-02',   10, NULL);
INSERT INTO Performances VALUES (367, 107, '2026-04-04',   50, 0);
INSERT INTO Performances VALUES (368, 107, '2026-04-06',   35, NULL);
INSERT INTO Performances VALUES (369, 107, '2026-04-23',   42, NULL);
INSERT INTO Performances VALUES (370, 107, '2026-04-26',    0, NULL);

-- Rishad Hossain
INSERT INTO Performances VALUES (371, 108, '2025-04-15',    2, 3);
INSERT INTO Performances VALUES (372, 108, '2025-04-22',    2, 2);
INSERT INTO Performances VALUES (373, 108, '2025-04-24',   13, 0);
INSERT INTO Performances VALUES (374, 108, '2025-05-04',    0, 1);
INSERT INTO Performances VALUES (375, 108, '2025-05-23',    5, 3);
INSERT INTO Performances VALUES (376, 108, '2025-05-25', NULL, 1);
INSERT INTO Performances VALUES (377, 108, '2026-03-28', NULL, 1);
INSERT INTO Performances VALUES (378, 108, '2026-04-02',    0, 0);
INSERT INTO Performances VALUES (379, 108, '2026-04-04',    3, 1);
INSERT INTO Performances VALUES (380, 108, '2026-04-06',    1, 0);

-- Asif Afridi
INSERT INTO Performances VALUES (381, 109, '2025-05-01', NULL, NULL);
INSERT INTO Performances VALUES (382, 109, '2025-05-04',    6, 1);
INSERT INTO Performances VALUES (383, 109, '2026-03-28', NULL, 1);
INSERT INTO Performances VALUES (384, 109, '2026-04-06',    7, 0);
INSERT INTO Performances VALUES (385, 109, '2026-04-10',    0, 0);
INSERT INTO Performances VALUES (386, 109, '2026-04-16',   15, 2);
INSERT INTO Performances VALUES (387, 109, '2026-04-18',    4, 0);
INSERT INTO Performances VALUES (388, 109, '2026-04-21', NULL, 2);
INSERT INTO Performances VALUES (389, 109, '2026-04-23', NULL, 1);
INSERT INTO Performances VALUES (390, 109, '2026-04-26',    3, 1);

-- Dian Forrester
INSERT INTO Performances VALUES (391, 110, '2026-04-04',   44, 0);
INSERT INTO Performances VALUES (392, 110, '2026-04-06',   24, 0);
INSERT INTO Performances VALUES (393, 110, '2026-04-18',    8, NULL);
INSERT INTO Performances VALUES (394, 110, '2026-04-21',   37, 0);
INSERT INTO Performances VALUES (395, 110, '2026-04-23',   13, 2);
INSERT INTO Performances VALUES (396, 110, '2026-04-26',    6, 0);

-- Abdullah Fazal
INSERT INTO Performances VALUES (397, 111, '2026-03-28',    5, NULL);
INSERT INTO Performances VALUES (398, 111, '2026-04-02',   18, NULL);
INSERT INTO Performances VALUES (399, 111, '2026-04-04',   23, NULL);
INSERT INTO Performances VALUES (400, 111, '2026-04-06',   14, NULL);
INSERT INTO Performances VALUES (401, 111, '2026-04-10',   20, NULL);
INSERT INTO Performances VALUES (402, 111, '2026-04-16',   11, NULL);
INSERT INTO Performances VALUES (403, 111, '2026-04-23',    0, NULL);

-- Usman Khawaja
INSERT INTO Performances VALUES (404, 112, '2026-04-10',    7, NULL);
INSERT INTO Performances VALUES (405, 112, '2026-04-16',    2, NULL);
INSERT INTO Performances VALUES (406, 112, '2026-04-26',   66, NULL);

-- Amad Butt
INSERT INTO Performances VALUES (407, 113, '2026-03-28', NULL, 2);
INSERT INTO Performances VALUES (408, 113, '2026-04-26',    3, 1);

-- Cole McConchie
INSERT INTO Performances VALUES (409, 114, '2026-04-02',    2, 0);
INSERT INTO Performances VALUES (410, 114, '2026-04-18',    3, 0);
INSERT INTO Performances VALUES (411, 114, '2026-04-23', NULL, 0);

-- Mohammad Amir Khan
INSERT INTO Performances VALUES (412, 115, '2026-04-02', NULL, 0);
INSERT INTO Performances VALUES (413, 115, '2026-04-04',    0, 0);
INSERT INTO Performances VALUES (414, 115, '2026-04-06',    0, 1);

-- Shahzaib Khan
INSERT INTO Performances VALUES (415, 116, '2026-04-18',    7, NULL);
INSERT INTO Performances VALUES (416, 116, '2026-04-21',    0, NULL);
INSERT INTO Performances VALUES (417, 116, '2026-04-26',    1, NULL);

-- Saad Masood
INSERT INTO Performances VALUES (418, 117, '2025-04-14', NULL, 1);
INSERT INTO Performances VALUES (419, 117, '2025-04-23',    0, NULL);
INSERT INTO Performances VALUES (420, 117, '2025-05-02',    1, 0);
INSERT INTO Performances VALUES (421, 117, '2026-04-10',   31, 0);
INSERT INTO Performances VALUES (422, 117, '2026-04-16',   10, 1);
INSERT INTO Performances VALUES (423, 117, '2026-04-18',   54, 0);
INSERT INTO Performances VALUES (424, 117, '2026-04-21', NULL, 1);
INSERT INTO Performances VALUES (425, 117, '2026-04-23', NULL, 2);
INSERT INTO Performances VALUES (426, 117, '2026-04-26',    5, 2);

-- Razaullah Khan
INSERT INTO Performances VALUES (427, 118, '2026-04-18',    5, 2);
INSERT INTO Performances VALUES (428, 118, '2026-04-21', NULL, 1);

-- Jalat Khan
INSERT INTO Performances VALUES (429, 119, '2026-04-04', NULL, 1);
