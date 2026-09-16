# Tooling status — verified by live calls, not assumed

Last verified: **2026-09-16, 22:00 UTC cycle.**

Standing rule: report capabilities from what the tool actually returns, never from assumption.
Everything below was checked by calling it this cycle.

## BROKEN — all four `/data`-backed tools

| Tool | Error |
|---|---|
| `write_journal` | `EACCES: permission denied, mkdir '/data/journal'` |
| `read_journal` | `EACCES: permission denied, mkdir '/data/journal'` |
| `list_journal_dates` | `EACCES: permission denied, mkdir '/data/journal'` |
| **`surface_finding`** | `EACCES: permission denied, mkdir '/data/journal'` |

**Fix required (operator):** create `/data/journal` writable by the agent user, or repoint the
tools at a writable path.

### Why this is severe, not cosmetic

`surface_finding` is the primary channel for reporting conclusions to the operator. It is down, and
**it fails after the work is done** — so an agent that assumes success reports nothing and never
knows.

Evidence that this already happened: the 2026-09-16 20:00 UTC journal entry states it *"surfaced the
journal-tool blocker as a finding so the operator can fix it."* That call would have returned this
same error. **The request to fix the outage was itself eaten by the outage**, which is why it went
unfixed. A silently-failing report channel is self-concealing: it suppresses the very message that
would repair it.

## WORKING — verified this cycle

| Tool | Evidence |
|---|---|
| `github_write_file` | 12 successful commits this cycle |
| `github_read_file` | Directory listings + file reads throughout |
| `github_list_my_repos` | Returned 9 repos |
| `github_open_issue` | Issue #1 created successfully |
| `set_model` / `list_models` | Both fine (note: model ids must be exact — guessing an id returns an error) |

## Workarounds in force until `/data` is fixed

| Intended | Substitute |
|---|---|
| `write_journal` / `read_journal` | **`cspoerer62/agent-journal`** repo, one file per cycle |
| `surface_finding` | **`github_open_issue`** — sanctioned fallback per the mission brief |

## Capability gaps (distinct from the above — these are absent by design, not broken)

Checked against the actual toolset. Each is a missing credential or runtime, **not** a missing skill,
so no amount of further skill-writing closes them:

| Gap | Consequence | What would fix it |
|---|---|---|
| **No sender** | Cannot send email/DM/SMS. Outreach sequences exit as artifacts for a human to send | Verified sending domain + ESP credential |
| **No browser** | `web_fetch` returns static HTML only; JS-rendered pages return nothing useful. Must be reported as a tooling gap, **never** as "no information exists" | Headless browser or licensed data API |
| **No deploy target** | Web pages remain repo files. An undeployed page is not "live" | Vercel/Netlify/Cloudflare token |
| **No render runtime** | No ffmpeg/node/camera/mic. Video output is scripts, storyboards, specs, Remotion source | node + ffmpeg host |
| **No confirmed image API in-kit** | If no key is reachable, output is a prompt pack + style lock, and I state plainly that no image was generated | Image model endpoint + key |
| **No scheduler** | Cannot run a recurring sweep; work happens only when a cycle runs | systemd timer / cron on a host |

## Permanent exclusions (not gaps — these are correct and do not move)

No tool exists in this kit to execute a trade, move funds, touch a wallet/exchange key, or reach the
live fleet's services. `github_write_file` refuses `hl-bracket`, `hl-signer`, `solana-signer`,
`hl-bracket-SECRET`. `trading-research` is additionally treated as propose-only (issue, not write)
because it feeds live trading. If the trading fleet should change, the only correct actions are
`github_open_issue` on that repo or a finding.

## Maintenance

Re-test the broken tools at the start of each cycle with one live call each — cheap, and it's the
only way to know when the fix lands. **Update this file with the result.** Do not report a tool as
working because it worked before, and do not report one as broken without a fresh error.
