// =============================================================
// 06-page-setup.typ — Page Layout, Headers, Footers
// =============================================================
// What you'll learn:
//   - Paper size with #set page()
//   - Margins
//   - Page numbering
//   - Custom headers and footers
//   - Multi-column layout
//   - Table of contents with #outline()
// Ref: https://typst.app/docs/guides/page-setup-guide/
// =============================================================

// ---- Paper size and margins ----
// Use `#set page()` to configure the page. Common paper
// sizes: "a4", "us-letter". Margins accept a dictionary
// with `top`, `bottom`, `left`, `right` keys.

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2cm),

  // ---- Custom header ----
  // The `header` parameter accepts content. We use
  // `context` to access the current page number.
  header: context {
    // Skip the header on the first page (title page).
    if counter(page).get().first() > 1 {
      grid(
        columns: (1fr, 1fr),
        align(left, text(8pt, fill: luma(120))[Acme Widget API — Reference Guide]),
        align(right, text(8pt, fill: luma(120))[v2.1.0]),
      )
      line(length: 100%, stroke: 0.5pt + luma(200))
    }
  },

  // ---- Custom footer with page numbering ----
  // `counter(page).display()` renders the current page
  // number. The `numbering` argument controls format:
  //   "1"     → 1, 2, 3
  //   "1/1"   → 1/1, 2/5, ...  (needs total)
  //   "i"     → i, ii, iii
  footer: context {
    let pg = counter(page).get().first()
    line(length: 100%, stroke: 0.5pt + luma(200))
    v(4pt)
    grid(
      columns: (1fr, 1fr, 1fr),
      align(left, text(8pt, fill: luma(120))[© 2025 Acme Inc.]),
      align(center, text(8pt)[Page #pg]),
      align(right, text(8pt, fill: luma(120))[Confidential]),
    )
  },
)

// ---- Title block ----
// Build a simple title page using alignment and spacing.

#v(3cm)
#align(center)[
  #text(24pt, weight: "bold")[Acme Widget API] \
  #text(16pt, fill: luma(100))[Reference Guide] \
  #v(1cm)
  #text(12pt)[Version 2.1.0 · January 2025] \
  #text(10pt, fill: luma(120))[Acme Inc. — Internal Use Only]
]
#v(2cm)

// ---- Table of contents ----
// `#outline()` generates a table of contents from headings.
// Use `indent: auto` for nested indentation.

#outline(
  title: [Table of Contents],
  indent: auto,
)

// Force a page break so content starts on a new page.
#pagebreak()

// ---- Document content ----

= Introduction

The Acme Widget API provides a RESTful interface for managing
widgets across your organization. This guide covers every
endpoint, authentication method, and best practice.

== Authentication

All requests require an API key in the `Authorization` header.
Keys are scoped to a single project and can be rotated from
the developer dashboard.

== Base URL

All endpoints are relative to:

```
https://api.example.com/v1
```

= Endpoints

== List Widgets

Retrieve a paginated list of widgets. Supports filtering by
status and sorting by creation date.

== Get Widget

Fetch a single widget by its unique ID. Returns the full
widget object including configuration and version history.

== Create Widget

Create a new widget with the specified name and configuration.
The response includes the newly assigned widget ID.

= Best Practices

== Rate Limiting

Respect the `X-RateLimit-Remaining` header. When it reaches
zero, back off until the `X-RateLimit-Reset` timestamp.

== Error Handling

Always check the HTTP status code. Parse the `error.message`
field from the JSON body for human-readable details.

// ---- Multi-column layout ----
// Use `columns()` to flow content into multiple columns.
// You can also set `columns: 2` on `#set page()` for the
// whole document, but here we do it for a single section.

= Appendix: Status Codes

#columns(2)[
  / 200 OK: Request succeeded.
  / 201 Created: Resource created.
  / 204 No Content: Deleted successfully.
  / 400 Bad Request: Invalid input.
  / 401 Unauthorized: Bad API key.
  / 403 Forbidden: Insufficient permissions.
  / 404 Not Found: Resource missing.
  / 409 Conflict: Duplicate resource.
  / 422 Unprocessable: Validation error.
  / 429 Rate Limited: Too many requests.
  / 500 Server Error: Unexpected failure.
  / 502 Bad Gateway: Upstream error.
  / 503 Unavailable: Service maintenance.
]
