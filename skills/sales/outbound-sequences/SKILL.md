---
name: outbound-sequences
description: Write cold outreach that gets replies — message structure, the 4-touch cadence, personalization that scales, channel choice, and the metrics that decide whether to iterate or kill. Use after sales/outbound-compliance has passed, for any first-contact message on any channel. Triggers on "cold email", "sequence", "follow up", "outreach message", "subject line", "DM", "cadence", "they didn't reply".
---

# Outbound Sequences

**Prerequisite: `sales/outbound-compliance` must have passed its six-gate check. Do not draft a
send-ready sequence before that.** Output of this skill feeds `sales/pipeline-and-closing` stage 1.

The purpose of a cold message is **not** to sell. It is to earn one reply. Every structural decision
below follows from that.

## The only message structure that reliably works

Four sentences. Under 90 words. Plain text, no images, no signature block art, no attachment.

```
1. RELEVANCE   — why you, specifically, right now. A fact about THEM.
2. PROBLEM     — the problem that fact implies, in their language, stated as a guess.
3. PROOF       — one concrete, true, specific piece of evidence you can act.
4. ASK         — one tiny, low-commitment, unambiguous question.
```

Worked example:

> Saw you're hiring two more installers for the Leeds branch *(relevance)*. Usually when a crew
> scales past ~8, scheduling moves from a whiteboard to somebody's full-time job *(problem, as a
> guess)*. I built the dispatch board a 6-van plumbing firm in Sheffield now runs their whole week
> on — cut their Monday planning from 4 hours to about 30 minutes *(proof, true and specific)*.
> Worth a look? *(ask)*

Why each part is load-bearing:
- **Relevance must be a fact about them**, obtained from a public source. "I see you're in
  construction" is not relevance, it's a category. A hiring post, a new location, a specific page on
  their site, a recent award — that's relevance. This sentence is ~80% of reply rate.
- **State the problem as a guess**, not a diagnosis. "Usually when X, Y happens" lets them correct
  you, and a correction *is a reply*. "You clearly have a problem with Y" invites a defensive
  no-reply.
- **Proof must be specific and true.** A number with a context beats an adjective. If you have no
  result yet, the honest substitute is the mechanism or an offer to prove it free — never an
  invented client. (`sales/outbound-compliance` gate 6.)
- **The ask must be tiny.** "Worth a look?" / "Want me to send the 2-min version?" / "Is scheduling
  actually a headache or am I off?" — all answerable in four words. Never "do you have 30 minutes
  Tuesday or Thursday for a discovery call?" on touch 1: that asks for the biggest thing you want
  before you've earned anything.

### Subject lines

Lowercase, 2–5 words, looks like a human typed it, describes content honestly.
- Good: `leeds branch`, `scheduling question`, `quick one re: installers`
- Bad: `Unlock 10x Efficiency Today!`, `Re: our conversation` (if there wasn't one — that's gate 3),
  anything with an emoji, anything in Title Case With Every Word Capitalized.

## Cadence — 4 touches, then close the file

| Touch | Day | Angle | Rule |
|---|---|---|---|
| **1** | 0 | The structure above | The real message |
| **2** | +3 | **New information** — a resource, a relevant example, a thought about their situation | Never "just bumping this" |
| **3** | +7 | **Different angle** — a different problem, or a different person at the company | If the first angle didn't land, repeating it louder won't |
| **4** | +14 | **Close the file** — "I'll assume the timing's off and stop reaching out; reply any time if that changes" | Highest reply rate of the sequence. Send it and mean it |

Then **stop**, and move the record to Lost with a reason, plus the 90-day nurture slot from
`sales/pipeline-and-closing`.

Hard rules:
- **Every touch adds something.** If you can't think of what to add, that's information: the
  targeting is weak.
- **Touch 4 is not a threat or a guilt trip.** It works *because* it genuinely removes pressure.
- **Reply to the same thread** for touches 2–4, so they have context.
- **Any human reply ends the sequence** and moves to the pipeline. Never let automation talk over a
  person who answered.

## Personalization that actually scales

The trap is a binary choice between 500 identical messages and 20 lovingly hand-written ones. The
resolution is a **fixed template with one genuinely researched variable**:

- Template: sentences 2, 3, 4 are fixed per segment.
- Variable: sentence 1 (relevance) is researched per prospect — one public fact, ~60 seconds of work.
- **Segment tightly enough that the fixed sentences are actually true for everyone in it.** If
  sentence 2 isn't true for all 50 people on the list, the segment is too broad. This is the whole
  technique.

Anti-patterns: `{{first_name}}`-only personalization (everyone sees through it); "I loved your
post!" about a post you didn't read; flattery of any kind; mentioning their city as if it's insight.

## Channel choice

| Channel | Use when | Constraint |
|---|---|---|
| **Email** | Default. Documented, async, scales, legally well-understood | Needs domain hygiene (see compliance skill) |
| **Phone** | High-value, local, trade businesses that live on the phone | Human-only; I cannot call |
| **Contact form** | No published address; small local business | One shot, no follow-up route — make it count |
| **Social DM** | There's a genuine public interaction to reference | Platform ToS; never automate; never at volume |
| **Physical mail** | Very high value, tiny list | Slow, expensive, extremely high open rate |
| **Warm intro** | Always, if it exists | Beats every row above by an order of magnitude. Check for one first |

**Check for a warm path before building a cold list.** Mutual connection, existing customer
referral, community membership. One intro is worth ~100 cold sends.

## Metrics and kill criteria

Measure per **segment**, not per campaign, and with N≥50 sent before drawing any conclusion.

| Metric | Healthy (cold B2B) | Diagnoses |
|---|---|---|
| Bounce | <3% | List quality — >3% STOP, clean the list |
| Open | 40–60% | Subject line + domain reputation |
| **Reply** | **5–15%** | **The real metric.** Relevance sentence + segment fit |
| Positive reply | 2–5% | Offer quality |
| Meeting/next-step | 1–3% | Ask sizing |
| Spam complaints | <0.1% | >0.1% STOP everything |

Diagnostic ladder — read it in this order:
- **Good open, near-zero reply** → the message is wrong (or the offer is). Iterate sentences 1–2.
- **Low open** → subject line, or deliverability. Check DMARC/warmup before rewriting copy.
- **Replies, all negative/"not us"** → targeting is wrong. Fix the segment, not the copy.
- **Nothing at all across 2 segments and 100+ sends** → the offer doesn't address a real problem.
  Stop sending and go back to `business/offer-design` / `business/opportunity-scan`.

**Kill criteria, written before launch** (per `thinking/decision-quality`): if a segment is below
2% reply after 50 sends, stop, and either re-segment or kill the offer. Do not scale volume to
compensate for a bad reply rate — that converts a copy problem into a domain burn.

## Procedure

1. Confirm `sales/outbound-compliance` gates PASS. Stop if not.
2. Define the segment narrowly; write the relevance sentence template and confirm it's true for
   all members.
3. Write touch 1 in the four-sentence structure. Cut it to under 90 words.
4. Read it back and strike: every adjective, every "I hope this finds you well", every "I wanted to
   reach out", every sentence about us that isn't the proof.
5. Write touches 2–4 with their distinct angles, including the close-the-file message.
6. Verify every factual claim (`thinking/evidence-grading`); strike anything unevidenced.
7. Set kill criteria and the metric you'll judge on, in writing.
8. Hand to a human to send. Log every send in the pipeline file at stage 1.

## Boundaries

- I draft and sequence; **I cannot send**. No sending tool exists in my kit. Finished sequences exit
  as a repo artifact plus a `surface_finding`.
- No invented proof, no fake threads, no fake urgency, no invented personas — these are
  `outbound-compliance` gate 3/6 failures and also just don't work twice.
- No automated social DMs and no volume DMing, regardless of what a tool makes technically possible.
- If asked to scale a sequence that's below kill threshold, the answer is the diagnostic ladder and
  a recommendation to fix targeting — not more volume.
