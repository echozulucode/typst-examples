// =============================================================
// 07-styling.typ — Set Rules, Show Rules, and Fonts
// =============================================================
// What you'll learn:
//   - Set rules (#set text(), #set par(), #set heading(), ...)
//   - Show rules (#show heading: ...)
//   - Custom heading styles
//   - Colored text and highlighting
//   - Horizontal rules with #line()
// Ref: https://typst.app/docs/reference/styling/
// =============================================================

// ---- Set rules ----
// `#set` configures default properties for an element type.
// All instances of that element in the document inherit
// these defaults (unless overridden locally).

// Set the base font for all text.
#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "en",
)

// Justify paragraphs and add spacing between them.
#set par(
  justify: true,
  leading: 0.65em,
)

// Add vertical space above headings.
#set heading(numbering: "1.1")

// ---- Show rules ----
// `#show` lets you intercept and restyle specific elements.
// The pattern is:  #show selector: transformation

// Style level-1 headings: large, colored, with a line below.
#show heading.where(level: 1): it => {
  set text(16pt, weight: "bold", fill: rgb("#1a56db"))
  v(12pt)
  it.body
  v(4pt)
  line(length: 100%, stroke: 1.5pt + rgb("#1a56db"))
  v(8pt)
}

// Style level-2 headings: medium, dark gray.
#show heading.where(level: 2): it => {
  set text(13pt, weight: "bold", fill: luma(60))
  v(10pt)
  it.body
  v(4pt)
}

// Style level-3 headings: italic, smaller.
#show heading.where(level: 3): it => {
  set text(11pt, weight: "bold", style: "italic", fill: luma(80))
  v(8pt)
  it.body
  v(3pt)
}

// Make all raw/code text slightly smaller and colored.
#show raw: set text(9pt, fill: rgb("#c7254e"))

// Style inline code with a background box.
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

// Style code blocks with a background and padding.
#show raw.where(block: true): block.with(
  fill: luma(245),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)

// ---- Document starts here ----

= Acme Widget API

== Overview

The *Acme Widget API* lets you create, read, update, and
delete widgets programmatically. This document demonstrates
Typst's styling capabilities using realistic API documentation.

=== Quick Example

```python
import acme
client = acme.Client(api_key="sk-xxxx")
widgets = client.widgets.list(status="active")
```

// ---- Colored text ----
// Use `#text(fill: color)[...]` to color specific text.

== Status Indicators

Each widget has a status:

- #text(fill: rgb("#16a34a"))[*active*] — the widget is live and responding.
- #text(fill: rgb("#ca8a04"))[*paused*] — the widget is temporarily disabled.
- #text(fill: rgb("#dc2626"))[*error*] — the widget encountered a failure.
- #text(fill: luma(140))[*archived*] — the widget is no longer in use.

// ---- Highlight ----
// Use `#highlight()` to add a background highlight to text.

== Important Notes

#highlight(fill: rgb("#fef08a"))[API keys must be rotated every 90 days.]
Failure to rotate keys will result in automatic revocation.

You can also highlight with different colors:
#highlight(fill: rgb("#bbf7d0"))[Green for success notes] and
#highlight(fill: rgb("#fecaca"))[red for warnings].

// ---- Horizontal rules ----
// Use `#line()` to draw a horizontal rule. Control width,
// stroke weight, and color.

#line(length: 100%, stroke: 0.5pt + luma(200))

== Authentication

All requests require a valid API key passed in the
`Authorization` header:

```
Authorization: Bearer sk-xxxx-your-key-here
```

The key determines your project scope, rate limits, and
permissions. Never expose keys in client-side code.

#line(length: 100%, stroke: (paint: rgb("#1a56db"), thickness: 1pt, dash: "dashed"))

== Rate Limits

The API enforces per-key rate limits:

#table(
  columns: (1fr, auto, auto),
  inset: 8pt,
  fill: (x, y) => if y == 0 { rgb("#1a56db").lighten(85%) },
  [*Tier*], [*Limit*], [*Burst*],
  [Free],       [60 req/min],    [10],
  [Starter],    [600 req/min],   [50],
  [Pro],        [6,000 req/min], [200],
  [Enterprise], [Custom],        [Custom],
)

== Changelog

=== v2.1.0

- Added webhook support for real-time notifications.
- Improved `PATCH` endpoint to accept partial updates.
- Fixed pagination bug when `per_page` exceeds 100.

=== v2.0.0

- Breaking: renamed `/gadgets` to `/widgets`.
- Added `status` filter to `GET /widgets`.
- New `DELETE /widgets/{id}` endpoint.
