// =============================================================
// 05-tables.typ — Tables
// =============================================================
// What you'll learn:
//   - Basic table with #table()
//   - Column sizing (auto, 1fr, fixed widths)
//   - Header rows with table.header()
//   - Cell alignment, fill colors, and inset
//   - Cell spanning with table.cell(colspan: ...)
// Ref: https://typst.app/docs/reference/model/table/
// =============================================================

= Acme Widget API — Endpoint Reference

// ---- Basic table ----
// `#table()` takes a `columns` count or array, followed by
// cell contents as positional arguments. Cells fill left-to-
// right, top-to-bottom.

== HTTP Status Codes

#table(
  columns: 2,
  [*Code*], [*Meaning*],
  [`200`], [OK — request succeeded.],
  [`201`], [Created — resource was created.],
  [`400`], [Bad Request — invalid parameters.],
  [`401`], [Unauthorized — missing or bad API key.],
  [`404`], [Not Found — resource does not exist.],
  [`429`], [Too Many Requests — rate limit exceeded.],
  [`500`], [Internal Server Error.],
)

// ---- Column sizing ----
// Pass an array to `columns` to control widths:
//   `auto`  — shrink to fit content
//   `1fr`   — take a proportional share of remaining space
//   `5cm`   — fixed width

== Endpoints

#table(
  columns: (auto, auto, 1fr),
  [*Method*], [*Path*], [*Description*],
  [`GET`],    [`/widgets`],           [List all widgets with pagination.],
  [`POST`],   [`/widgets`],           [Create a new widget.],
  [`GET`],    [`/widgets/{id}`],      [Retrieve a single widget by ID.],
  [`PATCH`],  [`/widgets/{id}`],      [Update specific fields on a widget.],
  [`DELETE`], [`/widgets/{id}`],      [Permanently delete a widget.],
  [`GET`],    [`/widgets/{id}/logs`], [Fetch recent activity logs.],
)

// ---- Header rows with table.header() ----
// Wrapping cells in `table.header()` marks them as the header.
// This is semantic and allows Typst to repeat headers across
// pages if the table spans multiple pages.

== Query Parameters

#table(
  columns: (auto, auto, 1fr),
  table.header(
    [*Parameter*], [*Type*], [*Description*],
  ),
  [`page`],     [`integer`], [Page number (default: 1).],
  [`per_page`], [`integer`], [Items per page (default: 20, max: 100).],
  [`status`],   [`string`],  [Filter by status: `active`, `archived`.],
  [`sort`],     [`string`],  [Sort field: `created_at`, `name`.],
  [`order`],    [`string`],  [Sort direction: `asc` or `desc`.],
)

// ---- Alignment, fill, and inset ----
// Use `align` to control text alignment in cells.
// Use `fill` to set background colors.
// Use `inset` to control cell padding.

== Pricing Tiers

#table(
  columns: (1fr, auto, auto, auto),
  align: (left, center, center, center),
  fill: (x, y) => if y == 0 { luma(230) } else if calc.odd(y) { luma(245) } else { white },
  inset: 8pt,
  table.header(
    [*Tier*], [*Requests / mo*], [*Price / 1K*], [*Support*],
  ),
  [Free],       [10,000],      [\$0.00],  [Community],
  [Starter],    [100,000],     [\$0.50],  [Email],
  [Pro],        [1,000,000],   [\$0.30],  [Priority],
  [Enterprise], [Unlimited],   [Custom],  [Dedicated],
)

// ---- Cell spanning with table.cell(colspan: ...) ----
// Use `table.cell(colspan: n)` to make a cell span n columns.

== Feature Comparison

#table(
  columns: (1fr, auto, auto, auto),
  align: (left, center, center, center),
  inset: 8pt,
  table.header(
    [*Feature*], [*Free*], [*Pro*], [*Enterprise*],
  ),
  [REST API access],         [Yes], [Yes], [Yes],
  [Webhook notifications],   [---], [Yes], [Yes],
  [Custom domains],          [---], [---], [Yes],
  [Dedicated support],       [---], [---], [Yes],
  table.cell(colspan: 4)[
    _All plans include HTTPS, JSON responses, and 99.9% uptime SLA._
  ],
)
