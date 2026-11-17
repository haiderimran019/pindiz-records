# Member 1: HTML pages
**Your files:** `frontend/index.html`, `players.html`, `entry.html`, `findings.html`

## What your files do
- Every page has the same 4 parts: `<header>` (title + `<nav>` links), `<main>` (content), `<footer>` (source).
- `<link rel="stylesheet" href="style.css">` connects each page to the shared CSS file.
- Links and images use **relative paths** (`players.html`, `images/101.jpg`), so they still work when the folder is moved.
- **index.html**: a heading, a paragraph, an image `<img>` with `alt` text, and a list `<ul><li>`.
- **players.html**: a *template*. The backend (`app.py`) replaces each `{{...}}` with real content:
  - `{{PLAYERS}}` → one `<details>` block per player. The `<summary>` line (photo, name, role, form badge) is always shown; clicking it opens their totals, a `<table>` of matches and a Remove button. No JavaScript: the browser opens and closes `<details>` by itself.
  - `{{OPTIONS_1}}` … → the player names in each dropdown `<select>`.
  - `{{FILTERS}}` → the links All | Batter | Bowler | … (`players.html?role=Bowler`).
  - The "Compare two players" form, and the "Manage players" forms: Add a new player (`enctype="multipart/form-data"` so a photo can be sent) and Add a match record. They use `method="post"` because they change data.
- **entry.html**: the booklet's labelled demonstration form for a match record. Each `<label for="runs">` is linked to `<input id="runs">`. `min="0"` stops negative numbers.
- **findings.html**: the findings table, leaders, data checks and the limitation.

One player block looks like this:
```html
<details>
    <summary>
        <img src="images/101.jpg" alt="Photo of Mohammad Rizwan">
        Mohammad Rizwan <span class="role">· Wicketkeeper · Pakistan</span>
    </summary>
    <div class="stats">
        ...totals and the table of matches...
    </div>
</details>
```

## 2-minute talk
1. Open index.html and point out the header, nav, main and footer.
2. Click every nav link to show they all work.
3. On players.html, click a player to open their records, then close it.
4. Click "Bowler" in the filter. Then add a player with a photo under "Manage players".
5. On entry.html, explain each field and the "Demonstration only" banner.

## Likely viva questions
| Question | Answer |
|---|---|
| What is `alt` for? | Text shown if the image fails to load; screen readers read it out. |
| Why relative paths? | So links and images still work when the folder is moved. |
| `<th>` vs `<td>`? | `<th>` is a heading cell, `<td>` is a normal data cell. |
| What does `for` on a label do? | Links the label to the input with the same `id`. |
| How does clicking a player open it? | `<details>` and `<summary>` are HTML tags that open and close by themselves. |
| Where do the forms go? | To the backend. Compare uses `method="get"` (choices appear in the address); Add/Remove use `method="post"` because they change data. |
| Does entry.html save anything? | No. It is the booklet's demonstration form. Saving is done under "Manage players". |
| What does `<ul>` mean? | Unordered (bulleted) list. `<ol>` would be numbered. |
| How do you add a player? | Use "Add a new player" on the Players page: the backend saves it and the page shows it at once. |
| How are pages connected? | The same `<nav>` with 4 `<a href>` links on every page. |

## Practice before the demo (do it yourself)
1. Add the label text "Nationality" instead of "Country" in the Add player form.
2. Rename the "Entry Form" link to "Add Records" on all 4 pages.
3. Undo both changes.
