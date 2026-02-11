// =============================================================
// 11-cheatsheet-template.typ — Professional Cheatsheet Template
// =============================================================
// A template for creating high-density, single-page reference
// sheets. Optimized for quick scanning and attractiveness.
//
// What you'll learn:
//   - High-density layout with #grid() and #stack()
//   - Custom category boxes with headers
//   - Mono-styled command blocks
//   - Space-saving typography settings
// =============================================================

#let cheatsheet-template(
  title: "Cheatsheet Title",
  subtitle: "Reference Guide",
  accent-color: rgb("#d32f2f"), // Default to a bold red
  body,
) = {

  // ---- Page setup ----
  set page(
    paper: "a4",
    margin: (x: 1cm, y: 1cm),
    footer: context {
      set text(7pt, fill: luma(150))
      grid(
        columns: (1fr, 1fr),
        [Acme Widget Platform — Internal Developer Reference],
        align(right, [Last Updated: #datetime.today().display("[month repr:long] [year]")]),
      )
    }
  )

  // ---- Typography ----
  set text(font: "New Computer Modern", size: 9pt)
  set par(justify: false, leading: 0.4em)

  // ---- Header ----
  block(width: 100%, inset: (bottom: 10pt), {
    grid(
      columns: (1fr, auto),
      align(left + bottom)[
        #text(22pt, weight: "bold", fill: accent-color)[#upper(title)] 
        #text(11pt, weight: "medium", fill: luma(100))[#subtitle]
      ],
      align(right + bottom)[
        #box(
          stroke: 1pt + accent-color,
          inset: 5pt,
          radius: 2pt,
          text(accent-color, weight: "bold", size: 12pt)[ACME]
        )
      ]
    )
    v(-4pt)
    line(length: 100%, stroke: 2pt + accent-color)
  })

  // ---- Content Grid ----
  // We use a 3-column grid for the main content
  columns(3, gutter: 8pt)[
    #body
  ]
}

// ---- Category Block ----
#let category(title, accent-color: rgb("#d32f2f"), content) = {
  block(
    width: 100%,
    breakable: false,
    inset: (top: 0pt, bottom: 8pt),
    stack(spacing: 0pt,
      // Category Header
      block(
        fill: accent-color,
        width: 100%,
        inset: 4pt,
        radius: (top: 3pt, bottom: 0pt),
        text(white, weight: "bold", size: 9pt)[#upper(title)]
      ),
      // Category Body
      block(
        width: 100%,
        fill: accent-color.lighten(95%),
        stroke: (
          left: 1pt + accent-color.lighten(60%),
          right: 1pt + accent-color.lighten(60%),
          bottom: 1pt + accent-color.lighten(60%),
        ),
        inset: 6pt,
        radius: (top: 0pt, bottom: 3pt),
        {
          set text(size: 8.5pt)
          content
        }
      )
    )
  )
}

// ---- Command Entry ----
#let cmd(command, desc) = {
  stack(
    dir: ttb,
    spacing: 2pt,
    text(font: "New Computer Modern", weight: "bold", fill: luma(20))[#raw(command)],
    text(size: 8pt, fill: luma(80))[#desc],
    v(4pt)
  )
}

// ---- Sub-heading inside category ----
#let sub(title) = {
  v(2pt)
  text(weight: "bold", size: 8pt, fill: luma(50))[#title]
  v(1pt)
  line(length: 100%, stroke: 0.5pt + luma(200))
  v(2pt)
}
