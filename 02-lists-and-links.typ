// =============================================================
// 02-lists-and-links.typ — Lists, Links, and Quotes
// =============================================================
// What you'll learn:
//   - Bullet lists (-)
//   - Numbered lists (+)
//   - Nested lists via indentation
//   - Term / definition lists (/ Term: ...)
//   - Auto-detected links and #link()
//   - Block quotes with #quote()
// Ref: https://typst.app/docs/reference/syntax/
// =============================================================

= Acme Widget API — Feature Overview

// ---- Bullet lists ----
// Start a line with `-` followed by a space.

== Supported Operations

- Create a new widget
- Retrieve widget details
- Update widget properties
- Delete a widget
- List all widgets with pagination

// ---- Numbered lists ----
// Start a line with `+` followed by a space.
// Typst auto-numbers them for you.

== Quick-Start Steps

+ Sign up for a developer account.
+ Generate an API key in the dashboard.
+ Install the SDK for your language.
+ Make your first `GET /widgets` request.
+ Inspect the JSON response.

// ---- Nested lists ----
// Indent with two (or more) spaces to nest items.

== SDK Components

- Core library
  - HTTP client
  - Request signing
  - Response parsing
- Plugins
  - Caching middleware
  - Retry handler
    - Exponential backoff
    - Jitter support

// ---- Term / definition lists ----
// Syntax: `/ Term: description`

== Glossary

/ Widget: A configurable unit of functionality exposed through the API.
/ Endpoint: A URL path that accepts HTTP requests (e.g., `/widgets`).
/ API Key: A secret token used to authenticate requests.
/ Rate Limit: The maximum number of requests allowed per minute.

// ---- Links ----
// Bare URLs are auto-detected and become clickable.

== Useful Links

Visit the developer portal: https://developer.example.com

// Use `#link()` for custom link text.

See the
#link("https://developer.example.com/docs")[full API reference]
for endpoint details.

File a bug on the
#link("https://github.com/acme/widgets/issues")[issue tracker].

// ---- Block quotes ----
// Use `#quote()` for block quotations.
// The `block: true` parameter renders it as a block element.
// The `attribution` parameter adds a citation.

== What Our Users Say

#quote(block: true, attribution: [Jane Doe, CTO of WidgetCorp])[
  The Acme Widget API cut our integration time from weeks to
  hours. The documentation is clear and the SDK just works.
]

#quote(block: true, attribution: [Typst Documentation])[
  Typst is a new markup-based typesetting system that is
  designed to be as powerful as LaTeX while being much easier
  to learn and use.
]
