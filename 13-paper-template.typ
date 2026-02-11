// =============================================================
// 13-paper-template.typ — Academic Paper Template
// =============================================================

#let paper-template(
  title: "Paper Title",
  authors: (),
  abstract: [],
  keywords: (),
  body,
) = {
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),
    numbering: "1",
  )

  set text(font: "New Computer Modern", size: 10pt)
  set heading(numbering: "1.")
  set par(justify: true)

  // Title and Authors
  align(center)[
    #text(18pt, weight: "bold")[#title]
    #v(1em)
    #grid(
      columns: (1fr,) * calc.min(authors.len(), 3),
      column-gutter: 1em,
      ..authors.map(author => [
        #text(11pt, weight: "bold")[#author.name] 
        #text(9pt)[#author.affiliation] 
        #text(9pt, fill: blue)[#link("mailto:" + author.email)]
      ])
    )
  ]

  v(2em)

  // Abstract and Keywords
  block(inset: (x: 1cm), {
    text(weight: "bold")[Abstract]
    v(0.5em)
    abstract
    v(1em)
    text(weight: "bold")[Keywords: ]
    keywords.join(", ")
  })

  v(2em)

  // Main body in two columns
  columns(2, gutter: 1.5em)[
    #body
  ]
}
