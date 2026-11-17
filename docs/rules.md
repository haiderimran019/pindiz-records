# Project Rules

## 1. Who owns what
| Member | Part | Files |
|---|---|---|
| Member 1 | HTML pages | frontend/*.html |
| Member 2 | CSS and design | frontend/style.css (+ internal and inline examples) |
| Member 3 | Database | database/*.sql |
| Member 4 | Backend, API, docs | backend/app.py, backend/compare.html, api/gemini.py, docs/ |

Everyone must be able to explain their own part and make one small change live.

## 2. Naming rules
- File names are lowercase, no spaces: `players.html`, `1_create.sql`
- SQL scripts are numbered in the order they must run: 1 → 5
- Player IDs start at **101**
- Performance IDs start at **301**
- Test rows (fake rows for checks) use IDs **900 and above** and have the comment `-- TEST ROW`
- Player photos are named by player ID: `101.jpg` (a player with no photo gets `default.svg`)

## 3. Data rules
| Field | Rule |
|---|---|
| player_id | must be unique, never empty |
| name | never empty |
| role | one of: Batter, Bowler, All-rounder, Wicketkeeper |
| match_date | a real date, written YYYY-MM-DD |
| runs | 0 or more (empty = did not bat) |
| wickets | 0 to 10 in one T20 match (empty = did not bowl) |

Any row that breaks a rule is found with a query in `5_checks.sql` and fixed.
The backend checks the same rules before it saves a new player or match record.

## 4. Coding rules
- One comment above every block saying what it does, in plain English
- Values a teacher may ask to change are marked `-- CHANGE ME` (SQL) or kept in the `SETTINGS` block (Python)
- Same header, nav and footer on every page
- No JavaScript on the website
- Gemini is used in one place only: the Compare feature on the Players page
