// =============================================================
// 04-images-and-figures.typ — Images, Figures, and Labels
// =============================================================
// What you'll learn:
//   - Including images with #image()
//   - Wrapping images in #figure() with captions
//   - Labels (<label>) and cross-references (@label)
//   - Figure numbering (automatic)
// Ref: https://typst.app/docs/reference/model/figure/
// =============================================================
//
// NOTE: This file references placeholder image paths. To
// compile without errors, we create simple rectangles as
// stand-ins using #rect(). In a real project you would use
// actual image files:
//   #image("architecture.png", width: 80%)

= Acme Widget API — Architecture & Diagrams

== System Overview

// ---- Images with #image() ----
// Syntax: #image("path/to/file.png")
// Supported formats: PNG, JPEG, GIF, SVG.
// Use the `width` or `height` parameter to scale.

// Since we don't have real images, we'll use colored
// rectangles as visual placeholders throughout this file.

// ---- Figures with captions ----
// Wrap content in `#figure()` to add a caption and get
// automatic numbering (Figure 1, Figure 2, ...).

#figure(
  rect(width: 80%, height: 4cm, fill: luma(230), stroke: 1pt)[
    #align(center + horizon)[
      _Placeholder: System Architecture Diagram_
    ]
  ],
  caption: [High-level architecture of the Acme Widget platform.],
) <arch-diagram>

// ---- Labels and references ----
// Attach a label with `<name>` right after a figure.
// Reference it anywhere with `@name`.

As shown in @arch-diagram, the platform consists of three
layers: the API gateway, the widget engine, and the data
store.

== Request Flow

#figure(
  rect(width: 70%, height: 3cm, fill: rgb("#e8f0fe"), stroke: 1pt)[
    #align(center + horizon)[
      _Placeholder: Request Flow Sequence Diagram_
    ]
  ],
  caption: [Sequence diagram showing a typical API request.],
) <request-flow>

@request-flow illustrates the path a request takes from the
client through the gateway, into the widget engine, and back.

== Data Model

#figure(
  rect(width: 60%, height: 3.5cm, fill: rgb("#fef7e0"), stroke: 1pt)[
    #align(center + horizon)[
      _Placeholder: Entity-Relationship Diagram_
    ]
  ],
  caption: [Entity-relationship diagram for the Widget data model.],
) <er-diagram>

The data model (@er-diagram) centers on three entities:
*Widget*, *WidgetVersion*, and *WidgetConfig*. Each widget
can have multiple versions, and each version references a
single config.

== Dashboard Screenshot

#figure(
  rect(width: 90%, height: 5cm, fill: luma(245), stroke: 1pt)[
    #align(center + horizon)[
      _Placeholder: Dashboard Screenshot_
    ]
  ],
  caption: [The Acme developer dashboard showing widget metrics.],
) <dashboard>

The developer dashboard (@dashboard) gives you real-time
visibility into request volume, error rates, and latency
percentiles.

// ---- Cross-reference summary ----
// You can reference any labeled figure from anywhere in the
// document. Typst resolves the figure number automatically.

== Summary

This section covered four key diagrams:
+ The system architecture (@arch-diagram)
+ The request flow (@request-flow)
+ The data model (@er-diagram)
+ The dashboard (@dashboard)
