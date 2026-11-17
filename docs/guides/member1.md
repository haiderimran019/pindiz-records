# Member 1: HTML pages
**Your files:** `frontend/index.html`, `players.html`, `entry.html`, `findings.html`, `backend/player.html`, `backend/compare.html`

## What your files do
- Every page has the same 4 parts: `<header>` (title + `<nav>` links), `<main>` (content), `<footer>` (source).
- `<link rel="stylesheet" href="style.css">` connects each page to the shared CSS file.
- Links and images use **relative paths** (`players.html`, `images/101.jpg`), so they still work when the folder is moved.
- **index.html**: a heading, a paragraph, an image `<img>` with `alt` text, and a list `<ul><li>`.
- **players.html**: a *template*. The backend (`app.py`) replaces each `{{...}}` with real content:
  - `{{CARDS}}` → one card per player. Each card is a link `<a class="card" href="player?id=101">` with a photo, name, role and form badge.
  - `{{OPTIONS_1}}`, `{{OPTIONS_2}}` → the player names in the Compare dropdowns.
  - `{{FILTERS}}` → the buttons All, Batter, Bowler … (`players.html?role=Bowler`).
- **backend/player.html**: the profile page a card opens (photo, number tiles, match table, Remove button).
- **entry.html**: two labelled forms, Add a match record and Add a new player, under the booklet's banner. Each `<label for="runs">` is linked to `<input id="runs">`. `min="0"` stops negative numbers. The player form uses `enctype="multipart/form-data"` so a photo can be sent.
- **index.html**: the logo `<img>` with `alt` text, the team performance tiles and table, and links to the pages.
- **findings.html**: number tiles, 3 numbered findings, leaders and data checks.

One player card looks like this:
```html
<a class="card" href="player?id=101">
    <img src="images/101.jpg" alt="Photo of Mohammad Rizwan">
    <h3>Mohammad Rizwan</h3>
    <p>Wicketkeeper</p>
    <span class="badge in-form">In form</span>
</a>
```

## 2-minute talk
1. Open index.html and point out the header, nav, main and footer.
2. Click every nav link to show they all work.
3. On players.html, click a player card to open their profile.
4. Click "Bowler" in the filter.
5. On entry.html, add a player with a photo and show them on the Players page. Explain the banner.

## Likely viva questions
| Question | Answer |
|---|---|
| What is `alt` for? | Text shown if the image fails to load; screen readers read it out. |
| Why relative paths? | So links and images still work when the folder is moved. |
| `<th>` vs `<td>`? | `<th>` is a heading cell, `<td>` is a normal data cell. |
| What does `for` on a label do? | Links the label to the input with the same `id`. |
| How does clicking a player open their profile? | The card is a link to `player?id=101`; the backend builds that player's page. |
| Where do the forms go? | To the backend. Compare uses `method="get"` (choices appear in the address); Add/Remove use `method="post"` because they change data. |
| Why does the Entry Form say data is not saved? | Records go into the website's demo copy, not into our MySQL database. Reset brings the original back. |
| What does `<ul>` mean? | Unordered (bulleted) list. `<ol>` would be numbered. |
| How do you add a player? | Use "Add a new player" on the Entry Form: the backend saves it and the Players page shows it at once. |
| How are pages connected? | The same `<nav>` with 4 `<a href>` links on every page. |

## Practice before the demo (do it yourself)
1. Add the label text "Nationality" instead of "Country" in the Add player form.
2. Rename the "Entry Form" link to "Add Records" on all 4 pages.
3. Undo both changes.
