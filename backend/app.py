# app.py - the backend (a small Flask web server).
#
# What it does:
#   1. Shows the website pages from the frontend folder.
#   2. Builds the Players page from the data (database/players.csv and performances.csv),
#      so added or removed players show up straight away.
#   3. Shows one profile page per player (backend/player.html).
#   4. Adds a player, adds a match record, removes a player (saves to the CSV files).
#   5. Compares 2 players: a stats table, a bar chart and Gemini's comparison + forecast.
#
# How to run (from the main pindiz-records folder):
#     pip install -r requirements.txt
#     python backend/app.py
# Then open http://127.0.0.1:5000 in the browser.

import csv
import html
import os
import shutil
import sys
from flask import Flask, request, redirect, send_from_directory

# ===== SETTINGS (change these live) =====
CHART_HEIGHT = 150      # height of the tallest bar in the chart, in pixels
FORM_MATCHES = 3        # "recent form" = the last 3 matches
FORM_CHANGE = 0.2       # 0.2 = 20% better than before counts as "In form"
ROLES = ["Batter", "Bowler", "All-rounder", "Wicketkeeper"]
# ========================================

# ---------- where the files are ----------
HERE = os.path.dirname(os.path.abspath(__file__))
MAIN = os.path.dirname(HERE)
FRONTEND = os.path.join(MAIN, "frontend")
DATABASE = os.path.join(MAIN, "database")
ORIGINAL = os.path.join(DATABASE, "original")       # untouched copy, used by "Reset"

# On the live website (Vercel) the project folder is read-only,
# so the data is copied to /tmp and saved there instead.
if os.environ.get("VERCEL"):
    DATA = "/tmp/pindiz/data"
    PHOTOS = "/tmp/pindiz/images"
    if not os.path.exists(DATA):
        shutil.copytree(ORIGINAL, DATA)
        os.makedirs(PHOTOS)
else:
    DATA = DATABASE
    PHOTOS = os.path.join(FRONTEND, "images")

# Load ask_gemini() from the api folder
sys.path.append(os.path.join(MAIN, "api"))
from gemini import ask_gemini

app = Flask(__name__)


# =====================================================
# 1. Reading and writing the data (CSV files)
# =====================================================
def read_csv(file_name):
    # Returns a list of rows. Each row is a dictionary, e.g. row["runs"]
    with open(os.path.join(DATA, file_name)) as file:
        return list(csv.DictReader(file))


def write_csv(file_name, rows, columns):
    with open(os.path.join(DATA, file_name), "w", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=columns)
        writer.writeheader()
        writer.writerows(rows)


PLAYER_COLUMNS = ["player_id", "name", "role", "country"]
MATCH_COLUMNS = ["performance_id", "player_id", "match_date", "runs", "wickets"]


def by_date(row):
    return row["match_date"]


def matches_of(player_id):
    # All of one player's matches, oldest first
    rows = []
    for row in read_csv("performances.csv"):
        if row["player_id"] == player_id:
            rows.append(row)
    rows.sort(key=by_date)
    return rows


def find_player(player_id):
    for row in read_csv("players.csv"):
        if row["player_id"] == player_id:
            return row
    return None


def next_id(rows, column, start):
    # The biggest ID so far + 1
    biggest = start - 1
    for row in rows:
        if int(row[column]) > biggest:
            biggest = int(row[column])
    return biggest + 1


# =====================================================
# 2. Working out a player's stats and form
# =====================================================
def numbers(rows, stat):
    # The runs (or wickets) as whole numbers, skipping "did not bat / bowl"
    result = []
    for row in rows:
        if row[stat] != "":
            result.append(int(row[stat]))
    return result


def average(values):
    if len(values) == 0:
        return 0
    return round(sum(values) / len(values), 1)


def main_stat(player):
    # Bowlers are judged on wickets, everyone else on runs
    if player["role"] == "Bowler":
        return "wickets"
    return "runs"


def form_of(player, rows):
    # Compare the average of the last 3 matches with the matches before them
    values = numbers(rows, main_stat(player))
    if len(values) <= FORM_MATCHES:
        return "Not enough matches"
    recent = average(values[-FORM_MATCHES:])
    before = average(values[:-FORM_MATCHES])
    if recent > before * (1 + FORM_CHANGE):
        return "In form"
    if recent < before * (1 - FORM_CHANGE):
        return "Out of form"
    return "Steady"


def stats_of(player, rows):
    runs = numbers(rows, "runs")
    wickets = numbers(rows, "wickets")
    return {
        "Matches": len(rows),
        "Runs": sum(runs),
        "Runs per innings": average(runs),
        "Best score": max(runs) if runs else 0,
        "Wickets": sum(wickets),
        "Best wickets": max(wickets) if wickets else 0,
    }


def badge(form):
    # The coloured label next to a player's name (CSS class = form name)
    css = form.lower().replace(" ", "-")
    return '<span class="badge ' + css + '">' + form + '</span>'


# =====================================================
# 3. Small HTML helpers
# =====================================================
def fill(file_path, values):
    # Open a page and replace each {{NAME}} with its value
    with open(file_path) as file:
        page = file.read()
    for name in values:
        page = page.replace("{{" + name + "}}", str(values[name]))
    return page


def player_options(selected):
    options = ""
    for player in read_csv("players.csv"):
        chosen = " selected" if player["player_id"] == selected else ""
        options += ('<option value="' + player["player_id"] + '"' + chosen + '>'
                    + html.escape(player["name"]) + '</option>\n')
    return options


def show(value):
    # An empty cell means the player did not bat or did not bowl
    return value


def message_box():
    # The green note shown after adding or removing (comes in the address: ?message=...)
    message = request.args.get("message", "")
    if message == "":
        return ""
    return '<p class="message">' + html.escape(message) + '</p>'


# =====================================================
# 4. The pages
# =====================================================
@app.route("/")
def home():
    return send_from_directory(FRONTEND, "index.html")


# ---------- Players: a grid of player cards ----------
@app.route("/players.html")
def players_page():
    role = request.args.get("role", "All")          # the filter: All, Batter, Bowler ...

    cards = ""
    count = 0
    for player in read_csv("players.csv"):
        if role != "All" and player["role"] != role:
            continue
        count += 1
        rows = matches_of(player["player_id"])
        name = html.escape(player["name"])
        cards += f"""
            <a class="card" href="player?id={player['player_id']}">
                <img src="images/{player['player_id']}.jpg" alt="Photo of {name}">
                <h3>{name}</h3>
                <p>{player['role']}</p>
                {badge(form_of(player, rows))}
            </a>"""

    # The filter buttons: All, Batter, Bowler ...
    filters = ""
    for choice in ["All"] + ROLES:
        css = ' class="active"' if choice == role else ""
        filters += '<a href="players.html?role=' + choice + '"' + css + '>' + choice + '</a>\n'

    return fill(os.path.join(FRONTEND, "players.html"), {
        "MESSAGE": message_box(),
        "FILTERS": filters,
        "COUNT": count,
        "CARDS": cards,
        "OPTIONS_1": player_options("101"),
        "OPTIONS_2": player_options("105"),
    })


# ---------- One player's profile ----------
@app.route("/player")
def player_page():
    player = find_player(request.args.get("id"))
    if player is None:
        return redirect("players.html?message=That player was not found.")
    rows = matches_of(player["player_id"])
    stats = stats_of(player, rows)

    table = ""
    for row in rows:
        table += ("<tr><td>" + row["performance_id"] + "</td><td>" + row["match_date"]
                  + "</td><td>" + show(row["runs"]) + "</td><td>" + show(row["wickets"]) + "</td></tr>\n")

    return fill(os.path.join(HERE, "player.html"), {
        "ID": player["player_id"],
        "NAME": html.escape(player["name"]),
        "ROLE": player["role"],
        "COUNTRY": html.escape(player["country"]),
        "BADGE": badge(form_of(player, rows)),
        "MATCHES": stats["Matches"],
        "RUNS": stats["Runs"],
        "BEST_SCORE": stats["Best score"],
        "WICKETS": stats["Wickets"],
        "BEST_WICKETS": stats["Best wickets"],
        "TABLE": table,
    })


# ---------- Entry Form page ----------
@app.route("/entry.html")
def entry_page():
    return fill(os.path.join(FRONTEND, "entry.html"), {
        "MESSAGE": message_box(),
        "OPTIONS": player_options(""),
    })


# ---------- add a new player ----------
@app.route("/add_player", methods=["POST"])
def add_player():
    name = request.form.get("name", "").strip()
    role = request.form.get("role", "")
    country = request.form.get("country", "").strip()

    # Check the input (the same rules as rules.md)
    if name == "" or country == "":
        return redirect("entry.html?message=Name and country cannot be empty.")
    if role not in ROLES:
        return redirect("entry.html?message=Pick a role from the list.")

    players = read_csv("players.csv")
    new_id = next_id(players, "player_id", 101)
    # Never reuse an ID that still has an old photo
    while os.path.exists(os.path.join(PHOTOS, str(new_id) + ".jpg")):
        new_id += 1

    players.append({"player_id": new_id, "name": name, "role": role, "country": country})
    write_csv("players.csv", players, PLAYER_COLUMNS)

    # Save the photo as images/<ID>.jpg, if one was chosen
    photo = request.files.get("photo")
    if photo and photo.filename != "":
        photo.save(os.path.join(PHOTOS, str(new_id) + ".jpg"))

    return redirect("entry.html?message=" + name + " was added with ID " + str(new_id) + ".")


# ---------- add a match record ----------
@app.route("/add_match", methods=["POST"])
def add_match():
    player_id = request.form.get("player_id", "")
    date = request.form.get("match_date", "")
    runs = request.form.get("runs", "").strip()
    wickets = request.form.get("wickets", "").strip()

    # Check the input (the same rules as rules.md and 5_checks.sql)
    if find_player(player_id) is None or date == "":
        return redirect("entry.html?message=Pick a player and a date.")
    if runs == "" and wickets == "":
        return redirect("entry.html?message=Enter runs, wickets or both.")
    if runs != "" and int(runs) < 0:
        return redirect("entry.html?message=Runs cannot be negative.")
    if wickets != "" and (int(wickets) < 0 or int(wickets) > 10):
        return redirect("entry.html?message=Wickets must be between 0 and 10.")

    matches = read_csv("performances.csv")
    new_id = next_id(matches, "performance_id", 301)
    matches.append({"performance_id": new_id, "player_id": player_id,
                    "match_date": date, "runs": runs, "wickets": wickets})
    write_csv("performances.csv", matches, MATCH_COLUMNS)
    return redirect("entry.html?message=Match record " + str(new_id) + " was added.")


# ---------- remove a player ----------
@app.route("/remove", methods=["POST"])
def remove_player():
    player_id = request.form.get("player_id", "")

    # Keep every row EXCEPT the ones for this player
    players = []
    for row in read_csv("players.csv"):
        if row["player_id"] != player_id:
            players.append(row)
    matches = []
    for row in read_csv("performances.csv"):
        if row["player_id"] != player_id:
            matches.append(row)
    write_csv("players.csv", players, PLAYER_COLUMNS)
    write_csv("performances.csv", matches, MATCH_COLUMNS)
    return redirect("players.html?message=Player " + player_id + " and their matches were removed.")


# ---------- put the original data back ----------
@app.route("/reset", methods=["POST"])
def reset():
    for file_name in ["players.csv", "performances.csv"]:
        shutil.copy(os.path.join(ORIGINAL, file_name), os.path.join(DATA, file_name))
    return redirect("entry.html?message=The original data is back.")


# ---------- compare 2 players ----------
def make_bar(rows, i, stat, biggest, colour_class):
    # One bar. Its height is set with inline CSS: style="height: ...px"
    if i >= len(rows):
        return '<div class="bar ' + colour_class + '" style="height: 0px"></div>'
    row = rows[i]
    value = row[stat]
    if value == "":
        number = 0
        value = "no"
    else:
        number = int(value)
    height = round(number / biggest * CHART_HEIGHT)
    tip = row["match_date"] + ": " + value + " " + stat
    return ('<div class="bar ' + colour_class + '" style="height: ' + str(height) + 'px">'
            + '<span class="tip">' + tip + '</span></div>')


def make_chart(rows_1, rows_2, stat):
    biggest = 1
    for value in numbers(rows_1, stat) + numbers(rows_2, stat):
        if value > biggest:
            biggest = value
    chart = ""
    for i in range(max(len(rows_1), len(rows_2))):
        chart += '<div class="match">'
        chart += make_bar(rows_1, i, stat, biggest, "bar1")
        chart += make_bar(rows_2, i, stat, biggest, "bar2")
        chart += '<p>' + str(i + 1) + '</p></div>\n'
    return chart


def records_text(player, rows):
    # The player's matches written as text, for Gemini
    text = player["name"] + " (" + player["role"] + "):\n"
    for row in rows:
        runs = row["runs"] if row["runs"] != "" else "did not bat"
        wickets = row["wickets"] if row["wickets"] != "" else "did not bowl"
        text += row["match_date"] + ": runs " + runs + ", wickets " + wickets + "\n"
    return text


@app.route("/compare")
def compare():
    # Step 1: read what the user picked
    player_1 = find_player(request.args.get("player1"))
    player_2 = find_player(request.args.get("player2"))
    stat = request.args.get("stat", "runs")
    if player_1 is None or player_2 is None:
        return redirect("players.html?message=Pick two players to compare.")
    rows_1 = matches_of(player_1["player_id"])
    rows_2 = matches_of(player_2["player_id"])

    # Step 2: the stats table. The better number in each row gets class="better"
    stats_1 = stats_of(player_1, rows_1)
    stats_2 = stats_of(player_2, rows_2)
    table = ""
    wins_1 = 0
    wins_2 = 0
    for name in stats_1:
        a = stats_1[name]
        b = stats_2[name]
        class_a = ""
        class_b = ""
        if name != "Matches" and a > b:
            class_a = ' class="better"'
            wins_1 += 1
        if name != "Matches" and b > a:
            class_b = ' class="better"'
            wins_2 += 1
        table += ("<tr><td>" + name + "</td><td" + class_a + ">" + str(a)
                  + "</td><td" + class_b + ">" + str(b) + "</td></tr>\n")
    table += ("<tr><td>Form</td><td>" + badge(form_of(player_1, rows_1)) + "</td><td>"
              + badge(form_of(player_2, rows_2)) + "</td></tr>\n")

    # Step 3: who is better on the numbers?
    if wins_1 > wins_2:
        winner = player_1["name"] + " is better on " + str(wins_1) + " of 5 stats."
    elif wins_2 > wins_1:
        winner = player_2["name"] + " is better on " + str(wins_2) + " of 5 stats."
    else:
        winner = "Level: both players are better on the same number of stats."

    # Step 4: ask Gemini for a comparison and a forecast
    answer = ask_gemini(records_text(player_1, rows_1), records_text(player_2, rows_2))
    answer_html = ""
    for line in answer.split("\n"):
        if line.strip() != "":
            answer_html += "<p>" + html.escape(line) + "</p>\n"

    # Step 5: fill in the result page
    return fill(os.path.join(HERE, "compare.html"), {
        "NAME_1": html.escape(player_1["name"]),
        "NAME_2": html.escape(player_2["name"]),
        "TABLE": table,
        "WINNER": html.escape(winner),
        "STAT": stat,
        "CHART": make_chart(rows_1, rows_2, stat),
        "GEMINI": answer_html,
    })


# ---------- photos and other files ----------
@app.route("/images/<file_name>")
def photo(file_name):
    # Uploaded photos first (live website), then the normal images folder.
    # A player with no photo gets the default picture.
    for folder in [PHOTOS, os.path.join(FRONTEND, "images")]:
        if os.path.exists(os.path.join(folder, file_name)):
            return send_from_directory(folder, file_name)
    return send_from_directory(os.path.join(FRONTEND, "images"), "default.svg")


@app.route("/<path:file_name>")
def other_files(file_name):
    # index.html, entry.html, findings.html, style.css ...
    return send_from_directory(FRONTEND, file_name)


# Start the server when this file is run with "python backend/app.py"
if __name__ == "__main__":
    app.run(port=5000, debug=True)
