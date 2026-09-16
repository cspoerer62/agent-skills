# Carl's existing skill loadout, and the gaps

Source: `cspoerer62/trading-research` → `station/claude-home/skills/` (140 directories),
`station/skill-log.md`, `station/claude-home/skills-lock.json`, `station/prompts/cycle4-skills.md`.
Read 2026-09-16.

The station is Carl's "master agent Claude" — a Claude Code instance on a Hetzner box
(`research-station-1`), `bypassPermissions`, that studies the trading family and ships research to
the repo. Its skill library is **strong** and I am not going to rebuild it. What follows is a diff
against the *business* brief.

## What is already there (grouped)

| Group | Count | Examples |
|---|---|---|
| GSD project/engineering workflow | ~60 | `gsd-*` (plan, execute-phase, debug, ship, audit, retro, workstreams, …) |
| Research & analysis | ~12 | `deep-research`, `autoresearch-agent`, `market-research`, `product-research`, `litreview`, `research-summarizer`, `research-finance`, `brainstorming` |
| Finance / quant | ~10 | `financial-analyst`, `commercial-forecaster`, `risk-management-specialist`, `cs-financial-analyst`, `finance-lead`, `financial-health` |
| Data / stats / ML | ~10 | `senior-data-scientist`, `senior-data-engineer`, `senior-ml-engineer`, `statistical-analysis`, `statistical-analyst`, `data-quality-auditor`, `database-designer`, `sql-database-assistant`, `ab-test-setup`, `product-analytics` |
| Adversarial review / security | ~8 | `adversarial-reviewer`, `named-persona-adversarial-review`, `cs-karpathy-reviewer`, `code-reviewer`, `stress-test`, `security-pen-testing` |
| Superpowers / process | ~15 | `writing-plans`, `executing-plans`, `test-driven-development`, `systematic-debugging`, `verification-before-completion`, `using-superpowers`, `subagent-driven-development`, `dispatching-parallel-agents` |
| Design / media (partial) | ~10 | `frontend-design`, `canvas-design`, `brand-guidelines`, `theme-factory`, `algorithmic-art`, `brandkit`, `brutalist-skill`, `minimalist-skill`, `redesign-skill`, `stitch-skill`, `taste-skill`, `soft-skill`, `image-to-code-skill`, `imagegen-frontend-web`, `imagegen-frontend-mobile`, `gpt-tasteskill` |
| Documents / infra | ~9 | `pdf`, `docx`, `pptx`, `xlsx`, `mcp-builder`, `mcp-integration`, `skill-creator`, `web-artifacts-builder`, `webapp-testing` |
| Tooling | ~3 | `gstack` (browser), `find-skills`, `slack-gif-creator` |

Total: 140 directories as of 2026-09-16, grown from 121 on 2026-07-02 and 152 claimed after the
2026-07-03 batch (the log records 30 net-new on top of 122; the on-disk count is lower than the
claimed total, which is worth verifying on-box — likely `--copy` misses or removals).

## Gaps vs the business brief

| Brief item | Station coverage | Verdict |
|---|---|---|
| Web page building | `frontend-design`, `stitch-skill`, `imagegen-frontend-web`, `web-artifacts-builder`, `webapp-testing` | **Covered.** No new skill needed — I reference these instead of duplicating. |
| Design | `brand-guidelines`, `brandkit`, `theme-factory`, `taste-skill`, plus 8 named-style skills | **Covered** for *style*; **missing** a system that turns style into enforceable tokens. → `design/brand-and-design-system` |
| Searching other companies | `market-research`, `product-research` (market-level) | **Partial.** Nothing does a single competitor's business model teardown. → `research/competitor-teardown` |
| Web opportunities | `deep-research`, `brainstorming` | **Partial.** Research finds *information*; nothing scores *business opportunity*. → `business/opportunity-scan` |
| Video / "we need a video maker" | **Nothing.** `slack-gif-creator` makes GIFs. | **Gap.** → `media/video-production` |
| Pictures / artwork | `canvas-design`, `algorithmic-art` (these are *design artifacts*), `imagegen-frontend-*` (prompt packs for UI) | **Gap** for actual image/art generation pipelines. → `media/image-generation` |
| Making sales | **Nothing.** `commercial-forecaster` forecasts; it does not sell. | **Gap.** → `sales/pipeline-and-closing`, `sales/outbound-sequences`, `sales/outbound-compliance` |
| Scrape internet for target customers | **Nothing.** `gstack` = browser as a research tool; no lead pipeline. | **Gap.** → `research/lead-sourcing-at-scale`, `research/public-web-research-at-scale` |
| Contact them | **Nothing** (WhatsApp bridge is for Carl, not prospects) | **Gap.** → `sales/outbound-compliance` gates `sales/outbound-sequences` |
| Business model / unit economics | `financial-analyst`, `commercial-forecaster` are *analysis* skills | **Partial.** → `business/unit-economics`, `business/offer-design`, `business/experiment-engine` |
| Thinking skills | `deep-research`, `statistical-analysis`, `adversarial-reviewer`, `writing-plans` | **Strong already.** I add the four that were missing: evidence grading, pre-decision checklist, first-principles, premortem. |

## What I deliberately did not duplicate

- Any `gsd-*` workflow skill, any engineering-process skill, any document skill, any
  browser/tooling skill. Duplicating these would create two disagreeing sources of truth for the
  same job, which is worse than a gap.
- Anything trading/quant. That is the fleet's lane and it is excluded.

## Note for whoever runs the station

The station's own `skill-log.md` already flags that `npx skills find` is broken in v1.5.14 and
that `https://skills.sh/api/search?q=...` works. My `registry.json` respects that finding. If the
station wants the business skills applied to its own work (e.g. a market-research deliverable that
should end in an offer rather than a PDF), the clean path is a PR to `trading-research`, not a
direct write from me — see `docs/DECISIONS.md` §5.