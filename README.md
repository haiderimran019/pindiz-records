# Pindiz Player Records

A simple record dashboard for the **Pindiz** PSL squad: player profiles, recent match stats, a form badge for every player, and a two-player comparison with a chart and a Gemini forecast.

**Live website:** https://pindiz-records.vercel.app

CS181L Application of ICT Lab · BSDS 08 Sports Performance Records
Air University, Aerospace and Aviation Campus Kamra · Instructor: Moqadus Batool

---

## Features
| Feature | Where | How it works |
|---|---|---|
| Player profiles | Players | One row per player (photo, name, role, country). Click a row to open their stats and match table. |
| Form badge | Players | **In form / Steady / Out of form**: the average of the last 3 matches compared with the matches before (runs for batters, wickets for bowlers). |
| Role filter | Players | Show All, Batters, Bowlers, All-rounders or Wicketkeepers. |
| Add / remove players | Players → Manage players | Add a player with a photo, add a match record, remove a player. Input is checked (runs ≥ 0, wickets 0–10). |
| Compare two players | Players → Compare | A side-by-side stats table (better number highlighted), a bar chart (hover a bar for the match) and Gemini's comparison and forecast. |
| Findings | Findings | 3 findings from our SQL queries, leaders, data checks and a limitation. |
| Booklet demo form | Entry Form | The labelled form marked "Demonstration only — data is not saved". |

No JavaScript is used. Player rows open with the HTML `<details>` tag, chart bars are `<div>`s with an inline height, and hover labels use CSS `:hover`.

---

## Project structure
```
pindiz-records/
├── frontend/              what the user sees (HTML + CSS)
│   ├── index.html         Home
│   ├── players.html       Players page template (the backend fills in the {{...}} parts)
│   ├── entry.html         Booklet demo form
│   ├── findings.html      Findings
│   ├── style.css          the one stylesheet (8 numbered sections)
│   └── images/            player photos, named by player ID (101.jpg …)
├── backend/
│   ├── app.py             Flask server: pages, add/remove, form badge, compare
│   └── compare.html       Compare result page template
├── api/
│   └── gemini.py          the only file that talks to Gemini
├── database/
│   ├── 1_create.sql … 5_checks.sql   MySQL scripts (run in order)
│   ├── players.csv, performances.csv  the data the website uses
│   └── original/          untouched copy, used by "Reset to the original data"
├── docs/                  SRS, DDS, algorithms, architecture, rules, member guides
├── requirements.txt       Python libraries
└── vercel.json            settings for the live website
```

### How the parts connect
```
MySQL scripts ──export──► CSV files ◄──read / save──► backend/app.py ──► api/gemini.py ──► Gemini
                                                          │
                                                          ▼
                                            frontend pages in the browser
```

---

## Run it on your computer
```
pip install -r requirements.txt
python backend/app.py
```
Open **http://127.0.0.1:5000** (on a Mac use `127.0.0.1`, not `localhost`: port 5000 on `localhost` is taken by AirPlay).

**Gemini (optional):** create `api/key.txt` with your Gemini API key on one line. It is listed in `.gitignore`, so it is never uploaded. Without a key, Compare still shows the stats table and chart, plus a note that Gemini is not set up.

## The database (MySQL)
Run these in MySQL Workbench or XAMPP phpMyAdmin, in order, on a fresh database:
1. `1_create.sql`: the database `pak_cricket` and 2 tables, **Players** and **Performances**
2. `2_insert.sql`: 19 players and 129 match records
3. `3_queries.sql`: six SELECT queries (Q1 target, Q2 strongest to weakest, Q3–Q5 with AND/OR, Q6 bowlers)
4. `4_changes.sql`: UPDATE, ALTER TABLE and DELETE, each with a SELECT before and after
5. `5_checks.sql`: missing value, duplicate ID (fails on purpose) and impossible value, all on test rows 900+

| Table | Columns |
|---|---|
| Players | player_id (PK), name, role, country |
| Performances | performance_id (PK), player_id, match_date, runs (NULL = did not bat), wickets (NULL = did not bowl) |

## The live website
Hosted on Vercel from this repository (`vercel.json` sends every request to `backend/app.py`).
- The live server can't change its own files, so added or removed players are saved in temporary storage. They **reset** when the server restarts. Use "Reset to the original data" to start clean.
- To turn on Gemini online, add the key as an environment variable:
  `vercel env add GEMINI_API_KEY production`, then redeploy with `vercel deploy --prod`.

---

## Live-change cheat sheet (for the presentation)
| Teacher asks | Change | File |
|---|---|---|
| Use 30 instead of 50 as the target | `runs >= 50` → `30` | database/3_queries.sql (Q1) |
| Sort weakest first | `DESC` → `ASC` | database/3_queries.sql (Q2) |
| Change the theme colour | `#ff4400` | frontend/style.css |
| Change the chart colours | `.bar1` / `.bar2` | frontend/style.css |
| Make the chart taller | `CHART_HEIGHT = 150` | backend/app.py |
| "Form" should use the last 5 matches | `FORM_MATCHES = 3` → `5` | backend/app.py |
| Make "In form" stricter | `FORM_CHANGE = 0.2` → `0.3` | backend/app.py |
| Change what Gemini is asked | `INSTRUCTIONS` | api/gemini.py |
| Add a player | "Add a new player" form | Players page |
| Rename a nav link | link text in `<nav>` | every HTML page + backend/compare.html |

## Team
| Name | Registration no. | Part | Guide |
|---|---|---|---|
| (Member 1) | (reg no.) | HTML pages | [member1.md](docs/guides/member1.md) |
| (Member 2) | (reg no.) | CSS and design | [member2.md](docs/guides/member2.md) |
| (Member 3) | (reg no.) | Database (SQL) | [member3.md](docs/guides/member3.md) |
| (Member 4) | (reg no.) | Backend, API and docs | [member4.md](docs/guides/member4.md) |

## Sources
- Match records: ESPNcricinfo Statsguru, https://stats.espncricinfo.com (collected November 2026). Each player's 10 most recent PSL matches from the last 2 years; players with fewer show all they have.
- Squad and player photos: the official Pindiz team page, https://thepindiz.com (November 2026).
- Team colours: https://thepindiz.com and Instagram @thepindiz.
- Roles were set by the team. The badge image was made by the team.
- This is a student project, not an official Pindiz website.

## Use of AI tools
(Write here how your team used AI tools, if your instructor or university asks you to say so.
The comparison and forecast on the Compare page are generated by Gemini and labelled on the page.)
