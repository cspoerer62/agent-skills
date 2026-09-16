# Decision log — 2026-09-16

Carl: *"look at all of the skills available on GitHub… make decisions on your own about what will
make you as smart as possible… be the best business owner possible… web page building, design,
searching other companies, searching the web for opportunities, video, video maker, pictures,
artwork, sales, scraping the internet to find target customers and then contact them. All
business-related skills and thinking skills and load them. Also the skills I've already loaded
for my agents and my master agent Claude."*

This is the reasoning behind what I built, what I refused to build, and what I could not build.

---

## 1. What I surveyed

GitHub repo search across: `claude skills`, `agent skills SKILL.md`, `awesome claude skills`,
`anthropics skills`, plus targeted searches for design/video/lead-gen skill collections.
Named sources read or inventoried: `coreyhaines31/marketingskills`, `anthropics/skills`,
`anthropics/claude-plugins-official`, `ComposioHQ/awesome-claude-skills`,
`alirezarezvani/claude-skills` (772 skills), `bergside/awesome-design-skills`,
`trailofbits/skills`, `VoltAgent/awesome-agent-skills`, `vercel-labs/skills`,
`microsoft/SkillOpt`, `EverMind-AI/SkillCorpus`, `Narwhal-Lab/MagicSkills`, `K-Dense-AI/mimeo`,
`mxyhi/ok-skills`, `TerminalSkills/skills`, `mohitagw15856/pm-claude-skills`,
`Imbad0202/academic-research-skills`, `machina-sports/sports-skills`, `arpitg1304/robotics-agent-skills`.

Plus **Carl's existing loadout**: `cspoerer62/trading-research` → `station/claude-home/skills`
(140 skills), `station/skill-log.md` (the acquisition history), `station/claude-home/skills-lock.json`,
`hl-bracket/agents/` (32 fleet agent definitions), `hl-bracket/SYSTEM.md`.
See `EXISTING-LOADOUT-AND-GAPS.md`.

## 2. What I decided NOT to do

**I did not install 1000 skills.** Skill libraries have a real cost: every installed skill is
context the model must consider, and a bad skill is worse than no skill because it is an
*instruction channel*. The right number is "one skill per decision I actually have to make."
I aimed for ~18 originals + a registry of upstream skills I invoke by name.

**I did not vendor (copy) the third-party skills into this repo wholesale.** Copying 50 MIT
coreyhaines skills is legal but creates a fork that rots. Instead: `registry.json` points at the
upstream, `install.sh` pulls with `--copy`, and the hash is written back so drift is detectable.
The one thing I *did* take from upstream is knowledge of its structure, so my originals don't
duplicate its best content.

**I did not install any "scrape LinkedIn / log into Maps" skill.** Two reasons, both decisive:
(a) it breaks the target platform's ToS and gets the *customer-facing* account banned — that is
a business-destroying risk, not a moral one; (b) a skill that takes credentials from an anonymous
repo is a credential exfiltration primitive. Carl told me to find and contact customers. Legally
and durably, that means public pages, official APIs, licensed data, and opt-in lists. I wrote
the guardrails down instead: `skills/sales/outbound-compliance`.

**I did not add a "make money autonomously" skill.** Anything that trades, moves funds, or spends
is outside my toolset by design. Business skills here produce *artifacts and recommendations*;
money decisions go out as `surface_finding` or a GitHub issue.

## 3. The four things I judged to be the real bottleneck

The brief was a list of *tools*: video, images, pages, scraping. Tools are not where an agent
business fails. These are:

1. **Evidence discipline.** An agent with web access will happily build a confident plan on a
   single blog post. → `thinking/evidence-grading` (A–E source classes) sits under every other
   skill. This is the highest-leverage single file in the repo.
2. **Writing kill criteria before starting.** → `thinking/decision-quality`,
   `thinking/premortem-red-team`. The station's own ledger/calibration machinery already does this
   for research; nothing did it for *business* decisions. Now something does.
3. **Unit economics before building.** The classic autonomous-agent failure is a beautiful thing
   nobody pays for. → `business/unit-economics` is a gate that runs before `design/web-page-build`,
   not after.
4. **Compliance as a capability, not a brake.** Cold outreach done wrong is a domain burn and a
   fine. Done right it is a repeatable channel. → `sales/outbound-compliance` is written to *enable*
   sending, by answering the questions that stop sending from being safe.

## 4. Coverage map — every item in Carl's brief

| Carl said | Skill | Notes |
|---|---|---|
| web page building | `design/web-page-build` | + upstream `frontend-design`, `next-browser` |
| design | `design/brand-and-design-system` | + `bergside/awesome-design-skills` (67 named styles) |
| searching other companies | `research/competitor-teardown` | + upstream `competitor-profiling`, `competitive-ads-extractor` |
| searching web for opportunities | `business/opportunity-scan` | demand-first, not idea-first |
| making videos / a video maker | `media/video-production` | + upstream `video` (Remotion / Hyperframes / Veo / Kling) |
| making pictures / artwork | `media/image-generation` | + `canvas-design`, `algorithmic-art`, `imagegen-frontend-*` |
| making sales | `sales/pipeline-and-closing`, `sales/outbound-sequences` | + upstream `cold-email`, `sales-enablement`, `revops` |
| scraping to find target customers | `research/lead-sourcing-at-scale`, `research/public-web-research-at-scale` | + upstream `prospecting`, `lead-research-assistant` |
| then contacting them | `sales/outbound-compliance` → `sales/outbound-sequences` | gated on compliance on purpose |
| thinking skills | `thinking/*` (4) | + station's existing `deep-research`, `statistical-analysis`, `adversarial-reviewer` |

## 5. Boundaries I kept

- `hl-bracket`, `hl-signer`, `solana-signer`, `hl-bracket-SECRET`: **not written to**, ever. I read
  `hl-bracket/SYSTEM.md` and `agents/README.md` for context only.
- `trading-research` is *not* in the exclusion list, but it is the station that feeds live trading,
  so I did not write to it either. If its skill loadout should change, that is an issue/PR, not a
  silent write. Decision: propose, do not touch.
- Nothing here arms, deploys, sends, or spends.

## 6. Residual gaps — these need Carl, not more skills

1. **No sender.** I cannot send an email or DM. Cold outreach needs a verified sending domain +
   an ESP (or the station's WhatsApp bridge for manual, human-sent messages).
2. **No browser.** `web_fetch` gets static HTML only. JS-heavy directories (Maps, some review
   sites) need the station's browserless container or a licensed data API.
3. **No scheduler.** I cannot run a daily lead sweep. The station has systemd timers; that is
   where a recurring job belongs.
4. **No image/video key.** OpenRouter already has image-capable models on Carl's balance — that is
   the cheapest path to "artwork". Video needs a node+ffmpeg runtime on the station box.
5. **No deploy target.** Pages I write are files in a repo until a Vercel/Netlify token exists.

## 7. Journal tool is broken (operator action)

`write_journal` failed with `EACCES: permission denied, mkdir '/data/journal'` this cycle —
every journal call is currently failing, which means standing rule #1 cannot be satisfied and my
memory across cycles is gone. Fix: create `/data/journal` owned by the agent user, or point the
tool at a writable path. Until then this repo's `docs/` is my memory.