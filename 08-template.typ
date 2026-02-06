// =============================================================
// 08-template.typ — Reusable Document Template
// =============================================================
// This file defines a template function that applies
// consistent styling. Import it from another file and
// use the `#show: template.with(...)` pattern.
//
// What you'll learn:
//   - Defining a template as a function
//   - Accepting parameters (title, author, date, version)
//   - Applying page setup, fonts, and heading styles
//   - Exporting the function for use in other files
// Ref: https://typst.app/docs/tutorial/making-a-template/
// =============================================================

// The template function takes named parameters and returns
// a function that accepts the document body. This is the
// standard Typst template pattern.

#let template(
  title: "Document Title",
  author: "Author Name",
  date: datetime.today().display("[month repr:long] [day], [year]"),
  version: "1.0.0",
  body,
) = {

  // ---- Page setup ----
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2cm, left: 2cm, right: 2cm),
    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, 1fr),
          align(left, text(8pt, fill: luma(130))[#title]),
          align(right, text(8pt, fill: luma(130))[v#version]),
        )
        line(length: 100%, stroke: 0.4pt + luma(210))
      }
    },
    footer: context {
      line(length: 100%, stroke: 0.4pt + luma(210))
      v(4pt)
      grid(
        columns: (1fr, 1fr),
        align(left, text(8pt, fill: luma(130))[#author]),
        align(right, text(8pt, fill: luma(130))[
          Page #counter(page).display()
        ]),
      )
    },
  )

  // ---- Typography ----
  set text(font: "New Computer Modern", size: 11pt, lang: "en")
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1")

  // ---- Heading styles ----
  show heading.where(level: 1): it => {
    set text(16pt, weight: "bold", fill: rgb("#1a56db"))
    v(14pt)
    it.body
    v(4pt)
    line(length: 100%, stroke: 1.5pt + rgb("#1a56db"))
    v(8pt)
  }

  show heading.where(level: 2): it => {
    set text(13pt, weight: "bold", fill: luma(60))
    v(10pt)
    it.body
    v(4pt)
  }

  show heading.where(level: 3): it => {
    set text(11pt, weight: "bold", style: "italic", fill: luma(80))
    v(8pt)
    it.body
    v(3pt)
  }

  // ---- Code styling ----
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  show raw.where(block: true): block.with(
    fill: luma(245),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )

  // ---- Title page ----
  v(4cm)
  align(center)[
    #text(28pt, weight: "bold", fill: rgb("#1a56db"))[#title]
    #v(0.5cm)
    #text(12pt, fill: luma(100))[Version #version]
    #v(0.3cm)
    #text(11pt)[#author]
    #v(0.2cm)
    #text(10pt, fill: luma(130))[#date]
  ]
  v(2cm)

  // ---- Table of contents ----
  outline(title: [Table of Contents], indent: auto)
  pagebreak()

  // ---- Body content ----
  body
}
