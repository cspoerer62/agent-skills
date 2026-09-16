---
name: first-principles-business-model
description: Reduce any business, offer, or product idea to its irreducible parts — who pays, why now, what it costs to deliver, and what must be true for it to work — then rebuild only what survives. Use when evaluating a new business idea, choosing what to build for Carl, designing an offer, or when a plan has grown complicated without becoming clearer. Triggers on "business model", "how does this make money", "viable", "what should we build", "is there a business here".
---

# First-Principles Business Model

Purpose: turn "an idea" into a small set of statements that can be attacked. Anything that cannot
be reduced to those statements is decoration.

## The six irreducible parts

Every business, without exception, is these six things. If you cannot fill one in, that is the finding.

1. **Who pays.** A specific, reachable entity — not "SMBs". "The owner of a 3–15 truck HVAC company
   in Texas who currently answers leads on a cell phone." Reachability is part of the definition.
2. **What they pay for.** The *job* being done, in their words. Not features. If you cannot quote a
   real person describing this pain, you are guessing.
3. **Why now, and not last year.** A trigger event (regulation, price change, a vendor sunsetting,
   a competitor closing, a new capability like AI making an old task cheap). Without a "why now",
   you are competing against inertia, which is the strongest competitor that exists.
4. **Price and mechanism.** The number, the unit (per seat / per lead / per month / per outcome),
   and *how the money physically moves* (card, invoice, crypto, platform payout).
5. **Cost to deliver, including your own hours.** Marginal cost per unit + the fixed cost + the
   hours. If delivery does not have a marginal-cost story, it is a job, not a business.
6. **What must be true.** The 2–4 load-bearing beliefs. Each gets graded per
   `thinking/evidence-grading`, and each gets a cheap test per `business/experiment-engine`.

## Procedure

**Step 1 — Write the six parts in ≤ 6 lines.** Force brevity. A business model that needs a page
is usually two models glued together.

**Step 2 — Strip the assumptions to primitives.** Ask of every claim: *is this a fact about the
world, or a consequence of how someone else structured it?* Examples of the discipline:
- "Lead gen requires an ad budget" → is that a fact, or a consequence of competition for attention?
  (Answer: consequence — it means the primitive is *attention*, and there may be cheaper attention.)
- "Cold email gets 1% replies" → fact about law/attention, or about sender reputation and copy?
  (Both — which means the primitive is *deliverability* + *relevance*.)
- "We need a website" → primitive is *a place a stranger can verify we exist and act*.

**Step 3 — Find the binding constraint.** ONE thing currently limits throughput: money, trust,
attention, deliverability, tooling, or your own hours. Optimizing anything other than the binding
constraint produces zero growth. Name it explicitly.

**Step 4 — Rebuild only what survives.** Take each part and ask: what is the cheapest version of
this that is still true? (e.g. concierge delivery before automation; 10 hand-researched leads
before a scraper; one page before a site.)

**Step 5 — Stress it.** Three attacks, minimum:
- **The "so what" attack:** the customer's alternative is *doing nothing*. Why is doing nothing
  worse? (Most plans fail here.)
- **The commoditization attack:** what stops the customer switching to a cheaper clone, or doing it
  with a free AI tool themselves? The answer is normally a proprietary asset: proprietary demand
  (audience), proprietary data, proprietary distribution, or trust.
- **The dependency attack:** who can unilaterally end this (a platform's ToS, a data provider, one
  key person)? What is the plan if they do?

## Output template

```
WHO PAYS:            ...
PAYS FOR:            ...
WHY NOW:             ...
PRICE + MECHANISM:   ...
COST TO DELIVER:     ...      (marginal / fixed / my hours per unit)
MUST BE TRUE:        [1] ...  [2] ...  [3] ...
BINDING CONSTRAINT:  ...
PROPRIETARY ASSET:   ...
SINGLE POINTS OF FAILURE: ...
CHEAPEST TRUE VERSION: ...
FIRST TEST:          ...      (see business/experiment-engine)
KILL IF:             ...
```

## Questions that have killed the most bad plans

1. Who has paid actual money for this *before* we existed? Name them, or admit none.
2. What did they pay, and what did they switch from?
3. If we doubled the price, who leaves?
4. If a competitor with 100× our resources copied this tomorrow, what do we still have?
5. What is the smallest sale (£/$ amount) we would accept? If we would not accept it, why not?
6. Is the buyer the same person as the user? (If not, the model has two sales cycles, and the
   budget holder usually buys *risk reduction*, not the feature.)
7. What happens to this business if the cheapest delivery tool triples in price?

## Failure modes

| Symptom | Reality |
|---|---|
| Six parts written, all with "businesses" as the who | ICP is undefined; go to `research/lead-sourcing-at-scale` Phase 1 |
| "Why now" = "AI is big" | Not a trigger; it's a fashion. Find the specific change in *this* customer's life |
| Price has no mechanism | There is no business yet, only a wish |
| Cost section has no hours | You have hidden the largest real cost |
| Proposition survives only if the customer already wants it | No demand creation. That is a marketing budget you do not have |

## Hard rule

If the six-part model cannot be filled in from evidence (not priors), the correct next action is
**not** to build. It is to run the cheapest possible demand test — 10 conversations, or one page
with a price on it — and return with data.