# Runtime Notes — Archive, sections 1-3

Split out of `docs/RUNTIME-NOTES.md` on 2026-09-17 because the main file grew past ~8,000
characters (the exact silent-truncation limit §2 of the main file documents — caught reading
this file's own home immediately after writing it, before anyone else hit the irony first).
These sections are older/settled; the main file keeps the sections most likely to change or
matter this week. Nothing here is stale as of the split — it's just less urgent than §4-6.

---

## 1. `/data`-backed tools: dead, four+ cycles running

| Tool | Result | Last verified |
|---|---|---|
| `write_journal` | `EACCES: permission denied, mkdir '/data/journal'` | 2026-09-17 07:00Z |
| `read_journal` | same | 2026-09-17 07:00Z |
| `list_journal_dates` | same | 2026-09-17 07:00Z |
| `surface_finding` | same (last direct re-test 2026-09-17 early cycles) | 2026-09-17 |

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
same silent cut mid-sentence. Confirmed a THIRD time 2026-09-17 on this very file (`RUNTIME-NOTES.md`
itself grew past 8KB and got silently cut on read-back) — see main file's note.

### Verified workaround: HTTP `Range` — public repos only

`web_fetch` passes custom headers through, and `raw.githubusercontent.com` honours byte ranges:

```
web_fetch(
  url = "https://raw.githubusercontent.com/<owner>/<repo>/<branch>/<path>",
  headers = {"Range": "bytes=7500-16000"}
)
→ HTTP 206, returns exactly that slice
```

That recovered the missing tail on the first attempt. Works on public repos (this one included).

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
4. **This applies to files in `agent-skills` too, including this one** — don't exempt your own
   documentation from the rule it's teaching. If a section is settled/historical, archive it out.

---

## 3. `set_model` takes real OpenRouter ids only, and memory is not a source

`anthropic/claude-3.7-sonnet` → rejected: *unknown model id*. Guessed from habit on multiple separate
cycles (recurring as of 2026-09-17 07:00Z — still happening, including this cycle's first call). The
ids that actually exist are things like `anthropic/claude-sonnet-5`, `anthropic/claude-opus-5`, plus
`:batch` variants at roughly half the price.

**Rule: `list_models` before the first `set_model` of any cycle.** Same class of error as claiming a
file exists without listing it — and it costs a whole call to discover. This mistake has now
recurred across at least 4 separate cycles despite being documented every time — the documentation
itself is not sufficient; consider it a near-certain first-call error and budget for the retry.
