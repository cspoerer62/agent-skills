---
name: evidence-grading
description: Grade every factual claim by source class (A–E) before it is allowed to support a decision. Use whenever a plan, finding, opportunity, lead list, market claim, or recommendation depends on a fact pulled from the web, a document, or memory. Also use before calling surface_finding — nothing goes out ungraded. Triggers on "is this true", "how confident are we", "source", "verify", "the data says", "studies show", "I read that", and any number quoted without an N.
---

# Evidence Grading

The failure mode this skill exists to kill: an agent with web access builds a confident,
well-formatted plan on top of one blog post, and the operator cannot tell which sentences are
load-bearing.

Every claim that supports a decision gets a grade. Ungraded claims are not allowed to be
load-bearing — they may appear only as speculation, labelled as such.

## Grades

| Grade | Source class | Can it carry a decision? |
|---|---|---|
| **A** | Primary data you can re-derive or that you fetched yourself from the authoritative endpoint (SEC/EDGAR filing, exchange API, official statistics office, company's own pricing page, a live measurement you ran). | Yes, alone. |
| **B** | Reputable secondary synthesis with named methodology and a date (established industry report, peer-reviewed paper, a publication with a corrections policy, a vendor's own disclosed benchmark with methodology). | Yes, with one corroborating B. |
| **C** | Individual expert opinion, trade press, well-sourced journalism, a vendor's marketing page *about its own product*. | Yes only as *hypothesis*, never as fact. Needs an A or two B's to become load-bearing. |
| **D** | Aggregator/listicle, SEO content, a number with no N or window, an undated page, an AI-generated summary, a "study" you cannot open. | No. Use to find where the A might be. |
| **E** | Assertion with no source, or a source you could not fetch. | No. Write it as an open question. |

Also record **provenance decay**: online statistics rot. A 2019 market-size figure is C at best in
2026 regardless of who published it.

## Procedure

1. **Extract every claim** that the eventual decision would break if it were false. Write them as
   sentences, one per line. Do not grade while extracting — extraction first, grading second, or
   you will unconsciously only extract the claims you like.
2. **Grade each claim.** Attach: grade, source URL, publisher, publication date, and the specific
   number with its **N and window** ("$4.2B in 2024" is not the same claim as "market grows 12%/yr").
3. **Run the load-bearing test.** For each grade-C-or-below claim: is the decision still true if
   this claim is wrong by 2×? If no, the claim is load-bearing and you must upgrade it (find an A)
   or **change the decision so it does not depend on it**.
4. **Corroboration check.** A and B claims need exactly one independent source *unless* they are
   A-grade primary data you fetched yourself. Two sources that both trace back to the same press
   release are one source — check.
5. **Write the provenance block** into the output. Format:

```
CLAIMS
[1] [B] 68% of SMBs have no website — source: <url>, <publisher>, 2025-03, N=1,204 US SMBs surveyed
[2] [D] "market growing 20%/yr" — source: <url>, no methodology, undated — NOT LOAD-BEARING
[3] [A] Competitor X charges $49/mo — source: <their pricing page>, fetched 2026-09-16
```

6. **Label the output.** A recommendation resting on any C/D/E claim gets the sentence:
   *"This rests on unverified claims: [list]."* No exceptions.

## Rules that make this real

- **Quote, don't paraphrase, the number.** Paraphrasing is where "up 3%" becomes "growing fast".
- **Date everything** — the fetch date *and* the publication date.
- **A claim you could not fetch is grade E**, not "probably fine". "I couldn't load the page" is
  an acceptable and useful thing to write down.
- **Absence of evidence is a finding.** "I searched X and found no A/B source" is grade-E evidence
  *of absence* and is often the most valuable line in the report. Say what you searched.
- **Never upgrade a grade because you like the conclusion.** Upgrade only by fetching something.

## Failure modes

| Symptom | Cause | Fix |
|---|---|---|
| Report full of percentile precision, zero sources | Numbers arrived from memory/model priors | Re-derive or downgrade to E |
| Everything is B | Grading inflation | Ask: did I fetch primary data? If yes it's A; if it's a summary of someone else's survey it's C |
| Confident market size, no N | Listener never checked | Require N + window or strike the number |
| Two "independent" sources, same origin | Press-release laundering | Trace to origin; collapse to one |

## Hard rule

Nothing goes to `surface_finding` without a provenance block, and no claim graded D or E appears
in the `summary` field. If the honest output is "I don't know yet, and here is exactly what I would
fetch to find out" — that is a complete, acceptable, and often correct answer.