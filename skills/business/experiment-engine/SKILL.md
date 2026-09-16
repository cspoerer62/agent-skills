---
name: experiment-engine
description: Run growth as a queue of cheap, pre-registered, time-boxed experiments with written kill criteria instead of one big bet. Use for any uncertainty about demand, pricing, messaging, channel, or design, and whenever deciding what to work on next. Triggers on "test this", "should we try", "growth", "which channel", "A/B", "what next", "prioritize experiments", "learn fast".
---

# Experiment Engine

The operating loop of a business run by an agent. The unit of work is not "a project" — it is
**the cheapest test that changes a decision**.

## The rules

1. **One hypothesis per experiment.** Written as: *"If <change>, then <metric> moves by ≥ <amount>,
   because <reason>."*
2. **Pre-register** the metric, the threshold, the timeframe, and the kill criteria **before**
   starting. Recorded in a repo file. An experiment whose criteria were chosen after the numbers
   came in is not an experiment.
3. **Time-box hard.** Default caps: message test 1 day / 50 sends; page test 7 days or 200 visits;
   pricing test 14 days or 20 conversations. On the cap, decide — do not extend. Extending is the
   most expensive decision in business because it feels free.
4. **Instrument before running.** If the metric cannot be observed without new infrastructure, either
   build the observation first (≤ 1 hour) or pick a different metric. Choosing unobservable metrics
   is how experiments quietly become opinions.
5. **Report the negative result.** A killed experiment is a full deliverable and gets recorded.
   The ledger of dead ends is an asset — it is what stops a later cycle re-running them.
6. **Sequential, not parallel, when capacity is 1.** I am one agent. Three half-finished
   experiments produce zero information. One finished experiment per cycle.

## The queue (ICE-lite, deliberately simple)

| Field | Meaning |
|---|---|
| **Impact** | If it works, how much does it move the binding constraint? H/M/L |
| **Confidence** | Evidence this will work — graded per `thinking/evidence-grading` |
| **Cost** | Hours + $ to run |
| **Speed** | Days to a readable result |

Priority = Impact (H>M>L) → Speed (fast first) → Cost (cheap first) → Confidence.
**Confidence is last on purpose.** Cheap fast tests *create* confidence; they should not need it.

## Standard experiment library

Run these in roughly this order — they get progressively more expensive and each one is only
justified by the previous result.

| # | Experiment | Cost to run | What it decides |
|---|---|---|---|
| 1 | 10 conversations with real buyers (DM, phone, community) | hours | Is the problem real and urgent? |
| 2 | One page, price shown, a way to say yes (waitlist/click) | 2–4h | Does anyone want *this* framing? |
| 3 | 50 hand-written cold messages, one angle | 4h | Does the channel reach? What reply rate? |
| 4 | 3 message angles × 50 messages each | days | Which promise lands? |
| 5 | Price A vs price B to 20 conversations | days | Demand elasticity |
| 6 | Concierge delivery for the first 1–3 buyers | days | Can we deliver at all, and at what true cost? |
| 7 | Automate the part that consumed the most hours | days | Does margin improve or stay a job? |
| 8 | Channel #2 | days | Is there a second source of demand? |

Note: **experiments 1–3 cost almost nothing and are the ones agents skip.** They skip them because
building is more fun and feels like progress.

## Reading a result honestly

| Result | Interpretation | Action |
|---|---|---|
| Threshold hit | The hypothesis survives; the *next* experiment tests the next assumption, not this one again | Advance |
| Threshold missed, mechanism explained (e.g. 0% replies + domain burned) | The *mechanism* failed, not necessarily the idea | Fix the mechanism, re-run once |
| Threshold missed, no mechanism | Hypothesis is probably wrong | Kill |
| Massive miss (0 replies to 200) | The framing or the ICP is wrong, not the copy | Go back to Phase 1 of `research/lead-sourcing-at-scale` |
| Unreadable (too few data points) | The experiment was under-powered — say so, do not spin it | Re-run with a real sample or accept uncertainty |

Sample-size discipline from the station's own doctrine applies: a 6-lead, 3-day window cannot
distinguish 2% from 8%. If the honest answer is "not enough data to conclude", write that.

## Output: the experiment record

```
ID:            EXP-<n>
HYPOTHESIS:    If <change>, then <metric> ≥ <threshold>, because <reason>
METRIC:        <observable, how measured, baseline value>
SAMPLE:        <how many, over how long>
COST:          <hours, $>
START:         <date>   HARD STOP: <date>
KILL CRITERIA: <pre-registered>
RESULT:        <numbers, date>
VERDICT:       SURVIVED | KILLED | UNREADABLE | NEEDS RE-RUN
WHAT WE NOW BELIEVE: <one line — the actual product of the experiment>
NEXT:          <the single next experiment>
```

## Portfolio rule

Keep **one** experiment live at a time and a queue of ≤ 10. Each cycle: finish the live one, record
it, promote the next. Anything that has sat in the queue for 30 days without being run should be
deleted from the queue, not carried — a queue of untested hypotheses is a queue of excuses.

## Rules

- **Never run an experiment whose result cannot change what we do.** If both outcomes lead to the
  same action, skip it.
- **Never let an experiment become the business.** If a test is still running after 3× its time cap,
  it is a project that failed and is being hidden.
- **Money-in experiments are Carl's.** Anything that spends, prices, or collects is a proposal
  (`surface_finding`) — I run the zero-cost tests myself.
- **Record in a repo, not in prose.** The ledger is the asset; it is how cycle N+1 starts smarter
  than cycle N. See also the station's `doctrine/methods.md` for the trading-side analogue.