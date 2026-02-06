# Typst Examples

A progressive series of [Typst](https://typst.app/) examples that teach the language's features from basics to advanced templates. Each example uses a fictional **Acme Widget API** as a running theme to keep the content grounded and realistic.

## Examples

| File | Topic | Key Concepts |
|------|-------|-------------|
| `01-basics.typ` | Text, Headings, and Paragraphs | Plain text, headings (`=`), bold/italic, inline code, comments, line breaks |
| `02-lists-and-links.typ` | Lists, Links, and Quotes | Bullet lists, numbered lists, nested lists, term lists, `#link()`, `#quote()` |
| `03-code-and-math.typ` | Code Blocks and Math | Fenced code blocks, `#raw()`, inline/display math, fractions, summation |
| `04-images-and-figures.typ` | Images, Figures, and Labels | `#image()`, `#figure()` with captions, labels (`<label>`), cross-references (`@label`) |
| `05-tables.typ` | Tables | `#table()`, column sizing, `table.header()`, cell alignment/fill, `table.cell(colspan:)` |
| `06-page-setup.typ` | Page Layout | Paper size, margins, custom headers/footers, page numbering, `#outline()`, multi-column layout |
| `07-styling.typ` | Set Rules, Show Rules, and Fonts | `#set`, `#show`, custom heading styles, colored text, `#highlight()`, `#line()` |
| `08-template.typ` | Reusable Template | Template function pattern, parameterized styling, title page, exported function |
| `08-template-usage.typ` | Template Usage | `#import`, `#show: template.with(...)`, content inheriting template styles |
| `09-idd-template.typ` | Advanced Template (IDD) | Custom counters, regex show rules, gradients, `place()`, PDF metadata, roman/arabic numbering |
| `09-idd.typ` | Interface Design Description | Footnotes, `#super`/`#sub`, `#underline`/`#strike`, loops, `.map()`, landscape pages, `rotate()` |

## Prerequisites

Install the Typst CLI:

```sh
# macOS / Linux
brew install typst

# Windows (winget)
winget install --id Typst.Typst

# Or download from https://github.com/typst/typst/releases
```

## Usage

Compile a single example to PDF:

```sh
typst compile 01-basics.typ
```

Watch for changes and recompile automatically:

```sh
typst watch 01-basics.typ
```

Compile all examples:

```sh
typst compile 01-basics.typ
typst compile 02-lists-and-links.typ
typst compile 03-code-and-math.typ
typst compile 04-images-and-figures.typ
typst compile 05-tables.typ
typst compile 06-page-setup.typ
typst compile 07-styling.typ
typst compile 08-template-usage.typ
typst compile 09-idd.typ
```

> **Note:** `08-template.typ` and `09-idd-template.typ` are imported by their companion files and are not meant to be compiled directly.

## Structure

The examples are numbered sequentially and designed to be read in order. Each `.typ` file is heavily commented, explaining every concept as it's introduced. The corresponding `.pdf` files are the compiled output.

Files 08 and 09 demonstrate Typst's template/import system. Each pair consists of:
- A **template file** that defines reusable styling and helper functions
- A **usage file** that imports the template and provides document content
