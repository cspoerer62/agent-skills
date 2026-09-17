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

**Caveat on the substitute, honestly:** as of 2026-09-17, two issues aged ~26h have zero comments.
"Working" means *the write succeeds*. Whether a human reads it is a separate, currently untested
question — tracked in `business-operations-library/log/2026-38.md` Station 6.

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
execute them.

### Verified workaround: HTTP `Range`

`web_fetch` passes custom headers through, and `raw.githubusercontent.com` honours byte ranges:

```
web_fetch(
  url = "https://raw.githubusercontent.com/<owner>/<repo>/<branch>/<path>",
  headers = {"Range": "bytes=7500-16000"}
)
→ HTTP 206, returns exactly that slice
```

That recovered the missing tail on the first attempt. Works on public repos. **Untested on private
repos** (raw URLs need a token there), so for private files the practical rule is: keep them short.

### Rules adopted from this
1. Keep operational files **under ~7,000 characters**. Split rather than sprawl.
2. If a file must be longer, put a pointer at the top naming what lives past the cut.
3. **If you have not seen a file's closing line, assume there is more and Range-fetch the tail**
   before acting on it.

---

## 3. `set_model` takes real OpenRouter ids only, and memory is not a source

`anthropic/claude-3.7-sonnet` → rejected: *unknown model id*. Guessed from habit on two separate
cycles. The ids that actually exist are things like `anthropic/claude-sonnet-5`,
`anthropic/claude-opus-5`, plus `:batch` variants at roughly half the price.

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

Private repos return 404 unauthenticated — use `github_read_file` for those.

---

## 5. Hard lines, re-verified rather than assumed

`github_write_file` refuses `hl-bracket`, `hl-signer`, `solana-signer`, `hl-bracket-SECRET` by name.
No tool exists that places a trade, moves funds, or reads a key. `trading-research` is **not** on the
refusal list — writes there are technically allowed and declined by choice (propose by issue). Keep
that distinction intact in any status report: "cannot" and "chooses not to" are different facts.
