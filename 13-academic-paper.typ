// =============================================================
// 13-academic-paper.typ — Academic Paper Example
// =============================================================
// This example demonstrates formal academic typesetting.
//
// What you'll learn:
//   - Using citations and bibliographies with #cite and #bibliography
//   - Complex mathematical formulas and proofs
//   - Multi-author formatting
//   - Professional academic layout (abstract, columns, numbering)
// =============================================================

#import "13-paper-template.typ": paper-template

#show: paper-template.with(
  title: [Towards Optimal Consistency in Distributed Widget State Synchronization],
  authors: (
    (name: "John Smith", affiliation: "Acme Labs", email: "jsmith@acme.io"),
    (name: "Jane Doe", affiliation: "University of Widgets", email: "j.doe@uow.edu"),
  ),
  abstract: [
    As distributed systems grow in complexity, maintaining consistent state
    across heterogeneous nodes remains a significant challenge. In this paper,
    we present a novel approach to widget state synchronization that leverages
    probabilistic data structures to minimize bandwidth consumption while 
    guaranteeing eventual consistency. Our results show a 40% reduction in
    tail latency compared to traditional consensus algorithms.
  ],
  keywords: ("Distributed Systems", "State Sync", "Performance", "Typst"),
)

= Introduction

The rise of the Acme Widget Platform has necessitated a new look at
consistency models in high-concurrency environments @widget2025. 
Traditional approaches like Paxos and Raft provide strong consistency 
but often at the cost of significant latency @latency2024.

As noted in @api-design, the trade-off between availability and 
consistency is fundamental to system design.

= Mathematical Model

We define the widget state $S$ as a vector in the space of all possible
configurations $Omega$. The synchronization process can be modeled as
a transformation function $T$:

$ T(S_t, Delta) = S_(t+1) $

where $Delta$ represents the set of updates applied at time $t$. The
expected convergence time $E[C]$ is given by:

$ E[C] = sum_(i=1)^n P(i) times log(1/epsilon) $

In our model, the error margin $epsilon$ must satisfy the condition:

$ epsilon < sqrt((mu + sigma) / (2 pi n)) $

= Methodology

Our experiments were conducted across a cluster of 500 nodes. We
evaluated the performance of the $omega$-sync algorithm under varying
network conditions.

== Latency Distribution

$ f(x; mu, sigma) = 1 / (sigma sqrt(2 pi)) exp( - (x - mu)^2 / (2 sigma^2) ) $

The results indicate that our method significantly reduces the
standard deviation $sigma$ of response times during network partitions.

= Conclusion

By adopting a probabilistic approach to synchronization, we can achieve
high performance without sacrificing the integrity of the widget 
lifecycle. Future work will explore the integration of these models
into the Widget API v3 core.

// ---- Bibliography ----
// Typst handles Citations and Bibliography automatically.
// The "apa" style is one of many available (ieee, mla, etc).

#set bibliography(style: "apa", title: [References])
#bibliography("13-references.bib")
