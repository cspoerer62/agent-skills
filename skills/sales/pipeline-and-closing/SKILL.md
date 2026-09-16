---
name: pipeline-and-closing
description: Run a sales pipeline end to end — stage definitions, qualification, discovery, objections, and closing — without a CRM. Use for any conversation with a potential buyer, for deciding who to spend time on, and for moving a "maybe" to a decision. Triggers on "follow up with", "they went quiet", "how do I close", "discovery call", "qualify", "pipeline", "objection", "quote", "proposal".
---

# Pipeline & Closing

Sales is a process with fixed stages, not a personality trait. This skill defines the stages, the
exit criteria per stage, and the discipline to disqualify.

## Stages and exit criteria

| Stage | Definition | Exit criteria | Typical failure |
|---|---|---|---|
| **0 Target** | On the ICP list, not yet contacted | Contact route identified | — |
| **1 Contacted** | A message has been sent | Sent, with a record of the exact message and date | Sending and forgetting |
| **2 Replied** | Any human response at all | They said something (even "no") | Treating silence as interest |
| **3 Problem confirmed** | They described the problem in their own words | **A verbatim quote** of their pain, in their language | Pitching before this exists |
| **4 Value agreed** | They agreed the problem is worth solving and the outcome matters | A number: what it costs them, or what they'd pay | Assuming agreement from politeness |
| **5 Terms** | Price, scope, timing on the table | A specific written offer they've seen | Vagueness to avoid rejection |
| **6 Won / Lost** | Decision made | Explicit yes (with payment path) or explicit no with a reason | "Let me think about it" left open forever |

**Rule: you may not skip a stage, and you may not count a stage as passed without its exit
criterion.** "They seemed interested" is not stage 4. The exit criteria are the whole point.

## Qualify hard — the disqualification discipline

Disqualify (move to Lost, politely) when any of these is true:
- No trigger event and no deadline → will never buy, will absorb unlimited time.
- No budget authority or no budget → talking to the wrong person.
- The problem is not in their top-3 current priorities.
- They need a capability we have no path to deliver.
- They are shopping only on price against an incumbent with scale.
- They cannot articulate the problem without you supplying the words.

**Disqualification is a revenue-generating activity.** Every hour with a non-buyer is an hour not
spent with the list of real buyers.

## Discovery — the question order

Ask in this order. Do not pitch during this phase; the cost of a premature pitch is the loss of the
information the pitch was supposed to be built on.

1. "Walk me through how you currently handle <the task>." (Process, not opinion.)
2. "What happens when it goes wrong?" (Cost of the problem, in their words.)
3. "How much time/money does that cost you a month?" (The anchor number for pricing.)
4. "What have you tried?" (Prior failed solutions = the objections you must pre-handle.)
5. "What would have to be true for this to be worth doing this quarter?" (Reveals real gate.)
6. "Who else is involved in a decision like this?" (Maps the actual buyer.)
7. "If we fixed this, what changes for you personally?" (The real motivation — usually risk,
   time, or status, not the feature.)

**The single best discovery move is silence.** Ask, then stop talking. The second-best is to
repeat their last sentence back and wait.

## Objection handling (structure, not scripts)

**Acknowledge → Isolate → Answer → Confirm.**
1. **Acknowledge**: "That's a fair concern — a lot of people ask that."
2. **Isolate**: "If that were resolved, is there anything else in the way?" (Separates the real
   objection from the polite one.)
3. **Answer** with evidence — a number, a reference, a live artifact.
4. **Confirm**: "Does that address it?" Never assume the objection is dead.

| Objection | Real meaning | Move |
|---|---|---|
| "Too expensive" | Value unclear or wrong buyer | Re-anchor to their cost of the problem (from discovery q3) |
| "Send me some info" | Polite exit | "Happy to — what specifically should I cover?" |
| "Not the right time" | No trigger | "When does <trigger> happen? I'll come back then." Put a real date |
| "We're already using X" | Comparison fear | "What would have to be different for you to switch?" |
| "I need to think" | Unclear small next step | Offer a smaller commitment, not a discount |
| Ghosting | Message failed or lost priority | 2 more touches, different angle/channel, then close the file |

## Follow-up discipline

- 3–5 touches total in a cold sequence (see `sales/outbound-sequences`), then stop.
- Each touch adds something new (a result, an idea, a resource) — never "just checking in".
- The LAST touch is a **close-the-file** message: "I'll assume the timing isn't right and stop
  reaching out — if that changes, reply any time." That message routinely produces the most replies
  of the sequence, because it removes the pressure and gives permission.

## Closing

Ask a **specific, small, unambiguous** next step:
- Good: "Shall I send the 5-day plan with the price, so you can say yes or no by Friday?"
- Bad: "Let me know what you think."
- Good (paid pilot): "£X for the first one, delivered in 5 days. If it doesn't do Y, you don't pay."
- Bad: "We can start whenever."

Then **get it in writing** (a message or a one-page offer with price, scope, date). Verbal yeses
are not stage 6.

## Operating loop for an agent

1. Read the pipeline file (repo). Update stage + evidence for every open conversation.
2. Identify the single conversation closest to the next stage; advance it (one message, one
   question, one offer).
3. Identify one stalled conversation; either advance it with a new angle or move it to Lost with a
   recorded reason.
4. Record everything: date, channel, exact message, response, next date.

**Nurture rule:** any "no" gets one slot in a 90-day follow-up list. No's become yeses when the
trigger event arrives; the only reason they don't is that nobody came back.

## Boundaries

- I can **draft, sequence, and track**. I cannot send, call, or take payment. Sending is a
  `surface_finding` for Carl (or a human-sent WhatsApp from the station) until a sender exists.
- Never misrepresent price, capability, guarantees, or who we are. It is a small market and it is
  the fastest way to end the business.
- Never claim a result we have not produced. If there is no proof, say what the proof would be.
- Compliance is upstream of everything here: `sales/outbound-compliance`. Read it before any outbound.