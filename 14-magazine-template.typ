// =============================================================
// 14-magazine-template.typ — Modern Magazine/Newsletter Template
// =============================================================

#let theme-color = rgb("#0f766e") // Deep Teal
#let accent-color = rgb("#f59e0b") // Amber
#let text-color = luma(30)

#let magazine-template(
  title: "Magazine Title",
  issue: "Issue 1",
  date: datetime.today().display("[month repr:long] [year]"),
  editor: "Editor Name",
  body,
) = {
  
  // Global settings
  set document(title: title, author: editor)
  set text(font: "New Computer Modern", size: 10pt, fill: text-color)
  set par(justify: true, leading: 0.65em)

  // ---- Cover Page ----
  // We use a separate page scope for the cover to isolate margins
  page(margin: 0cm, header: none, footer: none)[
    // Background
    #rect(width: 100%, height: 100%, fill: luma(252))
    
    // Geometric Sidebar
    #place(left, rect(width: 30%, height: 100%, fill: theme-color))
    
    // Title & Hero Area
    #place(top + left, dy: 15%, dx: 10%)[
      #text(52pt, weight: "black", fill: white, font: "New Computer Modern")[#upper(title)]
      #v(1em)
      #block(width: 60%, stroke: (bottom: 4pt + accent-color), inset: (bottom: 8pt))[
        #text(18pt, weight: "medium", fill: white.transparentize(10%))[#issue | #date]
      ]
    ]

    // Hero Text / Main Teaser (Overlapping the sidebar edge)
    #place(top + right, dy: 25%, dx: -5%)[
      // Manual shadow
      #place(top + left, dx: 4pt, dy: 4pt, rect(width: 60%, height: auto, fill: luma(200), radius: 4pt)[
          #text(32pt, weight: "bold", fill: theme-color)[The Agency Era]
          #v(0.5em)
          #text(14pt, fill: luma(80))[
            We are no longer prompting models to say things. 
            We are asking them to *do* things. 
            Inside the revolution of "System 2" reasoning.
          ]
          #v(1em)
          #text(12pt, weight: "bold", fill: accent-color)[Read the Cover Story →]
      ])
      // Main card
      #block(
        width: 60%,
        fill: white,
        inset: 24pt,
        radius: 4pt,
        stroke: 1pt + luma(200),
        [
          #text(32pt, weight: "bold", fill: theme-color)[The Agency Era]
          #v(0.5em)
          #text(14pt, fill: luma(80))[
            We are no longer prompting models to say things. 
            We are asking them to *do* things. 
            Inside the revolution of "System 2" reasoning.
          ]
          #v(1em)
          #text(12pt, weight: "bold", fill: accent-color)[Read the Cover Story →]
        ]
      )
    ]

    // Bottom Content Grid
    #place(bottom + center, dy: -3cm)[
      #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 2cm,
        align(center)[
          #text(14pt, weight: "bold", fill: text-color)[Multimodal UI] \
          #text(10pt, fill: luma(100))[Vision & Voice at the Edge]
        ],
        align(center)[
          #text(14pt, weight: "bold", fill: text-color)[Prompt Engineering] \
          #text(10pt, fill: luma(100))[The "Critic Loop" Pattern]
        ],
        align(center)[
          #text(14pt, weight: "bold", fill: text-color)[Market Watch] \
          #text(10pt, fill: luma(100))[GPT-6 vs Gemini 3]
        ],
      )
    ]
  ]

  // ---- Inside Pages Setup ----
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2cm, x: 2cm),
    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, auto),
          align(left + horizon, text(8pt, weight: "bold", fill: theme-color, upper(title) + " | " + issue)),
          align(right + horizon, text(24pt, weight: "bold", fill: luma(220), counter(page).display()))
        )
        v(-8pt)
        line(length: 100%, stroke: 1pt + theme-color)
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        align(center, text(8pt, fill: luma(150))[© 2026 Acme Media Group — Professional Edition])
      }
    }
  )

  // Reset counter to ensure page 1 is the first content page if desired, 
  // or let it flow naturally (Cover is 1). Usually Cover is 1.
  
  body
}

// ---- Layout Components ----

#let feature-header(title, subtitle, author) = {
  // Use colbreak to ensure we start at the top of a column or page
  colbreak(weak: true) 
  v(1cm)
  block(width: 100%, inset: (bottom: 20pt), stroke: (bottom: 3pt + theme-color), {
    text(28pt, weight: "black", fill: theme-color, font: "New Computer Modern")[#title]
    v(8pt)
    text(14pt, style: "italic", fill: luma(80))[#subtitle]
    v(12pt)
    grid(
      columns: (auto, 1fr),
      gutter: 10pt,
      circle(radius: 12pt, fill: accent-color),
      align(horizon, text(10pt, weight: "bold")[By #author])
    )
  })
  v(0.5cm)
}

#let section-header(title) = {
  v(1.5em)
  block(
    stroke: (left: 4pt + accent-color),
    width: 100%,
    inset: (left: 8pt),
    text(14pt, weight: "bold", fill: theme-color, upper(title))
  )
  v(0.5em)
}

#let dropcap(letter, body) = {
  grid(
    columns: (auto, 1fr),
    gutter: 6pt,
    text(38pt, weight: "black", fill: theme-color, font: "New Computer Modern")[#letter],
    align(horizon, body)
  )
}

#let info-box(title, body) = {
  v(10pt)
  block(
    fill: luma(248),
    stroke: 0.5pt + luma(200),
    radius: 4pt,
    inset: 12pt,
    width: 100%,
    {
      grid(
        columns: (auto, 1fr),
        gutter: 8pt,
        text(14pt, fill: accent-color)[★],
        text(weight: "bold", fill: theme-color)[#title]
      )
      v(4pt)
      set text(size: 9pt)
      body
    }
  )
  v(10pt)
}

// ---- Charting Helper (Simple Line Chart) ----
#let simple-chart(caption: "", data: ()) = {
  v(10pt)
  figure(
    block(
      width: 100%, 
      height: 150pt, 
      fill: white, 
      stroke: 0.5pt + luma(200), 
      inset: 20pt,
      {
        // Axis lines
        place(left + bottom, line(length: 100%, stroke: 1pt + luma(100))) // X
        place(left + bottom, line(end: (0pt, -100%), stroke: 1pt + luma(100))) // Y
        
        // Plot points
        let max-val = 100
        let count = data.len()
        let step-x = 100% / (count - 1)
        
        // Grid lines Y
        for i in (25, 50, 75) {
             place(left + bottom, dy: -1% * i, line(length: 100%, stroke: (paint: luma(230), dash: "dashed")))
        }

        // Draw line
        let points = ()
        for (i, val) in data.enumerate() {
          let x = i * step-x
          let y = -1% * val
          
          // Draw point
          place(left + bottom, dx: x, dy: y, circle(radius: 2pt, fill: theme-color))
          
          // Draw label
          if i == count - 1 or i == 0 {
             place(left + bottom, dx: x - 5pt, dy: y + 8pt, text(7pt, weight: "bold")[#val])
          }
        }
      }
    ),
    caption: caption
  )
  v(10pt)
}