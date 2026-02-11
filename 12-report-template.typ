// =============================================================
// 12-report-template.typ — Technical Report Template
// =============================================================

#let report-template(
  title: "Technical Report",
  subtitle: "Performance Analysis",
  body,
) = {
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2.5cm),
    header: align(right, text(8pt, fill: luma(150), [#title — #subtitle])),
    footer: context {
      line(length: 100%, stroke: 0.5pt + luma(200))
      grid(
        columns: (1fr, 1fr),
        text(8pt, fill: luma(150), [Acme Engineering]),
        align(right, text(8pt, fill: luma(150), [Page #counter(page).display()])),
      )
    }
  )

  set text(font: "New Computer Modern", size: 10pt)
  set heading(numbering: "1.1")
  
  // Title Block
  v(1cm)
  text(24pt, weight: "bold", fill: rgb("#1a56db"))[#title]
  v(4pt)
  text(14pt, weight: "medium", fill: luma(100))[#subtitle]
  v(1cm)
  line(length: 100%, stroke: 2pt + rgb("#1a56db"))
  v(1.5cm)

  body
}

#let metric-card(label, value, unit: "") = {
  block(
    fill: luma(250),
    stroke: 0.5pt + luma(200),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
    {
      text(8pt, weight: "bold", fill: luma(120), upper(label))
      v(4pt)
      text(14pt, weight: "bold", fill: rgb("#1a56db"))[#value#text(10pt)[#unit]]
    }
  )
}
