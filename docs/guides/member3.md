# Member 3: Database (SQL)
**Your files:** `database/1_create.sql` to `5_checks.sql`

## What your files do
| File | What it does |
|---|---|
| 1_create.sql | Makes the database `pak_cricket` and 2 tables: Players and Performances |
| 2_insert.sql | Adds the real data (19 players, 129 matches) |
| 3_queries.sql | Six SELECT queries, Q1–Q6 |
| 4_changes.sql | UPDATE, ALTER TABLE and DELETE, each with a SELECT before and after |
| 5_checks.sql | Finds a missing value, a duplicate ID and an impossible number using test rows |

- **PRIMARY KEY**: a column whose value must be unique in each row (`player_id`, `performance_id`).
- **player_id** links the 2 tables: the same number appears in Players and Performances.
- **NULL** means "no value": runs NULL = did not bat, wickets NULL = did not bowl.

The six queries:
| Query | Answers | Key part |
|---|---|---|
| Q1 | Which matches reached 50 runs? | `WHERE runs >= 50` |
| Q2 | Strongest to weakest performances | `ORDER BY runs DESC` |
| Q3 | PSL 2026 matches with 30+ runs | `WHERE match_date >= '2026-01-01' AND runs >= 30` |
| Q4 | **Compare 2 players**: last 10 matches | `WHERE player_id = 101 OR player_id = 105` |
| Q5 | **Compare 2 players**: only good matches | `WHERE (player_id = 101 OR player_id = 105) AND (runs >= 30 OR wickets >= 2)` |
| Q6 | Every bowler in the squad | `WHERE role = 'Bowler' ORDER BY name` |

## 2-minute talk
1. Run 1_create.sql and 2_insert.sql, then `SELECT * FROM Players;`.
2. Run Q1: 10 performances reached 50 runs. The top one is ID 353, Yasir Khan's 83.
3. **Compare:** ask the teacher to name any 2 players, put their IDs in Q4 and Q5, and run them.
4. Run Q2: the first row is the strongest performance, the last rows are the weakest.
5. **Live change:** run the UPDATE in 4_changes.sql (Rizwan's match 305 goes from 0 to 55), rerun Q1, and show that 305 now appears.
6. Show the DELETE on test row 999 and the duplicate-ID error in 5_checks.sql.

## Likely viva questions
| Question | Answer |
|---|---|
| What is a primary key? | A column that must be unique and not empty, so each row can be found. |
| DDL vs DML? | DDL makes structure (CREATE, ALTER, DROP). DML changes data (INSERT, UPDATE, DELETE, SELECT). |
| Why WHERE in UPDATE and DELETE? | Without it, every row would change or be deleted. |
| Why VARCHAR for name? | Names are text of different lengths. |
| Why DATE for match_date? | So dates can be sorted and compared, e.g. `>= '2026-01-01'`. |
| What does ORDER BY DESC do? | Sorts from highest to lowest. |
| AND vs OR? | AND: both conditions must be true. OR: either one is enough. |
| How do you compare two players? | Put both IDs in Q4 with OR: `player_id = 101 OR player_id = 105`. |
| How did you catch the duplicate ID? | MySQL refused it with a PRIMARY KEY error. |
| Why test rows 900+? | So we never change the real data during checks. |

## Practice before the demo (do it yourself)
1. Change Q1 to `runs >= 30` and rerun it. Count the rows.
2. Change Q4 and Q5 to compare Mohammad Amir (103) and Naseem Shah (102).
3. Write your own query: every match in 2025 (`WHERE match_date < '2026-01-01'`).
