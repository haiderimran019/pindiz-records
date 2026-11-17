# Member 2: CSS and design
**Your files:** `frontend/style.css`, the `<style>` block in `findings.html`, the `style=""` banner in `entry.html`

## What your files do
- **External CSS** (`style.css`): one file shared by every page. It is split into 8 numbered sections:
  1 whole page, 2 header and nav, 3 main and boxes, 4 player rows, 5 tables, 6 forms, 7 bar chart, 8 footer.
- **Internal CSS** (`<style>` in findings.html): the `.highlight` class colours one finding row. Only this page needs it.
- **Inline CSS** (`style="..."`): the red banner in entry.html, and each chart bar's height on the Compare page.
- The colour list at the top of `style.css` keeps the design consistent.

Key rules to know:
| Rule | What it does |
|---|---|
| `header { background-color: #191e24 }` | Navy header bar |
| `border-bottom: 4px solid #ff4400` | Orange line under the header |
| `.box` | White box with a thin border and round corners |
| `summary img { border-radius: 50% }` | Round player photos |
| `nav a:hover` | Link turns orange when the mouse is over it |
| `table { border-collapse: collapse }` | Single thin lines between cells |
| `.chart { display: flex; align-items: flex-end }` | Puts the bars side by side, standing on the bottom line |
| `.bar1` / `.bar2` | Orange bars for player 1, teal for player 2 |
| `.tip { display: none }` + `.bar:hover .tip { display: block }` | The hover label on each bar |
| `.badge`, `.in-form`, `.out-of-form` | The round form labels (green, grey, red) next to each name |
| `.better` | Green cell for the better number on the Compare page |

## 2-minute talk
1. Show the colour list at the top of style.css.
2. Explain the 3 CSS types and why each is used where it is.
3. Change `#ff4400` and show every page change.
4. On the Compare page, hover a bar and explain the `:hover` rule.

## Likely viva questions
| Question | Answer |
|---|---|
| Name the 3 types of CSS. | External (separate file), internal (`<style>` in the page), inline (`style=""` on one tag). |
| Which wins if they clash? | Inline, then internal, then external. |
| Why mostly external? | One file controls every page, so it's consistent and easy to change. |
| What is a class? | A name like `.box` you can give to many elements. |
| Padding vs margin? | Padding is space inside the border; margin is space outside it. |
| What does `#ff4400` mean? | A hex colour code (red, green, blue). It's Pindiz orange. |
| How is the chart made without images? | Each bar is a `<div>`; its height is set with inline CSS, flexbox puts them in a row. |
| What is `:hover`? | Style applied when the mouse is over the element. |
| What does `display: none` do? | Hides the element completely. |
| Does it work on a phone? | Yes: `max-width` on main and the viewport meta tag. |

## Practice before the demo (do it yourself)
1. Change the orange `#ff4400` to another colour and refresh.
2. Change `.bar2` to a different colour and compare two players.
3. Undo both changes.
