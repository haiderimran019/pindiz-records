# Design Document (DDS)
**Project:** Pindiz Player Records

---

## 1. Site map
```
                 index.html (Home)
          ┌──────────┼──────────┐
   players.html  entry.html  findings.html
        │
        └── Compare form ──► backend/app.py ──► compare result page
```
Every page has the same navigation bar, so any page can be reached from any other page.

---

## 2. Page layout (same on every page)
```
┌───────────────────────────────────────┐
│ HEADER  Pindiz Records                │
│ NAV     Home | Players | Entry Form | │
│         Findings                      │
├───────────────────────────────────────┤
│ MAIN    white boxes with headings,    │
│         text, tables and forms        │
├───────────────────────────────────────┤
│ FOOTER  data source                   │
└───────────────────────────────────────┘
```

| Page | Main content |
|---|---|
| index.html | Badge image, short description, list of pages |
| players.html (built by the backend) | Compare form; role filter; one row per player (photo, name, role, form badge) that opens their totals, match table and Remove button; "Manage players" forms (add player, add match record); Reset button |
| entry.html | "Demonstration only" banner, the match entry form, sample record |
| findings.html | 3 SQL findings, leaders table, data checks, limitation |
| compare page (from the backend) | Stats table (better number highlighted, winner line), bar chart (hover for details), Gemini's comparison and forecast |

---

## 3. CSS plan (3 types, as the booklet asks)
| Type | Where | What it does | Why |
|---|---|---|---|
| External | `frontend/style.css` | All shared styling: header, nav, boxes, player rows, tables, forms, chart | One change updates every page |
| Internal | `<style>` in `findings.html` | Highlights one finding row | Only that page needs it |
| Inline | `style=""` on the banner in `entry.html`, and on each chart bar | Red warning; the height of each bar | One-off values |

**Colours:** navy `#191e24` (header, footer), orange `#ff4400` (accent, player 1), teal `#1fd1b2` (player 2), lime `#b6f83f` (logo "z"), light grey page, white boxes.

---

## 4. Database design

### 4.1 ER diagram
```
 ┌───────────┐ 1        many ┌──────────────┐
 │  Players  │───────────────│ Performances │
 │ player_id │               │ player_id    │
 └───────────┘               └──────────────┘
```
One player has many Performances rows (one per match). They are linked by `player_id`.

### 4.2 Data dictionary

**Players**
| Field | Type | Meaning | Rule |
|---|---|---|---|
| player_id | INT | Our number for the player | Primary key, starts at 101 |
| name | VARCHAR(50) | Full name | Not empty |
| role | VARCHAR(20) | Batter / Bowler / All-rounder / Wicketkeeper | One of the four |
| country | VARCHAR(20) | The player's country | |

**Performances**
| Field | Type | Meaning | Rule |
|---|---|---|---|
| performance_id | INT | Row number | Primary key, starts at 301 |
| player_id | INT | Which player | Must exist in Players |
| match_date | DATE | Day of the match | YYYY-MM-DD |
| runs | INT | Runs scored (the brief's "points") | ≥ 0, empty = did not bat |
| wickets | INT | Wickets taken | 0–10, empty = did not bowl |

---

## 5. Test plan
| # | Test | Expected result |
|---|---|---|
| T1 | Click every nav link on every page | Correct page opens |
| T2 | Move the folder, open index.html | All links and images still work |
| T2b | Click a player row on players.html | Their records open; click again to close |
| T3 | Run 1_create.sql to 5_checks.sql in order | No errors (except the planned duplicate-ID error) |
| T4 | Run Q1 (runs ≥ 50) | Only matches of 50 or more |
| T5 | Run Q2 | Matches sorted highest to lowest |
| T6 | UPDATE match 305, rerun Q1 | 305 now appears |
| T7 | Compare the Players page with `SELECT * FROM Players` | Same players and values |
| T8 | Run backend/app.py, pick 2 players, press Compare | Chart shows both players; hovering a bar shows the match |
| T9 | Same, with a key in api/key.txt | Gemini comparison and forecast appear under the chart |
| T9b | Add a player with a photo, then add a match for them | They appear with their photo and the new record |
| T9c | Add a match with 12 wickets | Refused: "Wickets must be between 0 and 10" |
| T9d | Remove a player, then press Reset | The player disappears, then comes back |
| T9e | Click "Bowler" in the filter | Only bowlers are shown |
| T10 | Paste each page into validator.w3.org | No errors |
