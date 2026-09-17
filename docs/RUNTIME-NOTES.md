# Runtime Notes

**What the tools actually do, established by live calls — not by reading the tool descriptions.**

Every line here was produced by making the call and recording what came back, with the date. If a
claim here has no date and no observed error string, it does not belong in this file.

Maintained because the agent has twice been wrong about its own capabilities by assuming instead of
checking, and because a tool limit that fails *silently* is indistinguishable from a fact about the
world.

---

## 1. `/data`-backed tools: dead, four cycles running

| Tool | Result | Last verified |
|---|---|---|
| `write_journal` | `EACCES: permission denied, mkdir '/data/journal'` | 2026-09-17 00:00Z |
| `read_journal` | same | 2026-09-17 00:00Z |
| `list_journal_dates` | same | 2026-09-17 00:00Z |
| `surface_finding` | same | 2026-09-17 (re-tested at end of cycle) |

All four share one failure: the runtime volume is not writable by the agent user. **One permission
bit takes out both the memory layer and the report channel.**

**Consequence that matters for every skill in this repo:** each `SKILL.md` says the correct output
when you hit a gate is a `surface_finding`. That instruction points at a dead channel. Read it as
**`github_open_issue`** until this table says otherwise. See `README.md`'s runtime-channel block.

**Substitutes, both verified working:** `github_write_file` to `cspoerer62/agent-journal` for memory;
`github_open_issue` for escalation (works on every repo, including the four the write tool refuses).

**Caveat on the substitute, honestly:** as of 2026-09-17, escalation issues on `agent-skills` and
`business-operations-library` are 26h+ old with zero real comments (one spam comment from an
unrelated GitHub user landed on `agent-skills#1` — `author_association: NONE`, not Carl; see
INBOUND-TRUST-POLICY.md). "Working" means *the write succeeds*. Whether a human reads it is a
separate, still-unconfirmed question — tracked in `business-operations-library/log/2026-38.md`
Station 6.

---

## 2. Read tools truncate at ~8,000 characters — and it is silent

Observed 2026-09-17 on `ops/weekly-operations-checklist.md`:

- `github_read_file` returned the file up to ~8,000 chars and stopped mid-sentence.
- `web_fetch` of the `raw.githubusercontent.com` URL truncated **at the identical point**.
- `web_fetch` through a reader proxy (`r.jina.ai`) truncated **at the identical point**.

Three different paths, same cut → **the limit is in the tool's response handling, not in the source
or the network.** There is no error, no ellipsis, no flag. The text just ends, and a document whose
end you never saw looks exactly like a document that ends there.

This had a real consequence: that checklist's scorecard definition, stop rules, and log format all
live past the 8KB mark, so for one cycle they were invisible to the agent that was supposed to
execute them. Confirmed again 2026-09-17 on `trading-research/ledger/LEDGER.md` (private repo) —
same silent cut mid-sentence.

### Verified workaround: HTTP `Range` — public repos only

`web_fetch` passes custom headers through, and `raw.githubusercontent.com` honours byte ranges:

```
web_fetch(
  url = "https://raw.githubusercontent.com/<owner>/<repo>/<branch>/<path>",
  headers = {"Range": "bytes=7500-16000"}
)
→ HTTP 206, returns exactly that slice
```

That recovered the missing tail on the first attempt. Works on public repos.

**Confirmed 2026-09-17: does NOT work on private repos.** `raw.githubusercontent.com` for a private
repo (`trading-research`) returns a flat `404` unauthenticated, Range header or not — the 404 happens
before range is ever considered, since there's no token to pass. Same for the `api.github.com`
contents/blobs endpoints unauthenticated. **For a private-repo file already past 8KB, there is
currently no known way for this harness to read the tail.** Practical rule, sharpened from "keep
files short" to a hard one: **if a private-repo file might be read-then-written-back, it must stay
under ~7,000 characters, full stop** — there is no recovery path if it grows past that and someone
(possibly a future instance of you) writes back a truncated copy. See
`trading-research/ledger/AAA-READ-ME-FIRST.md` for a live example of working around an already-grown
file by freezing it and forking new content into a fresh, small file instead of touching the big one.

### Rules adopted from this
1. Keep operational files **under ~7,000 characters**. Split rather than sprawl.
2. If a file must be longer, put a pointer at the top naming what lives past the cut.
3. **If you have not seen a file's closing line, assume there is more** — Range-fetch the tail if
   the repo is public; if it's private and already grown past 8KB, do not write back to that file
   at all — fork a new one and leave the old one frozen.

---

## 3. `set_model` takes real OpenRouter ids only, and memory is not a source

`anthropic/claude-3.7-sonnet` → rejected: *unknown model id*. Guessed from habit on multiple separate
cycles (recurring as of 2026-09-17 07:00Z — still happening). The ids that actually exist are things
like `anthropic/claude-sonnet-5`, `anthropic/claude-opus-5`, plus `:batch` variants at roughly half
the price.

**Rule: `list_models` before the first `set_model` of any cycle.** Same class of error as claiming a
file exists without listing it — and it costs a whole call to discover.

---

## 4. GitHub API is reachable unauthenticated via `web_fetch`, for public repos

Useful because the GitHub *tools* only read files. The API fills the gaps:

| Need | Call | Verified |
|---|---|---|
| Are my issues answered? | `GET /repos/{o}/{r}/issues?state=all` — check `comments` | 2026-09-17 |
| Does a web property exist? | `GET /repos/{o}/{r}/pages` — **404 = no Pages site** | 2026-09-17 |
| Repo metadata, descriptions, `homepage` | `GET /users/{o}/repos?per_page=100` (public only; response is big — expect the 8KB cut) | 2026-09-17 |

Private repos return 404 unauthenticated — use `github_read_file` for those (subject to §2's 8KB cut).

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
GitHub account's search scope. Do not assume it doesn't exist; only claim it isn't *visible from here*.
