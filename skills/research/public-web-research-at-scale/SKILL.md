---
name: public-web-research-at-scale
description: Run a multi-source web investigation that produces an auditable answer instead of a confident guess — query strategy, source hierarchy, fetch discipline, contradiction handling, and knowing when to stop. Use for any question needing more than one lookup: market sizing, company investigation, technical due diligence, "is this real". Triggers on "research", "find out", "how big is", "who are the", "is it true that", "due diligence", "market size", "investigate", "look into".
---

# Public Web Research at Scale

Pairs with `thinking/evidence-grading` (which grades the claims) — this skill is about **getting**
the claims: what to search, what to fetch, in what order, and when to stop.

The failure mode it kills: an agent runs one search, reads the top three SEO results, and produces
a fluent report whose every number traces back to the same content-marketing blog post.

## Principle: search to find the primary source, then go read it

Search results are a **map to primary sources, not evidence themselves.** A listicle saying "the
market is $4.2B" is grade D. Its value is that it may name the analyst firm — and *that* report,
or the filing, is what you actually cite. **Always take one more hop toward the origin.**

The chain almost always looks like:

```
SEO blog post (D)  →  names a report (C)  →  report's own page w/ methodology (B)  →  the filing / dataset / API (A)
```

Most research stops at hop 1. The entire difference in output quality is hops 2–4.

## Step 1 — decompose before searching

Write the question, then break it into **sub-questions that each have a factual answer and a
plausible source type.** Searching the headline question directly is what lands you in SEO content,
because the headline question is exactly what content marketers target.

Example — "Is there a business in dispatch software for UK trade firms?"

| Sub-question | Source type | Expected grade |
|---|---|---|
| How many UK firms in SIC 43.22, by employee band? | ONS / Companies House bulk data | A |
| What do incumbents charge? | Vendors' own pricing pages | A |
| What do users complain about? | Public reviews, forums, trade subreddits | C, but aggregate = signal |
| Are firms hiring for scheduling roles? | Job boards | A (primary observation) |
| Is anyone funded in this space recently? | Filings, press releases | A/B |

**Write the sub-question table before the first search.** It prevents the drift where you research
whatever the internet happens to serve you.

## Step 2 — query strategy

- **Vary the register.** How a practitioner phrases it ≠ how a marketer phrases it. Search both:
  `dispatch software pricing` (marketer) vs `how do you schedule 8 vans` (practitioner). The second
  finds forums, which is where the truth about problems lives.
- **Use site/filetype operators** to jump straight to primary sources: `site:gov.uk`,
  `site:ons.gov.uk`, `filetype:pdf annual report`, `site:sec.gov`.
- **Search for the negative.** `<thing> problems`, `<thing> alternatives`, `<thing> cancel`,
  `<vendor> vs`. Critical sources are more informative than promotional ones and rank lower.
- **Search the specific number** you were given, in quotes, to find its origin and see how many
  "independent" sources are laundering one press release.
- **Date-bound it.** Add the year, or restrict recency. Undated pages are grade D on principle.
- **Try the practitioner venues directly**: trade forums, subreddits, Stack Exchange, association
  publications, local trade press. Low SEO competition, high truth density.

## Step 3 — fetch discipline

`web_search` gives titles and snippets; **snippets are not evidence.** Fetch the page.

- **Fetch the actual page** before citing it. A snippet is often the opposite of the article's
  conclusion.
- **Record fetch date and publication date separately.** Both matter; a 2019 stat is C at best in 2026.
- **If a fetch fails, that is data, not a gap to paper over.** Record it as grade E with the reason
  (paywall, 403, JS-only, dead link). "I could not verify this" is a legitimate and useful finding.
- **Know the tool's limits and say so**: `web_fetch` returns static HTML only. JS-rendered pages,
  infinite-scroll apps, and login-walled content return nothing useful — that's a **tooling gap to
  report**, never "no information exists." Confusing the two is how an agent invents a conclusion.
- **Never fabricate a URL or a citation.** If you can't produce the link, you don't have the source.
- Respect robots.txt and rate-limit politely (≤1 req/sec/host); cache so you never fetch twice.

## Step 4 — triangulation and contradictions

Require **two independent sources** for any load-bearing claim — and check independence by tracing
each to its origin. Two outlets citing the same press release is **one** source.

When sources contradict, **do not average them and do not silently pick one.** Resolve in this order:
1. Is one closer to primary? Prefer it.
2. Do they measure different things? (Revenue vs bookings; "users" vs "paying users"; different
   geography or year.) This is the answer ~70% of the time — the contradiction is definitional.
3. Is one stale? Prefer recent, note the trend.
4. Does one have a disclosed methodology and an N? Prefer it.
5. **Unresolved → report the range and the disagreement explicitly.** A documented range is an
   honest finding; a false point estimate is not.

**Triangulate across source *types*, not just documents.** Official data + vendor pricing + user
complaints + hiring activity, all agreeing, is strong. Four blog posts agreeing is one blog post.

## Step 5 — stopping rules

Stop when any is true:
- Every sub-question has ≥1 A/B source, and load-bearing ones have two independent.
- New searches return sources you've already seen (**saturation** — the real signal).
- Remaining unknowns wouldn't change the decision (per `thinking/decision-quality`).
- The unknown needs a capability you don't have (browser, paid data, a customer conversation) —
  stop and **name the capability**; that's the finding.

Anti-pattern: researching until it *feels* thorough. Depth ≠ time spent. The sub-question table
tells you when you're done; feelings don't.

## Output format

```
QUESTION
<the decision this serves>

ANSWER
<2–4 sentences. Confidence stated. Lead with the answer, not the process.>

SUB-QUESTIONS
| Q | Answer | Grade | Source (url, publisher, pub date, fetched) |

CONTRADICTIONS
<what disagreed, how resolved, or the unresolved range>

WHAT I COULD NOT VERIFY
<grade D/E items, failed fetches, tooling gaps — explicitly listed>

WHAT WOULD CHANGE THE ANSWER
<the specific fetch/experiment that would move it>
```

The last two sections are **mandatory**. A report without them reads as more certain than it is,
which is the harm this skill exists to prevent.

## Failure modes

| Symptom | Cause | Fix |
|---|---|---|
| All sources are blogs | Searched the headline question | Decompose; use site: operators for primary data |
| Confident market size, no N | Number laundered through aggregators | Search the number in quotes; find origin or strike it |
| "No information available" | JS-only pages returned empty | Report tooling gap, don't conclude absence |
| Report is 3,000 words, decision unchanged | No sub-question table; researched for its own sake | Apply stopping rules |
| Sources all agree suspiciously | One origin, many republishers | Trace independence |
| Only positive sources | Never searched the negative | Add `problems`/`alternatives`/`vs` queries |

## Boundaries

- Public pages, official APIs, licensed data, public registries only. No login-walled extraction,
  no CAPTCHA/paywall bypass (`sales/outbound-compliance` governs).
- No fabricated citations, ever. No inferred URLs.
- Findings exit via `surface_finding` **with a provenance block** — nothing graded D/E appears in
  a summary field (`thinking/evidence-grading`, hard rule).
