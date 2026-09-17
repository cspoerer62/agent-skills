# Runtime Notes

**What the tools actually do, established by live calls — not by reading the tool descriptions.**

Every line here was produced by making the call and recording what came back, with the date. If a
claim here has no date and no observed error string, it does not belong in this file.

**Sections 1-3 (the `/data` outage, the 8KB read-truncation mechanics, and the `set_model` id
mistake) moved to `docs/RUNTIME-NOTES-ARCHIVE-1-3.md` on 2026-09-17** — this file itself grew past
the exact 8KB limit it was documenting (confirmed by re-reading it right after the write and seeing
it cut off mid-sentence in §6, below). Read the archive first if you haven't already; the short
version: `/data` is fully dead (journal + surface_finding), reads silently truncate at ~8,000 chars
with a private-repo workaround gap, and `set_model` needs a fresh `list_models` every cycle because
memory of "what ids exist" keeps being wrong.

---

## 4. GitHub API is reachable unauthenticated via `web_fetch`, for public repos

Useful because the GitHub *tools* only read files. The API fills the gaps:

| Need | Call | Verified |
|---|---|---|
| Are my issues answered? | `GET /repos/{o}/{r}/issues?state=all` — check `comments` | 2026-09-17 |
| Does a web property exist? | `GET /repos/{o}/{r}/pages` — **404 = no Pages site** | 2026-09-17 |
| Repo metadata, descriptions, `homepage` | `GET /users/{o}/repos?per_page=100` (public only; response is big — expect the 8KB cut) | 2026-09-17 |
| Issue comment authorship | `GET /repos/{o}/{r}/issues/{n}/comments` — check `author_association` | 2026-09-17 |

Private repos return 404 unauthenticated — use `github_read_file` for those (subject to the 8KB cut
documented in the archive).

---

## 5. Hard lines, re-verified rather than assumed

`github_write_file` refuses `hl-bracket`, `hl-signer`, `solana-signer`, `hl-bracket-SECRET` by name.
`trading-research` is **not** on the refusal list — writes there are technically allowed and declined
by choice for strategy/live-trading-adjacent changes (propose by issue instead), but factual/
evidentiary bookkeeping (grading past claims, ledger hygiene) has been judged in-bounds for direct
writes on prior cycles. Keep the distinction intact in any status report: "cannot" and "chooses not
to" are different facts.

---

## 6. Fleet Render services are network-blocked to `web_fetch`, not just to the write tools

**Confirmed 2026-09-17, live test:** `web_fetch("https://hl-watcher.onrender.com/btc-guru-daily")` →
`{"error":"blocked: this agent cannot reach that host (the live trading fleet, its cloud control
plane, or a private/internal address)"}`.

This matters because prior cycles' `trading-research` findings (built by the actual Hetzner research
station, which had allowlisted egress to that host) treat `hl-watcher.onrender.com` as a normal,
reachable, read-only data source for auditing the live doctrine. **It is not reachable from this
harness at all** — not "only via the excluded write tools," genuinely network-refused at the
`web_fetch` layer, for GET requests, on a public-data endpoint, no different from how the four named
repos are refused at `github_write_file`. Any ledger claim whose *source of truth* is a fleet-internal
endpoint (the guru-chain family, anything else that reads from `hl-watcher`/`hl-bracket-engine`/
similar) is **permanently ungradable by this harness**, not just currently inconvenient. Distinguish
this from claims whose source is public market data (Deribit, CoinGecko, on-chain, etc.) — those
remain gradable by this harness given enough tool calls; the fleet-internal ones do not, ever, unless
the toolset changes. See `trading-research/ledger/LEDGER-CURRENT.md` for a worked example applying
this distinction to real ledger rows (marked `BLOCKED`/`EXPIRED` vs. left genuinely `open`).

Also confirmed: `github_search_repos("hl-bracket-engine")` returns zero results — this harness has no
visibility into whether that repo exists, is named differently, or is simply invisible to this
GitHub account's search scope. Do not assume it doesn't exist; only claim it isn't *visible from
here*.
