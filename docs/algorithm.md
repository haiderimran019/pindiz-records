# Algorithms

Each algorithm is written as plain steps, then as a simple text flowchart.

---

## A1. Using the website
1. Run `python backend/app.py` and open http://127.0.0.1:5000 (or double-click `frontend/index.html`; everything except Compare works without the backend).
2. Click a link in the navigation bar.
3. The browser opens that page (Home, Players, Entry Form or Findings).
4. Repeat from step 2.

```
[Open the website] → [Click nav link] → [Page opens] → back to "Click nav link"
```

---

## A2. Entry Form (entry.html)
1. User fills in "Add a match record" (player, date, runs, wickets) or "Add a new player" (name, role, country, photo).
2. User presses the button. The backend checks the input (see A10) and saves it in the demo copy of the data.
3. Nothing goes into the MySQL database, so the page carries the booklet's banner "Demonstration only — data is not saved".
4. The team types the same record into MySQL by hand with an INSERT.
5. The same record is shown in a table under the form.

```
[Fill form] → [Submit] → [Nothing saved]
[Team writes INSERT in MySQL] → [Same row shown on entry.html]
```

---

## A3. Find matches that meet the target (Query Q1)
1. Set the target (50 runs).
2. Look at each row in Performances.
3. If runs ≥ target, show the row.
4. Otherwise skip it.
5. Sort the shown rows from highest runs to lowest.

```
[Target = 50] → [Next row] → <runs ≥ 50?> --yes--> [Show row]
                                         --no---> [Skip]
→ [Sort by runs, high to low]
```

---

## A4. Strongest and weakest performances (Query Q2)
1. Take all rows in Performances that have runs.
2. Sort by runs, highest first.
3. First row = strongest performance. Last row = weakest performance.

```
[All matches] → [Sort high → low] → [Top row = strongest] / [Bottom row = weakest]
```

---

## A5. Data quality check (5_checks.sql)
1. Add 3 test rows with mistakes (IDs 900+).
2. Run a query to find each mistake:
   - missing value → `IS NULL`
   - duplicate ID → MySQL shows a PRIMARY KEY error
   - impossible number → `wickets < 0`
3. Fix it (UPDATE) or remove it (DELETE).
4. Run the query again: no rows should come back.

```
[Add test rows] → [Run check query] → <found a problem?> --yes--> [UPDATE or DELETE] → [Check again]
                                                        --no---> [Data is clean]
```

---

## A6. Comparing any two players with SQL (Q4 and Q5)
1. Pick two player IDs from the Players page (for example 101 and 105).
2. Put both IDs into Q4: `WHERE player_id = 101 OR player_id = 105`.
3. Run Q4: both players' last 10 matches appear, grouped by player.
4. Put the same IDs into Q5 and run it: only their good matches appear (30+ runs or 2+ wickets).

```
[Pick 2 IDs] → [Edit Q4 and Q5] → [Run Q4: last 10 matches] → [Run Q5: good matches]
```

---

## A7. Open a player's profile (players.html → player page)
1. Each player card is a link: `player?id=101`.
2. The backend finds player 101 and their matches in the CSV files.
3. It works out the totals and form badge and fills in `backend/player.html`.
4. The browser shows the profile page.

```
[Click card] → [player?id=101] → [Find player + matches] → [Fill player.html] → [Profile page]
```

---

## A8. Compare two players (backend/app.py + api/gemini.py)
1. On players.html, the user picks Player 1, Player 2 and "Runs" or "Wickets", then presses Compare.
2. The form sends the choices to the backend: `/compare?player1=101&player2=105&stat=runs`.
3. app.py reads players.csv and performances.csv and keeps the two players' matches.
4. app.py builds the stats table (matches, runs, runs per innings, best score, wickets, best wickets),
   highlights the better number in each row and counts who wins more rows.
   Then it builds the bar chart: for each match, one bar per player.
   Bar height = value ÷ biggest value × 150 px (inline CSS `style="height: ...px"`).
5. app.py sends both players' records to `ask_gemini()` in api/gemini.py.
6. Gemini replies with 2 lines: Comparison and Forecast.
7. app.py puts the names, table, chart and answer into backend/compare.html and sends the page back.
8. Hovering over a bar shows its match and value (CSS `:hover`).

```
[Pick 2 players + Compare] → [app.py reads CSV] → [Build bars] → [ask_gemini()]
→ [Fill compare.html] → [Browser shows chart + Gemini text]
```

---

## A9. Form badge (In form / Steady / Out of form)
1. Pick the player's main number: wickets for bowlers, runs for everyone else.
2. If the player has 3 matches or fewer → "Not enough matches".
3. recent = average of the last 3 matches; before = average of the matches before them.
4. If recent is more than 20% above before → "In form".
5. If recent is more than 20% below before → "Out of form".
6. Otherwise → "Steady".

```
[Main number] → <more than 3 matches?> --no--> [Not enough matches]
   --yes--> [recent vs before] → <+20%?> [In form] / <−20%?> [Out of form] / [Steady]
```

---

## A10. Add a player / add a match / remove a player (backend/app.py)
**Add a player**
1. Check: name and country are not empty, role is one of the four.
2. New ID = biggest ID + 1.
3. Add the row to players.csv. If a photo was chosen, save it as `images/<ID>.jpg`.
4. Go back to the Players page with a message.

**Add a match record**
1. Check: player exists, date is filled, runs ≥ 0, wickets 0–10, not both empty.
2. New record ID = biggest record ID + 1.
3. Add the row to performances.csv and go back with a message.

**Remove a player**
1. Keep every row in players.csv and performances.csv except that player's.
2. Save both files and go back with a message.

**Reset** copies the untouched files from `database/original/` back.

```
[Form sent] → <input OK?> --no--> [Message: what is wrong]
              --yes--> [New ID] → [Save CSV] → [Message: done]
```
