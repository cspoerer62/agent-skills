---
name: lead-sourcing-at-scale
description: Build a target-customer list from public and licensed sources — ICP definition, source selection, enrichment, verification, and scoring — without breaking any platform's ToS. Use before any outreach, and whenever "who should we sell to" is unanswered. Triggers on "find customers", "lead list", "prospects", "ICP", "target list", "who should we sell to", "scrape", "build a list", "find their email".
---

# Lead Sourcing at Scale

**Compliance is upstream: `sales/outbound-compliance` defines what may be collected at all. Read it
before sourcing, not after.** A list you cannot lawfully contact is not an asset, it's a liability
you spent time building.

The core claim of this skill: **list quality beats list size by an enormous margin.** 50 correctly
targeted prospects outperform 5,000 scraped rows, because reply rate is driven by relevance and
relevance is impossible at low precision. Every rule below serves precision.

## Step 1 — ICP definition (do not skip; everything downstream inherits its errors)

Write the ICP as **observable, filterable attributes**, not aspirations. "Growing companies that
value quality" is not an ICP. This is:

| Dimension | Example | Must be |
|---|---|---|
| Industry / vertical | Residential plumbing & heating | Matchable to a code (SIC/NAICS) or a directory category |
| Size band | 4–15 vans, or 5–30 employees | A number with a source |
| Geography | West Yorkshire | Explicit |
| **Trigger event** | Hiring installers; opened 2nd location; new premises | **The most important row** |
| Buying role | Owner/MD (not office manager) | A job title you can verify publicly |
| Disqualifiers | Franchise (no local budget authority); <2 vans; national chains | Written down in advance |

**The trigger event is what turns a list into a pipeline.** A company matching every static
attribute but with nothing changing has no reason to act this quarter. Sort the list by trigger
recency, always.

**Negative ICP is as valuable as positive.** Write who we explicitly do *not* sell to, and why. It
prevents a future cycle from re-litigating it.

## Step 2 — source selection

Ranked by quality of the resulting list. Prefer the top of this table.

| Tier | Source | Gets you | Notes |
|---|---|---|---|
| **1** | **Official registries** — Companies House (UK), SEC/EDGAR, state business registries, charity registers | Legal name, incorporation date, officers, filings, registered address | Free, authoritative, grade-A, bulk-downloadable, explicitly public. Massively under-used |
| **1** | **Licensed data APIs** used within license | Firmographics, contacts, tech stack | Costs money, legally clean, ToS-compliant |
| **1** | **Official platform APIs** (with keys, within ToS/rate limits) | Varies | The lawful version of "scraping" a platform |
| **2** | **Company's own website**, read politely, robots.txt respected | Published contact, team, services, pricing, locations | Grade A for their own claims. The `/contact` and `/team` pages are the intended route |
| **2** | **Job boards / hiring pages** | **Trigger events**, headcount growth, tech stack, pain | The single best trigger source. A job ad is a company describing its own problem in public |
| **2** | **Public procurement / tender portals, planning applications, licence registers** | Trigger events, budget, project timing | Extremely high-signal, near-zero competition |
| **3** | **Industry associations, trade bodies, accreditation registers** | Vetted member lists, often with contact | Usually public, usually well-structured |
| **3** | **Public review sites / directories** (read-only, public pages, no login) | Existence, category, location, sentiment | Check each one's ToS individually |
| **3** | **Conference / exhibitor lists, award shortlists, local press** | Named companies + a trigger | Good for relevance sentences |
| **✗** | Login-walled platform scraping, CAPTCHA bypass, purchased lists of unknown provenance, email permutation-guessing | — | **Prohibited.** See compliance skill for why each one is business-destroying, not merely rude |

### On "scraping"

The word covers two very different acts. **Reading public pages a company published for the public,
at polite rate, honoring robots.txt, is legitimate research.** Logging into a platform to extract
its proprietary dataset at volume is a ToS breach that risks the customer-facing account and, in
some jurisdictions, worse. This skill does the first and never the second.

Practical politeness rules for the legitimate kind: identify honestly in User-Agent, ≤1 request/sec
per host, honor `robots.txt` and `Crawl-delay`, cache so you never fetch twice, back off on 429/503,
and stop entirely if a site signals it doesn't want automated reads.

## Step 3 — enrichment

For each company, aim for this row. Anything you can't fill from a permitted source stays empty —
**never guess a field**, especially email.

```
company | legal_name | website | category | size_signal | location |
trigger_event | trigger_date | trigger_source_url |
contact_name | contact_role | contact_route | contact_source_url |
lawful_basis | date_collected | score
```

Two provenance columns (`*_source_url`) are mandatory: they make the relevance sentence writable
later, and they make the lawful basis auditable. A row without provenance is grade-E and doesn't
get contacted (`thinking/evidence-grading`).

**Contact route, in preference order:** published role address for the right function → published
personal business address → contact form → phone → postal. **Guessed/permuted addresses are never
used** — they hit spam traps and kill the domain.

## Step 4 — verification

- Company still trading (registry status, site live, recent activity).
- Not already a customer, competitor, or on the **suppression list**.
- Size band actually matches (a 2-person firm posing as national is common).
- Contact still holds the role (compare page dates).
- Trigger event is **recent** — a hiring post from 14 months ago is not a trigger.
- Email syntax + MX check where a published address exists. Bounce >3% on a test tranche → stop and
  clean the whole list before sending more.

## Step 5 — scoring and sequencing

Score 0–10; sort descending; work top-down. Weight roughly:

- **Trigger recency & strength — 40%** (weeks old and specific ≫ months old and vague)
- **ICP fit — 25%** (how many dimensions match exactly)
- **Reachability — 20%** (named human + published address ≫ generic contact form)
- **Deal size potential — 15%**

Then **stratify into test tranches of ~50** from one segment. Never send to the whole list at once:
a 500-send blast with a bad relevance sentence burns 500 prospects and teaches you one thing. Ten
tranches of 50 teach you ten things and keep 450 in reserve.

## Anti-patterns

| Anti-pattern | Why it fails |
|---|---|
| Bigger list to fix low reply rate | Converts a targeting problem into a reputation problem |
| One list, all industries | Fixed sentences can't be true for everyone → no relevance → no replies |
| Buying a 100k-row list | Unknown consent, stale, spam-trap-laden, and everyone else already mailed it |
| Guessing emails | Spam traps; domain death |
| No trigger column | List of companies with no reason to act now |
| Sourcing before ICP | You will rationalize the ICP to fit whatever you found |
| No provenance columns | Can't write relevance, can't prove lawful basis |

## Boundaries

- Public pages, official APIs, licensed data, public registries **only**. No login-walled
  extraction, no CAPTCHA/paywall bypass, no volume platform scraping — regardless of what a library
  makes technically easy.
- No special-category personal data, ever. No personal (non-business) contact details.
- `web_fetch` retrieves static HTML only — **JS-rendered directories will silently return nothing
  useful.** Note that as a gap rather than concluding "no results found"; a headless browser or a
  licensed API is the fix, and that's an operator-side capability request.
- I build, score, and document the list. **I cannot send to it** — that's `sales/outbound-sequences`
  drafting plus a human pressing send.
- Every list ships with its provenance and lawful-basis columns populated, or it doesn't ship.
