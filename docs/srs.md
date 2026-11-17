# Software Requirements Specification (SRS)
**Project:** Pindiz Player Records
**Course:** CS181L Application of ICT Lab, BSDS 08 Sports Performance Records

---

## 1. Introduction

### 1.1 Purpose
Pindiz is a PSL club. This system helps the club compare its players' recent results:
it stores each player's last 10 PSL matches, shows them on a simple website, and compares any two players.

### 1.2 Goal
*See which Pindiz players are in the best form, and compare any two players.*

### 1.3 Scope
- The 19 players on the official Pindiz team page who have PSL matches in the last 2 years
- Each player's last 10 PSL matches: date, runs, wickets
- A 4-page website, a MySQL database, a small Python backend and a Gemini compare feature

### 1.4 Users
| User | What they want |
|---|---|
| Coach | See who is in form before picking the team |
| Analyst | Run SQL queries and compare two players |
| Fan / teacher | Browse player profiles and findings |

---

## 2. Functional requirements
| ID | The system shall… |
|---|---|
| FR1 | Show every player in a row with photo, name, role, country and a form badge (In form / Steady / Out of form) |
| FR2 | Open a player's totals and match table when their row is clicked |
| FR3 | Show the booklet's match entry form (demonstration only, data is not saved) |
| FR3b | Let the user add a new player (with photo), add a match record and remove a player (saved by the backend) |
| FR3c | Check new records: runs 0 or more, wickets 0–10, name and date not empty |
| FR3d | Filter the players by role (All, Batter, Bowler, All-rounder, Wicketkeeper) |
| FR4 | Find matches where a player met a runs target (SQL query Q1) |
| FR5 | Sort performances from strongest to weakest (SQL query Q2) |
| FR6 | Let the user pick any two players and compare them (Compare form; SQL queries Q4 and Q5) |
| FR7 | Show a side-by-side stats table (better number highlighted) and a bar chart of the two players' matches, with details on hover |
| FR8 | Use Gemini to compare the two players' form and forecast their next match (Compare page only) |
| FR9 | Let the team update, delete and change records using SQL |

---

## 3. Non-functional requirements
| ID | Requirement |
|---|---|
| NFR1 | Minimal and easy to read: clear headings, white boxes, consistent Pindiz colours |
| NFR2 | Same layout on every page (header, nav, footer) |
| NFR3 | The 4 pages open without internet; only Compare needs the backend and internet |
| NFR4 | Links and images keep working when the folder is moved (relative paths) |
| NFR5 | Code is simple enough for a first-semester student to read and change live |
| NFR6 | All data sources are credited, with the date the data was collected |

---

## 4. Constraints
- The pages use **HTML and CSS only**: no JavaScript.
- The website is **not connected** to MySQL. The backend reads and saves the CSV files exported from MySQL.
- The booklet's entry form (entry.html) does **not** save anything. Players are added and removed under "Manage players" on the Players page.
- Python is used only for the backend (`backend/app.py`) and the Gemini call (`api/gemini.py`).
- The Gemini API key is kept in `api/key.txt` and is not submitted.

---

## 5. Assumptions and limitations
- Data is correct on the date it was collected.
- Ten matches is a small sample: it shows recent form, not true ability.
- Some players have played fewer than 10 PSL matches, so their numbers are less reliable.
- Gemini's comparison and forecast are AI predictions; the chart and SQL results show the real numbers.
