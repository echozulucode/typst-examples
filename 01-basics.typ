// =============================================================
// 01-basics.typ — Text, Headings, and Paragraphs
// =============================================================
// What you'll learn:
//   - Plain text and paragraph breaks
//   - Headings (=, ==, ===)
//   - Bold, italic, and inline code
//   - Single-line and block comments
//   - Manual line breaks
// Ref: https://typst.app/docs/tutorial/writing-in-typst/
// =============================================================

// ---- Plain text ----
// Just start typing. Typst treats consecutive lines as part
// of the same paragraph until it encounters a blank line.

Welcome to the Acme Widget API documentation. This guide walks
you through every feature of the Widget platform so you can
integrate quickly and ship with confidence.

// ---- Paragraph breaks ----
// A blank line between text creates a new paragraph.

The Widget API follows RESTful conventions and returns JSON
responses for every endpoint. Authentication is handled via
API keys passed in the `Authorization` header.

// ---- Headings ----
// Use `=` for a level-1 heading, `==` for level 2, etc.
// There must be a space after the `=` signs.

= Getting Started

== Prerequisites

You need an Acme developer account and a valid API key.
Visit the developer portal to generate your credentials.

=== Supported Platforms

The SDK is available for Python, JavaScript, and Go.
Community wrappers exist for Rust and Ruby.

// ---- Emphasis ----
// Surround text with `*` for *bold* and `_` for _italic_.
// You can nest them: `*_bold italic_*`.

*Important:* all API keys are _scoped_ to a single project.
Do not share keys across projects. If a key is compromised,
revoke it *_immediately_* from the dashboard.

// ---- Inline code ----
// Wrap text in backticks for inline code: `code`.

Call the `GET /widgets` endpoint to list all widgets. The
response includes an `id`, a `name`, and a `status` field.

// ---- Comments ----
// Single-line comments start with `//` (like this one).
// Block comments use `/* ... */` and can span multiple lines.

/* This block comment is ignored by the compiler.
   Use block comments to temporarily disable
   large sections of content. */

// ---- Line breaks ----
// A backslash `\` at the end of a line forces a line break
// without starting a new paragraph.

Acme Widget Co. \
123 Innovation Drive \
San Francisco, CA 94107
