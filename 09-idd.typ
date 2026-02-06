// =============================================================
// 09-idd.typ — Interface Design Description (DI-IPSC-81436A)
// =============================================================
// An example IDD for the fictional Acme Widget Platform,
// following the DI-IPSC-81436A DID section structure from
// MIL-STD-498. Imports a reusable template and demonstrates
// advanced Typst features not covered in examples 01-08.
//
// What you'll learn:
//   - Importing custom helpers + template from another file
//   - Footnotes
//   - Superscript (#super) and subscript (#sub)
//   - #underline[] and #strike[] text decorations
//   - Loops, conditionals, and dictionary iteration in content
//   - .map() and .flatten() for data-driven tables
//   - page(flipped: true) for landscape pages
//   - rotate() for rotated text
//   - Per-cell table stroke customization
//   - Per-side box/block stroke
//   - Context-based counter reading (layout introspection)
//   - heading(numbering: none) for unnumbered sections
//   - grid() layout for diagrams
// Ref: https://typst.app/docs/reference/model/footnote/
// Ref: https://typst.app/docs/reference/model/super/
// Ref: https://typst.app/docs/reference/layout/page/
// =============================================================

#import "09-idd-template.typ": idd-template, requirement, if-badge, note-box, req-counter

#show: idd-template.with(
  title: "Interface Design Description",
  subtitle: "Acme Widget Platform",
  doc-number: "AWP-IDD-2025-001",
  version: "2.0",
  author: "Acme Engineering Team",
  date: "January 20, 2025",
  classification: "UNCLASSIFIED",
)

// =============================================================
// SECTION 1: SCOPE
// =============================================================

= Scope

== Identification

// ---- Dictionary iteration ----
// System properties stored in a dictionary and rendered
// via a #for loop, demonstrating data-driven content.

#let sys-info = (
  "System Name": "Acme Widget Platform (AWP)",
  "CSCI Name": "Widget Interface Services (WIS)",
  "Contract Number": "FA8750-24-C-0042",
  "CDRL Sequence": "A009",
  "Document Identifier": "AWP-IDD-2025-001",
)

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  stroke: 0.5pt + luma(180),
  ..for (key, value) in sys-info {
    (strong[#key], [#value])
  }
)

This Interface Design Description (IDD) identifies and describes
the interfaces for the Acme Widget Platform (AWP) Computer
Software Configuration Item (CSCI). This document is prepared in
accordance with DI-IPSC-81436A#footnote[DI-IPSC-81436A is the
Data Item Description for Interface Design Descriptions under
MIL-STD-498.] and conforms to the interface documentation
requirements of MIL-STD-498#footnote[MIL-STD-498: Software
Development and Documentation, Department of Defense Standard.].

== System Overview

The Acme Widget Platform provides a comprehensive suite of services
for creating, managing, and monitoring widgets across distributed
environments. The system exposes four primary interfaces, shown
in @if-diagram:

- *IF-REST* — RESTful API for widget CRUD operations
- *IF-WS* — WebSocket service for real-time notifications
- *IF-DB* — PostgreSQL database interface for persistence
- *IF-MQ* — RabbitMQ message queue for asynchronous processing

These interfaces collectively support widget lifecycle management,
event-driven notifications, data persistence, and inter-service
communication.

== Document Overview

This IDD is organized according to DI-IPSC-81436A:

+ *Section 1 — Scope:* System identification and overview.
+ *Section 2 — Referenced Documents:* Standards and references.
+ *Section 3 — Interface Design:* Detailed interface descriptions.
+ *Section 4 — Requirements Traceability:* Mapping to SRS requirements.
+ *Section 5 — Notes:* Glossary, acronyms, and assumptions.

// =============================================================
// SECTION 2: REFERENCED DOCUMENTS
// =============================================================

= Referenced Documents

// ---- Array of dictionaries + enumerate loop ----
// References are stored as an array of dictionaries and
// rendered with an enumerated loop.

#let references = (
  (id: "MIL-STD-498", title: "Software Development and Documentation", year: "1994"),
  (id: "DI-IPSC-81436A", title: "Interface Design Description (IDD)", year: "1994"),
  (id: "RFC 7231", title: "HTTP/1.1 Semantics and Content", year: "2014"),
  (id: "RFC 6455", title: "The WebSocket Protocol", year: "2011"),
  (id: "RFC 7807", title: "Problem Details for HTTP APIs", year: "2016"),
  (id: "AMQP 0-9-1", title: "Advanced Message Queuing Protocol", year: "2008"),
  (id: "ISO 8601", title: "Date and Time Format", year: "2019"),
  (id: "AWP-SRS-2025-001", title: "Acme Widget Platform Software Requirements Specification", year: "2025"),
)

The following documents are referenced in this IDD:

#for (i, ref) in references.enumerate() [
  + *#ref.id* — #emph(ref.title) (#ref.year)
]

// Note: In a production document you would use #bibliography()
// with a .bib file and #cite() for automatic reference
// management. For this example we generate the list manually.

// =============================================================
// SECTION 3: INTERFACE DESIGN
// =============================================================

= Interface Design

== Interface Identification and Diagrams

@if-summary-table provides an overview of all interfaces in the
Acme Widget Platform.

// ---- Table with per-cell stroke customization ----
// The stroke parameter accepts a function of (x, y) to
// control borders on a per-cell basis.

#figure(
  table(
    columns: (auto, 1fr, auto, auto),
    inset: 8pt,
    stroke: (x, y) => {
      if y == 0 { (bottom: 2pt + rgb("#1e3a5f")) }
      else { (bottom: 0.5pt + luma(200)) }
    },
    fill: (x, y) => if y == 0 { rgb("#1e3a5f").lighten(85%) } else if calc.odd(y) { luma(248) } else { white },
    table.header(
      strong[Interface ID],
      strong[Description],
      strong[Protocol],
      strong[Direction],
    ),
    [IF-REST], [Widget CRUD API], [HTTPS], [Bidirectional],
    [IF-WS], [Real-time notifications], [WSS], [Server → Client],
    [IF-DB], [Data persistence layer], [TCP/SQL], [Internal],
    [IF-MQ], [Async message processing], [AMQP], [Bidirectional],
  ),
  caption: [Interface Summary],
) <if-summary-table>

// ---- Interface context diagram ----
// Built with place(), rect(), grid(), and line() to show
// component relationships using absolute positioning.

#figure(
  block(width: 100%, height: 220pt, {
    let comp-box(label, fill-color) = rect(
      width: 120pt, height: 40pt,
      fill: fill-color.lighten(80%),
      stroke: 1pt + fill-color,
      radius: 5pt,
      inset: 8pt,
      align(center + horizon, text(9pt, weight: "bold", fill: fill-color.darken(20%), label)),
    )
    let arrow-label(label) = text(8pt, style: "italic", fill: luma(100), label)

    // External client
    place(dx: 10pt, dy: 10pt, comp-box("External Client", rgb("#6366f1")))
    // AWP Core
    place(dx: 180pt, dy: 10pt, comp-box("AWP Core Service", rgb("#1e3a5f")))
    // Database
    place(dx: 350pt, dy: 10pt, comp-box("PostgreSQL DB", rgb("#16a34a")))
    // WebSocket
    place(dx: 10pt, dy: 120pt, comp-box("WS Subscribers", rgb("#9333ea")))
    // Message Queue
    place(dx: 350pt, dy: 120pt, comp-box("RabbitMQ", rgb("#d97706")))
    // Downstream service
    place(dx: 180pt, dy: 120pt, comp-box("Worker Service", rgb("#0891b2")))

    // Connection labels
    place(dx: 130pt, dy: 24pt, arrow-label[IF-REST])
    place(dx: 300pt, dy: 24pt, arrow-label[IF-DB])
    place(dx: 60pt, dy: 80pt, arrow-label[IF-WS])
    place(dx: 300pt, dy: 80pt, arrow-label[IF-MQ])
  }),
  caption: [Interface Context Diagram],
  kind: image,
) <if-diagram>


== IF-REST: Widget REST API <sec-if-rest>

=== Overview

The IF-REST interface provides a RESTful#super[1] API for widget
lifecycle management. All operations conform to HTTP/1.1#sub[RFC7231]
semantics with JSON request and response bodies.

#note-box(
  [Authentication Required],
  [All IF-REST endpoints require a valid API key in the
  `Authorization` header. Keys support scope-based access control.],
)

=== Data Elements

// ---- .map() + .flatten() for data-driven tables ----
// Data elements defined as an array of tuples, then mapped
// into table cells using .map() and .flatten().

#let rest-fields = (
  ("widget_id", "string", "UUID v4 identifier", "Read-only"),
  ("name", "string", "Display name (1-255 chars)", "Required"),
  ("status", "enum", "active | paused | archived", "Default: active"),
  ("config", "object", "Widget configuration map", "Optional"),
  ("created_at", "datetime", "ISO 8601 creation timestamp", "Read-only"),
  ("updated_at", "datetime", "ISO 8601 last-modified timestamp", "Read-only"),
  ("version", "integer", "Optimistic lock version", "Auto-increment"),
)

#figure(
  table(
    columns: (auto, auto, 1fr, auto),
    inset: 8pt,
    stroke: 0.5pt + luma(180),
    fill: (x, y) => if y == 0 { rgb("#1e3a5f").lighten(85%) } else { none },
    table.header(
      strong[Field], strong[Type], strong[Description], strong[Constraint],
    ),
    // Flatten the array of tuples into a flat sequence of cells
    ..rest-fields.map(row => row.map(cell => [#cell])).flatten()
  ),
  caption: [IF-REST Widget Resource Data Elements],
) <rest-data-elements>

=== Request/Response Examples

*Create Widget Request:*
```json
{
  "name": "Weather Dashboard",
  "config": {
    "refresh_interval": 300,
    "theme": "dark",
    "data_source": "api.weather.gov"
  }
}
```

*Success Response (201 Created):*
```json
{
  "widget_id": "wgt_7f3a2b1c-9d4e-4a5f-b6c8-1e2d3f4a5b6c",
  "name": "Weather Dashboard",
  "status": "active",
  "version": 1,
  "created_at": "2025-01-15T10:30:00Z"
}
```

=== Requirements

#requirement("IDD-REST-001", [The IF-REST interface shall accept
and return JSON payloads conforming to RFC 7159.])

#requirement("IDD-REST-002", [The IF-REST interface shall enforce
rate limiting of 1000 requests per minute per API key.], priority: "Shall")

#requirement("IDD-REST-003", [The IF-REST interface should support
conditional requests via `ETag` and `If-Match` headers for
optimistic concurrency control.], priority: "Should")

#requirement("IDD-REST-004", [The IF-REST interface may support
batch operations for up to 100 widgets per
request.], priority: "May")

The service level agreement specifies 99.9% uptime, corresponding
to a maximum of #footnote[Calculated as: $365.25 times 24 times
0.001 = 8.766$ hours of allowable downtime per year.] 8.77 hours
of annual downtime.

== IF-WS: WebSocket Notification Service <sec-if-ws>

=== Overview

The IF-WS interface provides real-time event delivery to subscribed
clients via the WebSocket protocol (RFC 6455). Connections are
upgraded from HTTPS and authenticated using the same API key
mechanism as IF-REST.

=== Event Matrix

// ---- Landscape page ----
// page(flipped: true) rotates the page to landscape
// orientation, useful for wide tables.

#page(flipped: true)[
  #figure(
    table(
      columns: (auto, auto, auto, auto, 1fr, auto, auto),
      inset: 7pt,
      stroke: 0.5pt + luma(180),
      fill: (x, y) => if y == 0 { rgb("#1e3a5f").lighten(85%) } else if calc.odd(y) { luma(248) } else { white },
      table.header(
        strong[Event Type],
        strong[Trigger],
        strong[Scope],
        strong[Priority],
        strong[Payload Fields],
        strong[Latency SLA],
        strong[Retry],
      ),
      [widget.created], [POST /widgets], [Project], [Normal],
      [widget_id, name, status, created_at, actor_id], [< 500ms], [No],
      [widget.updated], [PATCH /widgets/:id], [Project], [Normal],
      [widget_id, changed_fields, version, actor_id], [< 500ms], [No],
      [widget.deleted], [DELETE /widgets/:id], [Project], [High],
      [widget_id, deleted_at, actor_id, cascade_count], [< 200ms], [Yes],
      [widget.status_changed], [Status transition], [Global], [High],
      [widget_id, old_status, new_status, reason], [< 200ms], [Yes],
      [widget.error], [Processing failure], [Project], [Critical],
      [widget_id, error_code, message, stack_trace_id], [< 100ms], [Yes],
      [system.heartbeat], [Timer (30s)], [Connection], [Low],
      [timestamp, server_id, connection_count], [N/A], [No],
    ),
    caption: [IF-WS Event Type Matrix],
  ) <ws-event-matrix>
]

=== WebSocket Frame Structure

// ---- Grid with styled rects for frame diagram ----
#figure(
  block(inset: 10pt,
    grid(
      columns: (80pt, 80pt, 80pt, 1fr),
      rows: (35pt,),
      gutter: 0pt,
      rect(fill: rgb("#dbeafe"), stroke: 1pt + rgb("#3b82f6"), width: 100%, height: 100%,
        align(center + horizon, text(9pt, weight: "bold")[Opcode \ (4 bits)])),
      rect(fill: rgb("#dcfce7"), stroke: 1pt + rgb("#16a34a"), width: 100%, height: 100%,
        align(center + horizon, text(9pt, weight: "bold")[Length \ (7+ bits)])),
      rect(fill: rgb("#fef3c7"), stroke: 1pt + rgb("#d97706"), width: 100%, height: 100%,
        align(center + horizon, text(9pt, weight: "bold")[Mask Key \ (32 bits)])),
      rect(fill: rgb("#f3e8ff"), stroke: 1pt + rgb("#9333ea"), width: 100%, height: 100%,
        align(center + horizon, text(9pt, weight: "bold")[Payload Data \ (variable)])),
    )
  ),
  caption: [WebSocket Frame Structure],
  kind: image,
) <ws-frame>

=== Protocol Notes

// ---- Block with per-side stroke customization ----
// The stroke parameter accepts a dictionary with per-side
// values: top, bottom, left, right.

#block(
  width: 100%,
  inset: 12pt,
  stroke: (
    top: 2pt + rgb("#1e3a5f"),
    bottom: 2pt + rgb("#1e3a5f"),
    left: 0.5pt + luma(200),
    right: 0.5pt + luma(200),
  ),
  fill: luma(250),
)[
  *Connection Lifecycle:*
  + Client sends HTTP upgrade request with `Sec-WebSocket-Protocol: awp.v2`
  + Server validates API key and returns `101 Switching Protocols`
  + Client subscribes to event channels via `subscribe` message
  + Server delivers events as text frames with JSON payloads
  + Either party may send `ping`/`pong` frames for keep-alive
]

#note-box(
  [Connection Limits],
  [Each API key supports a maximum of 100 concurrent WebSocket
  connections. Exceeding this limit returns HTTP 429.],
  kind: "warning",
)

=== Requirements

#requirement("IDD-WS-001", [The IF-WS interface shall deliver
events within the latency SLA defined in @ws-event-matrix.])

#requirement("IDD-WS-002", [The IF-WS interface shall support
automatic reconnection with exponential backoff.], priority: "Shall")

#requirement("IDD-WS-003", [The IF-WS interface should deliver
missed events upon reconnection within a 5-minute
window.], priority: "Should")


== IF-DB: PostgreSQL Database Interface <sec-if-db>

=== Overview

The IF-DB interface defines the internal data persistence layer
between the AWP Core Service and the PostgreSQL database cluster.
This interface is not exposed to external consumers.

=== Schema Definitions

// ---- Nested dictionaries with conditionals ----
// Schema tables generated from nested dictionaries.
// Conditionals control display of nullable/PK badges.

#let db-tables = (
  (
    name: "widgets",
    description: "Primary widget storage",
    columns: (
      (name: "id", type: "UUID", nullable: false, pk: true, default: "gen_random_uuid()"),
      (name: "name", type: "VARCHAR(255)", nullable: false, pk: false, default: "—"),
      (name: "status", type: "widget_status", nullable: false, pk: false, default: "'active'"),
      (name: "config", type: "JSONB", nullable: true, pk: false, default: "'{}'"),
      (name: "version", type: "INTEGER", nullable: false, pk: false, default: "1"),
      (name: "created_at", type: "TIMESTAMPTZ", nullable: false, pk: false, default: "NOW()"),
      (name: "updated_at", type: "TIMESTAMPTZ", nullable: false, pk: false, default: "NOW()"),
    ),
  ),
  (
    name: "widget_events",
    description: "Event audit log",
    columns: (
      (name: "id", type: "BIGSERIAL", nullable: false, pk: true, default: "auto"),
      (name: "widget_id", type: "UUID", nullable: false, pk: false, default: "—"),
      (name: "event_type", type: "VARCHAR(50)", nullable: false, pk: false, default: "—"),
      (name: "payload", type: "JSONB", nullable: true, pk: false, default: "NULL"),
      (name: "actor_id", type: "UUID", nullable: true, pk: false, default: "NULL"),
      (name: "created_at", type: "TIMESTAMPTZ", nullable: false, pk: false, default: "NOW()"),
    ),
  ),
)

// ---- Loop generating multiple figures ----
#for db-table in db-tables [
  #figure(
    table(
      columns: (auto, auto, auto, auto, auto),
      inset: 7pt,
      stroke: 0.5pt + luma(180),
      fill: (x, y) => if y == 0 { rgb("#16a34a").lighten(85%) } else { none },
      table.header(
        strong[Column], strong[Type], strong[Nullable], strong[PK], strong[Default],
      ),
      ..{
        let cells = ()
        for col in db-table.columns {
          cells.push([`#col.name`])
          cells.push([#raw(col.type)])
          // Conditional content based on column properties
          cells.push(
            if col.nullable { text(fill: rgb("#d97706"))[Yes] }
            else { text(fill: rgb("#16a34a"))[No] }
          )
          cells.push(
            if col.pk { text(fill: rgb("#dc2626"), weight: "bold")[PK] }
            else [—]
          )
          cells.push([#raw(col.default)])
        }
        cells
      }
    ),
    caption: [IF-DB Schema: #raw(db-table.name) — #db-table.description],
  )
]

=== SQL Examples

*Index creation for query performance:*

```sql
CREATE INDEX idx_widgets_status ON widgets (status)
  WHERE status != 'archived';

CREATE INDEX idx_events_widget_id ON widget_events (widget_id)
  INCLUDE (event_type, created_at);
```

=== Requirements

#requirement("IDD-DB-001", [The IF-DB interface shall enforce
referential integrity via foreign key constraints.])

#requirement("IDD-DB-002", [The IF-DB interface shall use row-level
locking with `SELECT ... FOR UPDATE SKIP LOCKED` for
concurrent access.], priority: "Shall")

#requirement("IDD-DB-003", [The IF-DB interface should support
point-in-time recovery with a retention period of 30
days.], priority: "Should")

== IF-MQ: RabbitMQ Message Queue Interface <sec-if-mq>

=== Overview

The IF-MQ interface handles asynchronous message processing between
the AWP Core Service and downstream worker services. Messages are
routed through a RabbitMQ broker using topic exchanges.

=== Queue Topology

// ---- Grid with rotate() for rotated labels ----
// rotate() rotates content by a specified angle.

#figure(
  block(inset: 10pt, width: 100%,
    align(center,
      grid(
        columns: (100pt, 50pt, 100pt, 50pt, 100pt),
        rows: (50pt,),
        align: center + horizon,
        rect(width: 100%, height: 100%, fill: rgb("#dbeafe"), stroke: 1pt + rgb("#3b82f6"), radius: 5pt,
          align(center + horizon, text(9pt, weight: "bold")[AWP Core \ Producer])),
        // Rotated arrow label
        rotate(0deg, text(8pt, style: "italic", fill: luma(100))[→ topic →]),
        rect(width: 100%, height: 100%, fill: rgb("#fef3c7"), stroke: 1pt + rgb("#d97706"), radius: 5pt,
          align(center + horizon, text(9pt, weight: "bold")[Exchange \ widget.events])),
        rotate(0deg, text(8pt, style: "italic", fill: luma(100))[→ bind →]),
        rect(width: 100%, height: 100%, fill: rgb("#dcfce7"), stroke: 1pt + rgb("#16a34a"), radius: 5pt,
          align(center + horizon, text(9pt, weight: "bold")[Worker \ Consumer])),
      )
    )
  ),
  caption: [IF-MQ Queue Topology],
  kind: image,
) <mq-topology>

// Second row: queue bindings with rotated text
#figure(
  block(inset: 10pt, width: 100%,
    align(center,
      grid(
        columns: (1fr, 1fr, 1fr),
        rows: (auto,),
        gutter: 8pt,
        block(width: 100%, inset: 8pt, fill: luma(248), stroke: 0.5pt + luma(200), radius: 4pt)[
          #text(9pt, weight: "bold")[Queue: widget.create] \
          #text(8pt)[Binding: `widget.created`] \
          #text(8pt)[#rotate(-3deg, text(fill: rgb("#d97706"))[Priority: Normal])]
        ],
        block(width: 100%, inset: 8pt, fill: luma(248), stroke: 0.5pt + luma(200), radius: 4pt)[
          #text(9pt, weight: "bold")[Queue: widget.process] \
          #text(8pt)[Binding: `widget.updated`] \
          #text(8pt)[#rotate(-3deg, text(fill: rgb("#d97706"))[Priority: Normal])]
        ],
        block(width: 100%, inset: 8pt, fill: luma(248), stroke: 0.5pt + luma(200), radius: 4pt)[
          #text(9pt, weight: "bold")[Queue: widget.critical] \
          #text(8pt)[Binding: `widget.error`] \
          #text(8pt)[#rotate(-3deg, text(fill: rgb("#dc2626"), weight: "bold")[Priority: High])]
        ],
      )
    )
  ),
  caption: [IF-MQ Queue Bindings],
  kind: image,
) <mq-bindings>

=== Message Fields

The following fields are included in all IF-MQ messages.
#underline[Underlined] fields are mandatory in every message.
#strike[Struck-through] fields are deprecated and will be removed
in version 3.0.

- #underline[message_id] — Unique UUID for idempotency
- #underline[event_type] — Event classification string
- #underline[timestamp] — ISO 8601 event timestamp
- #underline[widget_id] — Target widget identifier
- payload — Event-specific data (JSON object)
- actor_id — User or service that triggered the event
- correlation_id — Request tracing identifier
- #strike[legacy_type] — Old event type format (v1 compat)
- #strike[raw_payload] — Unstructured payload string (v1 compat)

=== Message Format Example

```json
{
  "message_id": "msg_a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "event_type": "widget.created",
  "timestamp": "2025-01-15T10:30:00.000Z",
  "widget_id": "wgt_7f3a2b1c-9d4e-4a5f-b6c8-1e2d3f4a5b6c",
  "payload": {
    "name": "Weather Dashboard",
    "status": "active",
    "config": { "theme": "dark" }
  },
  "actor_id": "usr_admin_01",
  "correlation_id": "req_trace_xyz789"
}
```

=== Requirements

#requirement("IDD-MQ-001", [The IF-MQ interface shall guarantee
at-least-once delivery for all messages.])

#requirement("IDD-MQ-002", [The IF-MQ interface shall support
dead-letter queues for messages that fail processing after 3
retry attempts.], priority: "Shall")

#requirement("IDD-MQ-003", [The IF-MQ interface should support
message priority levels (1-10) for queue
ordering.], priority: "Should")


// =============================================================
// SECTION 4: REQUIREMENTS TRACEABILITY
// =============================================================

= Requirements Traceability

// ---- Context-based counter reading ----
// context allows reading the final value of a counter,
// demonstrating layout introspection.

This section maps IDD requirements to source SRS requirements.
A total of #context req-counter.display() requirements are
defined in this document.

#figure(
  table(
    columns: (auto, 1fr, auto),
    inset: 8pt,
    stroke: 0.5pt + luma(180),
    fill: (x, y) => if y == 0 { rgb("#1e3a5f").lighten(85%) } else if calc.odd(y) { luma(248) } else { white },
    table.header(
      strong[IDD Requirement],
      strong[Description],
      strong[SRS Trace],
    ),
    [IDD-REST-001], [JSON payload conformance], [SRS-API-010],
    [IDD-REST-002], [Rate limiting enforcement], [SRS-API-015],
    [IDD-REST-003], [Conditional request support], [SRS-API-020],
    [IDD-REST-004], [Batch operation support], [SRS-API-025],
    [IDD-WS-001], [Event delivery latency SLA], [SRS-RT-001],
    [IDD-WS-002], [Automatic reconnection], [SRS-RT-005],
    [IDD-WS-003], [Missed event delivery], [SRS-RT-010],
    [IDD-DB-001], [Referential integrity], [SRS-DATA-001],
    [IDD-DB-002], [Concurrent access locking], [SRS-DATA-005],
    [IDD-DB-003], [Point-in-time recovery], [SRS-DATA-010],
    [IDD-MQ-001], [At-least-once delivery], [SRS-MSG-001],
    [IDD-MQ-002], [Dead-letter queue support], [SRS-MSG-005],
    [IDD-MQ-003], [Message priority ordering], [SRS-MSG-010],
  ),
  caption: [Requirements Traceability Matrix],
) <req-trace-matrix>


// =============================================================
// SECTION 5: NOTES
// =============================================================

= Notes

== Glossary

/ API: Application Programming Interface — a set of protocols
  and tools for building software applications.
/ AMQP: Advanced Message Queuing Protocol — an open standard
  for message-oriented middleware.
/ CRUD: Create, Read, Update, Delete — the four basic
  operations of persistent storage.
/ CSCI: Computer Software Configuration Item — a software
  element treated as a single entity for configuration
  management purposes.
/ DID: Data Item Description — a form specifying the content
  and format of a data deliverable.
/ IDD: Interface Design Description — a document describing
  the interface characteristics of a system or CSCI.
/ SLA: Service Level Agreement — a commitment between a
  service provider and client defining quality metrics.
/ WebSocket: A communication protocol providing full-duplex
  channels over a single TCP connection.

== Acronyms

// ---- Dictionary-to-table generation via loop ----
// A sorted dictionary of acronyms rendered into a table.

#let acronyms = (
  "AWP": "Acme Widget Platform",
  "CDRL": "Contract Data Requirements List",
  "DB": "Database",
  "HTTP": "Hypertext Transfer Protocol",
  "JSON": "JavaScript Object Notation",
  "MQ": "Message Queue",
  "REST": "Representational State Transfer",
  "RFC": "Request for Comments",
  "SRS": "Software Requirements Specification",
  "SQL": "Structured Query Language",
  "UUID": "Universally Unique Identifier",
  "WS": "WebSocket",
  "WSS": "WebSocket Secure",
)

#figure(
  table(
    columns: (auto, 1fr),
    inset: 7pt,
    stroke: 0.5pt + luma(180),
    fill: (x, y) => if y == 0 { rgb("#1e3a5f").lighten(85%) } else { none },
    table.header(strong[Acronym], strong[Definition]),
    ..for (acr, def) in acronyms {
      (strong[#acr], [#def])
    }
  ),
  caption: [Acronym List],
) <acronym-table>

== Assumptions and Clarifications

+ All timestamps use UTC and conform to ISO 8601 format.
+ Widget IDs are globally unique UUID v4 values generated
  server-side; clients must not generate their own.
+ The IF-DB interface assumes PostgreSQL version 15 or later
  with the `pgcrypto` extension installed.
+ Message queue durability settings assume persistent storage
  with mirrored queues across at least two broker nodes.
+ API versioning follows URI-based strategy (`/v1/`, `/v2/`);
  header-based versioning is not supported.


// =============================================================
// APPENDICES
// =============================================================

// ---- Unnumbered headings ----
// heading(numbering: none) creates headings without section
// numbers, commonly used for appendices.

#heading(level: 1, numbering: none)[Appendix A: Sample Message Schemas]

The following JSON schemas define the structure of IF-MQ messages.

*Widget Created Event Schema:*
```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["message_id", "event_type", "timestamp", "widget_id"],
  "properties": {
    "message_id": { "type": "string", "format": "uuid" },
    "event_type": { "const": "widget.created" },
    "timestamp": { "type": "string", "format": "date-time" },
    "widget_id": { "type": "string", "pattern": "^wgt_" },
    "payload": {
      "type": "object",
      "properties": {
        "name": { "type": "string", "maxLength": 255 },
        "status": { "enum": ["active", "paused", "archived"] }
      }
    }
  }
}
```

#heading(level: 1, numbering: none)[Appendix B: Revision History]

#figure(
  table(
    columns: (auto, auto, 1fr, auto),
    inset: 8pt,
    stroke: 0.5pt + luma(180),
    fill: (x, y) => if y == 0 { rgb("#1e3a5f").lighten(85%) } else { none },
    table.header(
      strong[Version], strong[Date], strong[Description], strong[Author],
    ),
    [1.0], [2024-06-15], [Initial draft — IF-REST and IF-DB interfaces], [J. Smith],
    [1.1], [2024-09-01], [Added IF-WS WebSocket interface], [A. Chen],
    [1.5], [2024-11-15], [Added IF-MQ message queue interface], [R. Patel],
    [2.0], [2025-01-20], [Major revision — updated all interfaces for v2 API], [Acme Team],
  ),
  caption: [Document Revision History],
) <revision-history>
