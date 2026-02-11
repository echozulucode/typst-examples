# Gemini Context: Typst Examples

This repository contains a progressive series of [Typst](https://typst.app/) examples designed to teach the language's features from basics to advanced templates.

## Project Overview

*   **Goal:** Teach Typst features through a sequential set of examples.
*   **Theme:** All examples revolve around a fictional **Acme Widget API** to provide realistic context (REST APIs, JSON structures, Database schemas).
*   **Structure:** Files are numbered `01` through `09` and are intended to be studied in order.

## Building and Running

The project requires the [Typst CLI](https://github.com/typst/typst).

### Compile a single example
To generate a PDF from a `.typ` file:
```sh
typst compile 01-basics.typ
```
This will produce `01-basics.pdf`.

### Watch mode
To automatically recompile on file changes:
```sh
typst watch 01-basics.typ
```

### Compile all examples
```sh
typst compile 01-basics.typ && typst compile 02-lists-and-links.typ && typst compile 03-code-and-math.typ && typst compile 04-images-and-figures.typ && typst compile 05-tables.typ && typst compile 06-page-setup.typ && typst compile 07-styling.typ && typst compile 08-template-usage.typ && typst compile 09-idd.typ
```

## File Structure & Content

| File | Topic | Description |
| :--- | :--- | :--- |
| `01-basics.typ` | Basics | Text, headings, paragraphs, bold/italic, comments. |
| `02-lists-and-links.typ` | Lists & Links | Bullet/numbered lists, links, quotes. |
| `03-code-and-math.typ` | Code & Math | Code blocks, raw text, math equations. |
| `04-images-and-figures.typ` | Images | Images, figures, captions, references. |
| `05-tables.typ` | Tables | Table creation, styling, and alignment. |
| `06-page-setup.typ` | Layout | Margins, page numbering, headers/footers. |
| `07-styling.typ` | Styling | Set/show rules, custom fonts, highlighting. |
| `08-template.typ` | **Template** | Defines a reusable document template (do not compile). |
| `08-template-usage.typ` | Usage | Demonstrates using the template from `08-template.typ`. |
| `09-idd-template.typ` | **Template** | Advanced template for an Interface Design Description (do not compile). |
| `09-idd.typ` | IDD | Full IDD document example using `09-idd-template.typ`. |
| `10-newsletter-template.typ` | **Template** | Professional newsletter layout (do not compile). |
| `10-newsletter.typ` | Newsletter | Example of a multi-column professional newsletter. |
| `11-cheatsheet-template.typ` | **Template** | High-density cheatsheet layout (do not compile). |
| `11-git-cheatsheet.typ` | Cheatsheet | Single-page professional Git reference. |
| `12-performance-report.typ` | Report | **Data-driven** report using external JSON data. |
| `13-academic-paper.typ` | Academic | Formal paper with citations, math, and abstract. |
| `14-magazine-template.typ` | **Template** | Long-form magazine template with charts & cover. |
| `14-ai-monthly.typ` | Magazine | 7-page professional AI magazine with custom charts. |

## Key Conventions

*   **Templates:** Files ending in `-template.typ` (like `08-template.typ` and `09-idd-template.typ`) are **modules** meant to be imported. They should not be compiled directly. Compile their "usage" counterparts instead.
*   **Comments:** The `.typ` files are heavily commented to explain features inline.
*   **Theme:** Content consistently refers to "Acme Widget API", "IF-REST", "IF-WS", etc.
*   **Output:** Compiled `.pdf` files are committed to the repository.
