# gemini.py - the ONLY file that talks to Gemini.
#
# backend/app.py calls ask_gemini() when someone compares 2 players.
# Gemini gets both players' recent matches and sends back:
#   - a short comparison of their form
#   - a forecast for each player's next match
#
# Your API key goes in api/key.txt (one line). Do NOT submit key.txt.
# On the live website the key is stored as the setting GEMINI_API_KEY instead.

import os
from google import genai

# ===== SETTINGS (change these live) =====
MODEL = "gemini-3.8-flash"
BACKUP_MODEL = "gemini-3.5-flash"      # used if the main model is busy
WAIT_SECONDS = 25                      # stop waiting for Gemini after this long
INSTRUCTIONS = (
    "You are a cricket analyst. Use ONLY the PSL match records below (oldest first).\n"
    "Reply in exactly 2 short lines and nothing else:\n"
    "Comparison: <2 sentences comparing their recent form, quoting numbers>\n"
    "Forecast: <expected runs or wickets for EACH player in their next match, as a range>"
)
# ========================================

HERE = os.path.dirname(os.path.abspath(__file__))
KEY_FILE = os.path.join(HERE, "key.txt")


def ask_gemini(records_1, records_2):
    # Step 1 + 2: get the key (live website setting first, then key.txt)
    key = os.environ.get("GEMINI_API_KEY", "")
    if key == "" and os.path.exists(KEY_FILE):
        with open(KEY_FILE) as file:
            key = file.read().strip()
    if key == "":
        return "Gemini is not set up yet. Put your API key in api/key.txt."

    # Step 3: build the question: instructions + both players' records
    prompt = INSTRUCTIONS + "\n\n" + records_1 + "\n" + records_2

    # Step 4: send it to Gemini and return the answer text.
    # If the main model is busy, try the backup model once.
    # the timeout is in milliseconds, so seconds x 1000
    client = genai.Client(api_key=key, http_options={"timeout": WAIT_SECONDS * 1000})
    for model in [MODEL, BACKUP_MODEL]:
        try:
            response = client.models.generate_content(model=model, contents=prompt)
            return response.text.strip()
        except Exception:
            pass

    return "Gemini is busy right now. Press Compare again in a moment."
