// =============================================================
// 09-idd-template.typ — IDD Document Template (DI-IPSC-81436A)
// =============================================================
// Reusable template for an Interface Design Description
// following MIL-STD-498 / DI-IPSC-81436A structure.
//
// What you'll learn:
//   - Custom helper functions exported from a template
//   - Custom counters for auto-numbering requirements
//   - Regex show rules for auto-highlighting patterns
//   - Gradient backgrounds with gradient.linear()
//   - Absolute positioning with place()
//   - PDF metadata via set document()
//   - Roman-to-arabic page numbering switch
//   - List of Figures / List of Tables via outline()
//   - set smartquote() and set enum(numbering:)
//   - 4-level heading numbering
// Ref: https://typst.app/docs/reference/model/document/
// Ref: https://typst.app/docs/reference/model/numbering/
// Ref: https://typst.app/docs/reference/visualize/gradient/
// =============================================================

// ---- Custom counter for auto-numbering requirements ----
// Counters let you track and display sequential numbers
// across the document. We use one to number requirements.
#let req-counter = counter("requirement")

// ---- Exported helper: requirement box ----
// Displays a styled requirement with auto-incrementing ID.
// Uses req-counter to track how many requirements exist.
#let requirement(id, body, priority: "Shall") = {
  req-counter.step()
  block(
    width: 100%,
    inset: 10pt,
    radius: 4pt,
    stroke: 0.75pt + rgb("#3b82f6"),
    fill: rgb("#eff6ff"),
  )[
    #grid(
      columns: (auto, 1fr, auto),
      column-gutter: 8pt,
      align(left, strong[#id]),
      align(left, body),
      align(right, {
        let color = if priority == "Shall" { rgb("#16a34a") }
          else if priority == "Should" { rgb("#d97706") }
          else { rgb("#6b7280") }
        box(
          inset: (x: 6pt, y: 2pt),
          radius: 3pt,
          fill: color,
          text(fill: white, weight: "bold", size: 8pt)[#priority],
        )
      }),
    )
  ]
}

// ---- Exported helper: interface badge ----
// Creates a gradient-filled badge for interface identifiers.
#let if-badge(name, color: blue) = {
  box(
    inset: (x: 5pt, y: 2pt),
    radius: 3pt,
    fill: gradient.linear(color.lighten(60%), color.lighten(30%)),
    text(weight: "bold", size: 9pt, fill: color.darken(40%), name),
  )
}

// ---- Exported helper: note-box ----
// Callout box with conditional color based on kind.
// Kinds: "info" (blue), "warning" (amber), "error" (red).
#let note-box(title, body, kind: "info") = {
  let (accent, bg) = if kind == "warning" {
    (rgb("#d97706"), rgb("#fffbeb"))
  } else if kind == "error" {
    (rgb("#dc2626"), rgb("#fef2f2"))
  } else {
    (rgb("#2563eb"), rgb("#eff6ff"))
  }
  block(
    width: 100%,
    inset: 10pt,
    radius: 4pt,
    fill: bg,
    stroke: (left: 3pt + accent, rest: 0.5pt + accent.lighten(50%)),
  )[
    #text(weight: "bold", fill: accent, size: 10pt)[#title] \
    #body
  ]
}

// ---- Main template function ----
#let idd-template(
  title: "Interface Design Description",
  subtitle: "",
  doc-number: "IDD-001",
  version: "1.0",
  author: "Author",
  date: datetime.today().display("[month repr:long] [day], [year]"),
  classification: "UNCLASSIFIED",
  body,
) = {

  // ---- PDF metadata ----
  // set document() embeds metadata into the output PDF.
  set document(
    title: title,
    author: author,
    keywords: ("IDD", "interface", "MIL-STD-498", "DI-IPSC-81436A"),
  )

  // ---- Page setup ----
  set page(
    paper: "us-letter",
    margin: (top: 2.5cm, bottom: 2cm, left: 2.5cm, right: 2.5cm),
    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, 1fr, 1fr),
          align(left, text(8pt, fill: luma(100))[#doc-number]),
          align(center, text(8pt, fill: luma(100))[#classification]),
          align(right, text(8pt, fill: luma(100))[Version #version]),
        )
        line(length: 100%, stroke: 0.4pt + luma(200))
      }
    },
    footer: context {
      line(length: 100%, stroke: 0.4pt + luma(200))
      v(4pt)
      align(center, text(8pt, fill: luma(100))[
        Page #counter(page).display()
      ])
    },
  )

  // ---- Typography ----
  set text(font: "New Computer Modern", size: 11pt, lang: "en")
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1.1.1")
  set smartquote(enabled: true)
  set enum(numbering: "a)")

  // ---- Heading styles ----
  // Level 1: large, blue, with underline
  show heading.where(level: 1): it => {
    set text(16pt, weight: "bold", fill: rgb("#1e3a5f"))
    v(16pt)
    block[
      #if it.numbering != none {
        counter(heading).display()
        h(8pt)
      }
      #it.body
    ]
    v(2pt)
    line(length: 100%, stroke: 1.5pt + rgb("#1e3a5f"))
    v(8pt)
  }

  // Level 2: medium, dark gray
  show heading.where(level: 2): it => {
    set text(13pt, weight: "bold", fill: rgb("#374151"))
    v(12pt)
    block[
      #if it.numbering != none {
        counter(heading).display()
        h(6pt)
      }
      #it.body
    ]
    v(4pt)
  }

  // Level 3: smaller, italic accent
  show heading.where(level: 3): it => {
    set text(11pt, weight: "bold", fill: rgb("#4b5563"))
    v(10pt)
    block[
      #if it.numbering != none {
        counter(heading).display()
        h(6pt)
      }
      #it.body
    ]
    v(3pt)
  }

  // Level 4: smallest, gray
  show heading.where(level: 4): it => {
    set text(10pt, weight: "bold", style: "italic", fill: rgb("#6b7280"))
    v(8pt)
    block[
      #if it.numbering != none {
        counter(heading).display()
        h(6pt)
      }
      #it.body
    ]
    v(2pt)
  }

  // ---- Code styling ----
  show raw.where(block: false): box.with(
    fill: luma(235),
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

  // ---- Regex show rule ----
  // Automatically highlights interface IDs matching IF-XXXX
  // patterns in a styled blue badge wherever they appear.
  show regex("IF-(REST|WS|DB|MQ)"): it => {
    box(
      inset: (x: 4pt, y: 1pt),
      radius: 3pt,
      fill: rgb("#dbeafe"),
      text(weight: "bold", size: 9pt, fill: rgb("#1e40af"), it),
    )
  }

  // ---- Cover page ----
  // Uses gradient.linear() for background and place() for
  // absolute positioning of title and metadata.
  page(margin: 0pt, header: none, footer: none)[
    // Gradient background fill
    #place(
      dx: 0pt, dy: 0pt,
      rect(
        width: 100%,
        height: 100%,
        fill: gradient.linear(
          rgb("#1e3a5f"),
          rgb("#2d5a87"),
          rgb("#3b7cb8"),
          angle: 135deg,
        ),
      ),
    )
    // Classification banner at top
    #place(
      top + center, dy: 20pt,
      text(12pt, weight: "bold", fill: white.darken(20%))[#classification],
    )
    // Document title block — centered
    #place(
      center + horizon,
      box(width: 80%)[
        #align(center)[
          #text(32pt, weight: "bold", fill: white)[#title]
          #v(8pt)
          #if subtitle != "" {
            text(16pt, fill: white.darken(10%))[#subtitle]
            v(12pt)
          }
          #line(length: 50%, stroke: 1pt + white.darken(30%))
          #v(16pt)
          #text(12pt, fill: white.darken(10%))[
            Document Number: #doc-number \
            Version: #version \
            #date
          ]
          #v(12pt)
          #text(11pt, fill: white.darken(15%))[Prepared by: #author]
        ]
      ],
    )
    // Footer classification
    #place(
      bottom + center, dy: -20pt,
      text(10pt, fill: white.darken(20%))[
        Distribution Statement A: Approved for public release
      ],
    )
  ]

  // ---- Front matter (roman numerals) ----
  // Switch to roman numeral page numbering for front matter.
  set page(
    footer: context {
      line(length: 100%, stroke: 0.4pt + luma(200))
      v(4pt)
      align(center, text(8pt, fill: luma(100))[
        Page #counter(page).display("i")
      ])
    },
  )
  counter(page).update(1)

  // Table of Contents
  heading(level: 1, numbering: none)[Table of Contents]
  outline(title: none, indent: auto, depth: 4)
  pagebreak()

  // List of Figures
  heading(level: 1, numbering: none)[List of Figures]
  outline(title: none, target: figure.where(kind: image))
  pagebreak()

  // List of Tables
  heading(level: 1, numbering: none)[List of Tables]
  outline(title: none, target: figure.where(kind: table))
  pagebreak()

  // ---- Body (arabic numerals) ----
  // Reset page counter to 1 with arabic numbering.
  set page(
    footer: context {
      line(length: 100%, stroke: 0.4pt + luma(200))
      v(4pt)
      align(center, text(8pt, fill: luma(100))[
        Page #counter(page).display("1")
      ])
    },
  )
  counter(page).update(1)

  body
}
