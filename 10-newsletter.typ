// =============================================================
// 10-newsletter.typ — The Widget Weekly
// =============================================================
// A professional newsletter for the Acme Widget Platform.
// Imports a custom layout template and demonstrates multi-column
// typesetting, pull-quotes, and stylized sidebars.
//
// What you'll learn:
//   - Using a multi-column template
//   - Incorporating images into a layout
//   - Creating high-impact pull-quotes
//   - Organizing content with sidebars and tags
// =============================================================

#import "10-newsletter-template.typ": newsletter-template, pull-quote, sidebar, article-tag

#show: newsletter-template.with(
  title: "The Widget Weekly",
  issue: "Volume 4, Issue 2",
  date: "February 2026",
)

// ---- Lead Article ----

#article-tag("Platform Updates")

= Scaling the Widget API: A Move to V3

As the Acme Widget Platform continues its rapid growth, our engineering team is excited to announce the upcoming transition to *Widget API v3*. This major update addresses the scalability challenges of our legacy v2 architecture and introduces several highly requested features.

#pull-quote[
  "The move to v3 isn't just an upgrade; it's a fundamental reimagining of how widgets interact with global state."
]

The primary shift in v3 is the move from polling-based updates to a reactive, event-driven model. By leveraging our new `IF-WS` WebSocket layer, clients can now receive state changes in real-time with sub-100ms latency.

== Key Improvements in V3
- *Fine-grained Scopes:* Restrict API keys to specific widget types or even individual widget IDs.
- *Batch Processing:* Create up to 500 widgets in a single atomic request.
- *Improved Rate Limiting:* Dynamic limits based on current system load and subscription tier.

#sidebar(title: "In This Issue")[
  - *V3 Roadmap* ............ Page 1
  - *WebSocket Best Practices* .. Page 2
  - *New SDK for Rust* ........ Page 2
  - *Developer Spotlight* ..... Page 3
  - *AcmeCon 2026 Dates* ...... Page 4
]

// ---- Second Article ----

#v(10pt)
#article-tag("Tutorial")

= Mastering Real-Time Sync

Connecting your dashboard to our WebSocket service (IF-WS) is now easier than ever. The new `awp-sync` library handles reconnection, backoff, and state reconciliation automatically.

#figure(
  rect(width: 100%, height: 80pt, fill: luma(240), stroke: 1pt + luma(200), 
    align(center + horizon, text(style: "italic", fill: luma(100))[Architecture Diagram Placeholder])
  ),
  caption: [The new WebSocket sync flow],
)

To get started, simply initialize the client:

```js
const client = new AwpClient({
  apiKey: 'YOUR_KEY',
  realtime: true
});

client.on('widget.update', (evt) => {
  console.log(`Widget ${evt.id} changed!`);
});
```

// ---- Short Blurb ----

#v(10pt)
#article-tag("Community")

= AcmeCon 2026

Mark your calendars! AcmeCon is returning to San Francisco this June. Join 5,000 other developers for three days of deep dives, networking, and the reveal of our new "Smart Widget" engine. Early bird tickets are available until March 15th.

#sidebar(fill: rgb("#1e3a5f").lighten(95%), title: "Quick Tip")[
  Did you know you can use `ETag` headers in V2 to avoid unnecessary data transfer? Always check for a `304 Not Modified` response to save bandwidth!
]

// ---- Bottom Section ----

#v(1fr)

#block(
  width: 100%,
  stroke: (top: 1pt + luma(200)),
  inset: (top: 10pt),
  align(center, text(8pt, fill: luma(120))[
    Published by Acme Widget Co. Engineering Dept. \
    123 Innovation Drive, San Francisco, CA \
    Questions? Contact #link("mailto:dev-support@acmewidget.io")
  ])
)
