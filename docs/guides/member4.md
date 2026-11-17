# Member 4: Backend, API and docs
**Your files:** `backend/app.py`, `backend/compare.html`, `api/gemini.py`, everything in `docs/`

## What your files do
**backend/app.py** (a small Flask web server). Each `@app.route(...)` is one web address:
| Route | What it does |
|---|---|
| `/players.html` | Reads the CSV files, works out each player's stats and form badge, fills `frontend/players.html` |
| `/add_player` | Checks the input, gives the next ID, saves the row (and photo as `images/<ID>.jpg`) |
| `/add_match` | Checks runs ≥ 0 and wickets 0–10, saves the new match record |
| `/remove` | Saves the CSV files without that player and their matches |
| `/reset` | Copies `database/original/` back |
| `/compare` | Stats table + winner line, bar chart, Gemini answer, fills `backend/compare.html` |

Form badge rule (`form_of`): average of the last 3 matches vs the matches before; 20% better = In form, 20% worse = Out of form, else Steady.

**api/gemini.py**: the only file that talks to Gemini.
1. Reads the API key from `api/key.txt` (never submitted). If it's missing, it returns a friendly message instead.
2. Joins `INSTRUCTIONS` with both players' records and sends it to Gemini.
3. Returns Gemini's 2 lines: Comparison and Forecast.

**docs/**: the SRS (what the system must do), DDS (how it is designed), algorithms, architecture and rules.

## 2-minute talk
1. Show the architecture diagram: database → CSV → app.py → gemini.py → Gemini → Compare page.
2. Run `python backend/app.py` and open http://127.0.0.1:5000.
3. Compare two players the teacher chooses. Hover a bar, read the Gemini lines.
4. Show the `SETTINGS` blocks: `CHART_HEIGHT` in app.py and `INSTRUCTIONS` in gemini.py.

## Likely viva questions
| Question | Answer |
|---|---|
| What is Flask? | A small Python library for making a web server. |
| What is a route? | A web address the server answers, e.g. `@app.route("/compare")`. |
| How does the form reach Python? | The form sends `?player1=101&player2=105&stat=runs`; `request.args.get("player1")` reads it. |
| Why CSV and not a direct database connection? | Simpler: no database driver needed, and the `csv` module is built into Python. |
| What is an API? | A way for one program to ask another for a service. Here we ask Gemini for a comparison. |
| Where is the API key? | In key.txt, which is not submitted, so nobody else can use it. |
| Can Gemini be wrong? | Yes. The forecast is a guess; the chart and SQL show the real numbers. |
| How is the chart drawn? | Python writes one `<div class="bar">` per match with `style="height: ...px"`. CSS does the rest. |
| How is "In form" decided? | Average of the last 3 matches compared with the earlier ones; 20% better = In form. |
| What if there is no internet? | The 4 pages still work; Compare shows the chart and a note instead of Gemini's answer. |
| What is in the DDS? | Site map, page layout, CSS plan, ER diagram, data dictionary, test plan. |

## Practice before the demo (do it yourself)
1. Change `CHART_HEIGHT = 150` to `250` in app.py, restart it and compare two players.
2. Change `FORM_MATCHES = 3` to `5` and see some badges change.
3. In gemini.py, add "Answer in Urdu." to `INSTRUCTIONS` and compare again.
4. Undo the changes.
