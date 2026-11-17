# Architecture

## 1. The big picture
```
   ESPNcricinfo Statsguru (PSL records)
                │  typed into SQL by hand
                ▼
   ┌──────────────────────────────┐
   │  DATABASE (MySQL)            │
   │  Players, Performances       │
   └──────────────┬───────────────┘
                  │ export as CSV
                  ▼
   ┌──────────────────────────────┐
   │  players.csv                 │
   │  performances.csv            │
   └──────────────┬───────────────┘
                  ▼
   ┌──────────────────────────────┐      ┌──────────────┐      ┌────────┐
   │  BACKEND  backend/app.py     │─────►│ API          │─────►│ Gemini │
   │  (Flask web server)          │◄─────│ gemini.py    │◄─────│ (web)  │
   └──────────────┬───────────────┘      └──────────────┘      └────────┘
                  │ sends the pages + the compare result
                  ▼
   ┌──────────────────────────────────────────┐
   │  FRONTEND  4 HTML pages + style.css      │
   │  Home · Players · Entry Form · Findings  │
   └──────────────────────┬───────────────────┘
                          ▼
                       Browser
```

## 2. The five folders
| Folder | What it does | Language |
|---|---|---|
| `frontend/` | The 4 pages people see, the CSS and the images | HTML, CSS |
| `database/` | Stores all records and runs the queries | SQL (MySQL) |
| `backend/` | Serves the website and builds the Compare page (chart) | Python (Flask) |
| `api/` | The only file that talks to Gemini | Python |
| `docs/` | SRS, design, algorithms, rules, member guides | Markdown |

## 3. What needs the backend?
- **Home and Findings** are plain HTML and CSS. They also open with a double-click.
- **Players**, each **player profile** and the **Entry Form** are filled in by the backend from the CSV files,
  so added or removed players show up at once. Adding, removing, the role filter and the form badges
  all happen in `backend/app.py`.
- **Compare two players** reads the CSV files, builds the stats table and chart, and calls Gemini.
  It is the only part that uses Gemini.
- **Live website (Vercel):** the project folder is read-only there, so the backend copies the data to
  `/tmp` and saves changes there. Changes on the live site reset when the server restarts.
- There is no JavaScript anywhere. Each player card is a link to that player's profile page, the chart bars are `<div>`s
  with an inline height, and the hover labels use CSS `:hover`.

## 4. How a change flows through the system
1. Add or remove players on the Players page: the backend saves the CSV files.
2. Or change a record in MySQL (UPDATE), rerun the query, and export Players and Performances as CSV into `database/`.
3. Reload the Players page or compare again: everything uses the new numbers straight away.
4. "Reset to the original data" copies `database/original/` back.

## 5. What talks to the internet?
Only `api/gemini.py`, and only when someone presses Compare.
