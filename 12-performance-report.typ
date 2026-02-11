// =============================================================
// 12-performance-report.typ — Data-Driven Performance Analysis
// =============================================================
// This example demonstrates how to load external JSON data
// and use Typst's scripting capabilities to generate a report.
//
// What you'll learn:
//   - Loading data with #json()
//   - Accessing data from dictionaries and arrays
//   - Using loops to generate dynamic tables
//   - Conditional styling based on data values
// =============================================================

#import "12-report-template.typ": report-template, metric-card

// Load the external data
#let data = json("12-perf-data.json")

#show: report-template.with(
  title: "API Performance Report",
  subtitle: "Environment: " + data.environment,
)

= Executive Summary

This report provides a summary of the Acme Widget API performance for the period ending on *#data.report_date*. Overall system health is rated as *#if data.summary.error_rate < 0.05 ["Optimal"] else ["At Risk"]*.

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 10pt,
  metric-card("Uptime", data.summary.uptime, unit: "%"),
  metric-card("Avg Latency", data.summary.avg_latency, unit: "ms"),
  metric-card("Error Rate", data.summary.error_rate, unit: "%"),
  metric-card("Total Req", "1.45", unit: "M"),
)

= Endpoint Performance

The following table summarizes the response times for primary API endpoints, derived automatically from the system telemetry export.

#table(
  columns: (1fr, auto, auto, auto, auto),
  inset: 8pt,
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#1a56db").lighten(90%) } else { none },
  table.header(
    strong[Endpoint Path], strong[Method], strong[Avg (ms)], strong[P95 (ms)], strong[Status]
  ),
  // Map our JSON data directly into table cells
  ..data.endpoints.map(ep => (
    `#ep.path`,
    ep.method,
    str(ep.avg),
    str(ep.p95),
    // Conditional text color based on status
    if ep.status == "Degraded" { text(fill: red, weight: "bold", ep.status) }
    else if ep.status == "Optimal" { text(fill: green.darken(20%), ep.status) }
    else { ep.status }
  )).flatten()
)

= Incident Log

A total of #data.incidents.len() incidents were recorded during this reporting window.

#for incident in data.incidents [
  - *#incident.id*: #incident.impact (#incident.duration) at #incident.time
]

#v(1fr)
#block(
  width: 100%,
  inset: 10pt,
  fill: luma(245),
  radius: 4pt,
  text(8pt, style: "italic", [
    Note: This report was automatically generated via Typst by processing `12-perf-data.json`.
    Manual adjustments should be made to the raw data file.
  ])
)
