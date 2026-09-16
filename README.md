# agent-skills

Skill library for **hl-independent-agent** (the autonomous agent Carl runs outside the trading fleet).

Built 2026-09-16 from a survey of what is actually on GitHub, plus a read of the skill loadout already
running on the research station (Carl's "master agent Claude" — `cspoerer62/trading-research`
→ `station/claude-home/skills`, 140 skills).

Carl's brief: *"make yourself as smart as possible, be the best business owner possible — web page
building, design, searching companies, finding opportunities, video, images/artwork, sales, scraping
to find target customers then contacting them — all business skills and thinking skills, and load them."*

---

## ⚠️ Runtime channel status — read this before following any skill's escalation instruction

**Every skill in this library says "the correct output is a `surface_finding`". That tool is
currently dead.** Until `/data` is fixed, read every such instruction as **"open a GitHub issue"**.

| Tool | Status (verified live 2026-09-16 23:00Z) | Use for |
|---|---|---|
| `surface_finding` | **BROKEN** — `EACCES: permission denied, mkdir '/data/journal'`. Failed on three separate cycles. | Intended channel. Re-test once per cycle, at the end, with real content — never assume it succeeded. |
| `write_journal` / `read_journal` / `list_journal_dates` | **BROKEN** — same `/data` `EACCES` | — |
| `github_open_issue` | **WORKING** — verified. Works on every repo, including the four excluded ones. | **The live escalation channel.** |
| `github_write_file` to `cspoerer62/agent-journal` | **WORKING** — verified | Durable memory while the journal tools are down. |

All four `/data`-backed tools share one failure. A channel that fails silently is the worst
failure mode there is: two cycles of escalations went nowhere before anyone tried calling the tool
and reading the result. **A tool call is not done until it returns ok.**

Full operating doctrine for this, including what an escalation must contain, lives in
[`business-operations-library/ops/compliance-line.md`](https://github.com/cspoerer62/business-operations-library/blob/main/ops/compliance-line.md) §3.

---

## What is in here

### 1. Original skills (18) — written by me, `skills/`

These are the capabilities that did **not** exist anywhere I could find as an installable skill,
or that existed only in generic form and needed to be wired to *this* operator's reality.

**Thinking / decision quality**
| Skill | What it buys |
|---|---|
| `thinking/decision-quality` | Pre-decision checklist: reversibility, base rates, kill criteria written *before* the bet |
| `thinking/evidence-grading` | Grades every claim A–E by source class; the anti-bullshit layer under any finding |
| `thinking/first-principles-business-model` | Strips a business to unit economics + a falsifiable demand hypothesis |
| `thinking/premortem-red-team` | Assumes the plan already failed and works backwards for the cause |

**Business**
| Skill | What it buys |
|---|---|
| `business/opportunity-scan` | Structured sweep for real, priced, reachable demand — not "ideas" |
| `business/unit-economics` | CAC/LTV/payback/margin math before anything is built |
| `business/offer-design` | Turns a capability into a priced, risk-reversed offer someone can say yes to |
| `business/experiment-engine` | Runs growth as a queue of sized, time-boxed, pre-registered experiments |

**Sales**
| Skill | What it buys |
|---|---|
| `sales/pipeline-and-closing` | Stage definitions, disqualification discipline, discovery → close |
| `sales/outbound-sequences` | Multi-touch sequences that survive a skeptical reader |
| `sales/outbound-compliance` | CAN-SPAM / GDPR / CASL / Twilio-A2P before a single message is sent |

**Research / customer finding**
| Skill | What it buys |
|---|---|
| `research/lead-sourcing-at-scale` | ICP → sourced, verified, scored lead sheet, with evidence per row |
| `research/competitor-teardown` | Read another company's business model off its public surface |
| `research/public-web-research-at-scale` | Fetch/search/parse discipline: robots, rate limits, provenance |

**Design / build**
| Skill | What it buys |
|---|---|
| `design/web-page-build` | Landing page → deployable static/Next.js artifact, conversion-ordered |
| `design/brand-and-design-system` | Tokens, type scale, color logic — enforced instead of vibed |

**Media**
| Skill | What it buys |
|---|---|
| `media/video-production` | Script → storyboard → programmatic render (Remotion/Hyperframes) or model gen |
| `media/image-generation` | Prompt architecture for stills/artwork + the model-selection tradeoff table |

All 18 verified present by directory listing on 2026-09-16 23:00Z
(business 4, sales 3, research 3, design 2, media 2, thinking 4).

### 2. Upstream registry — `registry.json`

~160 vetted third-party skills that are better than anything I would write from scratch, with
`source`, `path`, `category`, `license`, `why`. Installer: `install.sh`.
The single highest-value upstream repo is **`coreyhaines31/marketingskills`** (MIT, 50k★, 50
marketing skills: `cold-email`, `prospecting`, `cro`, `copywriting`, `pricing`, `ads`, `video`,
`image`, `seo-audit`, `revops`, …). Its `prospecting` skill contains a compliance guardrail
section I agree with verbatim.

### 3. Decision log — `docs/DECISIONS.md`

What I chose, what I rejected, and why. Includes the reputability bar and the *residual gap* list
— things that need Carl (API keys, browser tool, sender domain) rather than more skills.

### 4. Gap analysis — `docs/EXISTING-LOADOUT-AND-GAPS.md`

The station's 140 installed skills, diffed against the business brief. Short version: the fleet's
master agent is **very** strong at research, finance, and engineering process, and had **zero**
coverage of video, image/artwork generation, outbound sales, or lead sourcing.

### 5. Audit — `docs/AUDIT-2026-09-16.md`

Half this library was recorded as complete before it was written. That audit is the correction, and
the reason the README now states verification dates instead of intentions.

---

## The operations layer — `business-operations-library`

Skills tell you how to do a thing well. They do not tell you what to do on a Tuesday. The runbook
layer lives in a separate repo and is the intended companion to this one:

| Runbook | Purpose |
|---|---|
| [`ops/compliance-line.md`](https://github.com/cspoerer62/business-operations-library/blob/main/ops/compliance-line.md) | Hard lines vs. operating lines; the escalation ladder |
| [`ops/weekly-operations-checklist.md`](https://github.com/cspoerer62/business-operations-library/blob/main/ops/weekly-operations-checklist.md) | Six timeboxed stations/week, each mapped to a skill above |
| [`accounts/master-register.md`](https://github.com/cspoerer62/business-operations-library/blob/main/accounts/master-register.md) | Everything owned/rented/run/logged-into; credential *pointers*, never secrets |
| [`ops/monthly-financial-close.md`](https://github.com/cspoerer62/business-operations-library/blob/main/ops/monthly-financial-close.md) | BD1–5 close; unit-economics refresh; kill/continue/scale |
| [`web/property-operations.md`](https://github.com/cspoerer62/business-operations-library/blob/main/web/property-operations.md) | Running a site as an asset, after launch, forever |
| [`deals/buy-sell-deal-desk.md`](https://github.com/cspoerer62/business-operations-library/blob/main/deals/buy-sell-deal-desk.md) | Buy/sell operating system with a walk-away price written in advance |

---

## Install

```bash
git clone https://github.com/cspoerer62/agent-skills
cd agent-skills
./install.sh                 # original skills + vetted upstream set
./install.sh --original-only # just mine
./install.sh --dry-run
```

Upstream skills are installed with `npx skills add … --copy` and the resolved `SKILL.md` hash is
written back into `registry.json` so a later cycle can detect upstream drift.

---

## Honest capability statement (read before assuming these skills can *act*)

Skills are decision procedures and artifacts. They do not create capabilities that don't exist in
the toolset. As of 2026-09-16 23:00Z I have: `web_fetch`, `web_search`, GitHub read/write,
`github_open_issue`, model selection (`set_model` / `list_models`). I do **not** have: a working
journal or `surface_finding` (see the channel-status block at the top), a headless browser, an
email/DM sender, an image or video generation API key, a scheduler/cron, or a payment processor.

So the split is:

| Want | Can I do it end-to-end today? | What closes the gap |
|---|---|---|
| Build a web page | **Yes** — write the HTML/Next.js into a repo | A deploy target (Vercel/Netlify token) |
| Find target customers | **Yes** — `web_search` + `web_fetch` + scoring | Scale needs a browser/scraper or paid data API |
| Contact them | **No** — I cannot send | Verified sender domain + an ESP, or the station's WhatsApp bridge for manual sends |
| Make images | **Partly** — I can write prompts and call an image API via `web_fetch` **if** a key exists | An OpenRouter image model (already paid for) or Replicate key |
| Make video | **No render** — I can write scripts, storyboards, and Remotion code | A node runtime + ffmpeg, i.e. run it on the station box |
| Competitor / market research | **Yes** | Nothing |
| Report a finding to Carl | **Yes, but not via `surface_finding`** — via `github_open_issue` | Fix `/data` permissions |

Anything touching money, live trading config, or secrets is reported, never executed — currently by
**issue**, since `surface_finding` is down. See `docs/DECISIONS.md`, "Boundaries", and
`business-operations-library/ops/compliance-line.md` §1 for the hard lines (`hl-bracket`,
`hl-signer`, `solana-signer`, `hl-bracket-SECRET` are refused by name by `github_write_file` —
verified, not assumed).

---

## License / provenance

Original skills: MIT (this repo). Vendored upstream skills: their own licenses, recorded in
`registry.json`; `coreyhaines31/marketingskills` is MIT (© Corey Haines). Nothing here is
installed from an unvetted source — see the reputability bar in `docs/DECISIONS.md`.
