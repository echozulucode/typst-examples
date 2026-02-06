# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A progressive series of Typst examples teaching the language from basics to advanced templates. All examples use a fictional "Acme Widget API" as a consistent theme. Files are numbered sequentially and designed to be read in order.

## Build Commands

```sh
# Compile a single example
typst compile 01-basics.typ

# Watch for changes (auto-recompile)
typst watch 01-basics.typ

# Compile all standalone examples
typst compile 01-basics.typ && typst compile 02-lists-and-links.typ && typst compile 03-code-and-math.typ && typst compile 04-images-and-figures.typ && typst compile 05-tables.typ && typst compile 06-page-setup.typ && typst compile 07-styling.typ && typst compile 08-template-usage.typ && typst compile 09-idd.typ
```

There is no test suite, linter, or CI pipeline.

## Architecture

**Files 01-07** are self-contained single-file examples, each covering one topic area.

**Files 08-09** use Typst's import/template system as paired files:
- `08-template.typ` defines a reusable `template()` function (page setup, heading styles, title page, TOC). `08-template-usage.typ` imports and applies it via `#show: template.with(...)`.
- `09-idd-template.typ` defines `idd-template()` plus exported helpers (`requirement()`, `if-badge()`, `note-box()`, `req-counter`). `09-idd.typ` imports all of these and builds a full MIL-STD-498 Interface Design Description.

**Template files (`08-template.typ`, `09-idd-template.typ`) are not compiled directly** — only their companion usage files produce PDFs.

## Conventions

- Every `.typ` file starts with a comment block listing what concepts it teaches and reference links.
- Inline comments explain each Typst feature as it's introduced.
- The repository enforces LF line endings (`.gitattributes`).
- PDFs are checked into the repo as compiled output.
