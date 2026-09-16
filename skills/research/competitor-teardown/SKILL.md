---
name: competitor-teardown
description: Analyze a competitor from public evidence into a decision — positioning, pricing, ICP, go-to-market, weaknesses, and the wedge available to us. Use before entering a market, before pricing, and before writing a landing page. Triggers on "competitors", "who else does this", "how do they price", "differentiate", "market landscape", "are we too late", "competitive analysis".
---

# Competitor Teardown

A competitor analysis that ends in a table is wasted work. It must end in **a decision**: the wedge
we take, the price we set, or the conclusion that we don't enter.

Uses `research/public-web-research-at-scale` to gather and `thinking/evidence-grading` to grade.
Feeds `business/offer-design`, `business/unit-economics`, and `design/web-page-build`.

## Reframe first: competitors are not who you think

Before analyzing named vendors, identify the **actual** alternatives, in this order of likelihood:

1. **Doing nothing** — the most common and most-underestimated competitor. The status quo has zero
   switching cost and infinite political safety.
2. **A spreadsheet / whiteboard / WhatsApp group** — how the job is *really* done in SMB markets.
3. **A person** — a part-time admin, a bookkeeper, an agency.
4. **An adjacent tool being misused** — the CRM used as a scheduler.
5. **Named direct competitors** — usually the smallest share of the decision.

**If the real competitor is "nothing," the offer's job is to overcome inertia, not to beat features.**
That completely changes the landing page, the pricing, and the sales motion. Getting this wrong is
the most expensive error in this skill.

## What to collect per competitor (all grade-A: their own published material)

| Field | Where | Why it matters |
|---|---|---|
| Positioning one-liner | Homepage `<h1>` | Their claimed wedge, in their words |
| Target customer | Homepage, case studies, "who it's for" | Reveals the segment they've *conceded* |
| **Pricing & packaging** | Pricing page (screenshot/quote verbatim + date) | Sets the market's price anchor |
| Feature surface | Product/features pages, changelog, docs | Depth vs breadth |
| Proof | Logos, case studies, review counts | How much trust they've banked |
| Onboarding friction | Signup flow — self-serve vs "book a demo" | Demo-gate = high ACV, slow, weak self-serve |
| GTM channel | Blog cadence, ads, SEO footprint, directories, job posts | Where they spend, where they don't |
| Company shape | Registry filings, headcount signals, funding, job posts | Can they respond to us? How fast? |
| Weakness signals | Reviews (1–3 star specifically), support forums, churn complaints, stale changelog | Where the wedge is |
| Last shipped | Changelog/blog/release notes date | Stale >12mo = a sleeping incumbent = opportunity |

**"No pricing published" is itself a finding**: it means enterprise/negotiated, which means slow
sales, which means a self-serve wedge is open underneath them.

### Highest-signal sources, in order

1. **Their pricing page** — grade A, quote it verbatim with the fetch date.
2. **Their 1–3 star public reviews** — the single richest source. Sort by lowest, read 20, and
   **tally the complaints.** Recurring complaints are the product spec for your wedge. Individual
   reviews are grade C; a tally of 20 is a real pattern.
3. **Their job postings** — where they're investing next, and their stack. A company hiring 5
   enterprise AEs is moving upmarket and abandoning the small end.
4. **Their changelog** — velocity and direction, or its absence.
5. **Their docs/API** — real capability, unfiltered by marketing.
6. **Forums/subreddits where their users complain** — unvarnished, and where switching intent shows up.

## Step 2 — the grid

Rows = the 3–6 **buying criteria the customer actually uses** (from real discovery, not invented).
Columns = doing-nothing, the spreadsheet, and 2–4 named competitors. Cells = evidence + grade, not
opinion.

Two rules that keep this honest:
- **Score them generously.** A teardown where we win every row is a fantasy that will be corrected
  by the market at full price. Find the rows where they genuinely beat us and write them down.
- **The criteria must come from customers.** A grid built on criteria we chose because we win them
  is marketing, not research.

## Step 3 — find the wedge

A wedge is a **segment + criterion where the incumbent is structurally unable to compete** — not
merely currently worse. Structural means their business model, not their backlog.

| Wedge type | Signal | Why it's structural |
|---|---|---|
| **Segment abandonment** | They moved upmarket (enterprise hires, "contact sales", min seats) | Their cost structure can't serve small accounts profitably |
| **Price umbrella** | High price, high margin, no low tier | A cheap tier cannibalizes their core revenue — they won't |
| **Onboarding gate** | Demo-only, long implementation | Self-serve requires rebuilding the org, not a feature |
| **Neglect** | Stale changelog, unanswered support | Attention is elsewhere; won't return |
| **Complaint cluster** | Same 1-star complaint for 2+ years | If it were cheap to fix, it'd be fixed. It's architectural |
| **Geography / vertical gap** | No local presence, no vertical language | Requires local ops or domain depth they lack |
| **Integration gap** | Missing the tool your segment actually uses | Roadmap reflects their ICP, not yours |

**Feature parity is not a wedge.** "Same but nicer" loses to distribution every time. If the only
answer is "we'd be better," there is no wedge — say so. **"Don't enter" is a legitimate and valuable
output of this skill**, and cheaper than discovering it after building.

## Step 4 — the decision (mandatory output)

```
TEARDOWN: <market>                                   date: <>

REAL ALTERNATIVES (ranked by what customers actually do)
1. ... 2. ... 3. ...

PRICE ANCHOR
<verbatim from pricing pages, with urls + fetch dates. The number a prospect
 already has in their head.>

GRID
| Criterion (customer-sourced) | Nothing | Spreadsheet | Comp A | Comp B | Us |

THE WEDGE
Segment: <narrow>
Criterion: <the one thing>
Why structural: <their model prevents responding>
Evidence: <grades + urls>

PRICING IMPLICATION       -> business/unit-economics
POSITIONING LINE          -> design/web-page-build
KILL CRITERIA             -> thinking/decision-quality
  "We abandon this if <observable> by <date>."

WHAT I COULD NOT VERIFY
<gaps, failed fetches, JS-only pages, unpublished pricing>
```

## Failure modes

| Symptom | Cause | Fix |
|---|---|---|
| Grid where we win everything | Criteria chosen to flatter us | Source criteria from customers; score rivals generously |
| Only named SaaS competitors listed | Missed status quo / spreadsheet | Redo step 1 — "nothing" is usually the leader |
| Feature-list comparison | Treated it as a product exercise | Ask what the *buyer* decides on; mostly not features |
| Conclusion "we'd do it better" | No wedge found, unwilling to say so | Say "no wedge." That's the finding |
| Pricing from a review site | Not from source | Fetch their pricing page; quote verbatim + date |
| Analysis rots in 3 months | No re-check trigger | Set a re-run date and a trigger (competitor raises, launches, or reprices) |

## Boundaries

- **Public evidence only**: their published pages, public registries, public reviews, official APIs.
- **No competitive intelligence by deception** — no fake trial signups under invented identities, no
  posing as a customer to extract pricing, no contacting their staff under pretext, no NDA'd or
  leaked material. It is a small market; this gets found out, and it converts a competitor into an
  enemy with a story.
- A trial signup under our **real** identity to evaluate a product is fine and normal.
- No login-walled scraping of review platforms; read public pages only.
- Quote pricing **verbatim with a date** — paraphrased pricing is how a business builds a model on a
  number that was never real.
