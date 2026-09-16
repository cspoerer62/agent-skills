---
name: premortem-red-team
description: Assume the plan has already failed and work backwards to the cause, before committing. Use on any plan, offer, launch, campaign, build, or deal that involves real time or money, and on any plan another agent produced. Also use as the adversarial pass on my own reasoning. Triggers on "what could go wrong", "risk", "premortem", "red team", "stress test", "before we launch", "review this plan".
---

# Premortem & Red Team

Two complementary passes. The **premortem** is prospective hindsight — assume failure, explain it.
The **red team** is adversarial — attack the plan as a motivated opponent would.

Run the premortem on your own plan. Run the red team on someone else's (or ask for it to be run on
yours by a different model/agent, which is strictly better than self-red-teaming).

## Part 1 — Premortem

**Setup sentence (write it literally):**
> "It is <date + 90 days>. This failed. It did not fail because of bad luck or a market crash —
> it failed because of something in the plan. Write that thing."

Then generate failure causes across these six buckets — one hit per bucket minimum:

| Bucket | Prompt | Typical real cause |
|---|---|---|
| **Demand** | Nobody wanted it | Wrong ICP, no trigger, alternative was "nothing" |
| **Distribution** | Nobody saw it | No channel, channel too expensive, deliverability/algorithm killed reach |
| **Delivery** | We couldn't produce it | Founder's hours, tooling broke, quality fell with volume |
| **Money** | The math was wrong | CAC > margin, refunds, chargebacks, slow payers |
| **Trust/legal** | We got blocked or sued | ToS violation, spam complaints, no consent, unlicensed data |
| **Dependency** | A third party ended it | Platform ban, API key revoked, vendor changed pricing |

**Score each cause: Likelihood (H/M/L) × Impact (H/M/L).**
Anything H×H gets either (a) a mitigation *added to the plan now*, or (b) an explicit acceptance
recorded in writing. "We'll deal with it" is not one of the options.

**Then answer the three questions that matter more than the list:**
1. Which failure would we not notice until it was too late? → add the earliest observable signal to
   a review checkpoint.
2. Which failure is cheapest to prevent right now? → do that one this week.
3. Which failure, if it happened, would we lie to ourselves about? → pre-commit the rule.

## Part 2 — Red Team

Attack like a competitor or a skeptical buyer, not like a reviewer.

### Attack set (use all of these, in order)

1. **Steelman-then-kill.** Write the strongest version of the plan. Then find the single fact that
   breaks it. If you cannot find one, you are either right or not trying.
2. **The buyer's-alternative attack.** The real competitor is *doing nothing* and *a free tool*.
   Quantify: what does the customer lose per month by not buying? If it's not a number they'd
   already track, there is no urgency.
3. **The cheapest-clone attack.** Who could reproduce this in a week with AI, and what happens to
   price when they do?
4. **The unit-economics attack.** Recompute CAC and payback from *conservative* assumptions
   (see `business/unit-economics`, Pessimistic column). Does the plan still clear?
5. **The operations attack.** What happens at 10× volume? At 0.1× attention from Carl?
6. **The provenance attack.** Which claims in this plan are graded C/D/E
   (see `thinking/evidence-grading`)? Is any of them load-bearing?
7. **The incentive attack.** Who benefits if this plan is believed, including me? Is my
   recommendation shaped by what's easy for an agent to do rather than what's right?
8. **The reversibility attack.** What is irreversible here? Is it necessary?

### Output format

```
PREMORTEM (top 3-5, scored L×I, with mitigation or explicit acceptance)
  1. <cause>            L/M  I/H   → MITIGATE: <action>  | ACCEPT: <why>
RED TEAM
  Attack 1 ... 8       → each: <finding, and whether plan changed>
SURVIVES?              yes | yes-with-changes | no
HARDEST THING TO FIX:  <...>
WHAT WOULD CHANGE MY MIND: <...>
```

## Rules

- **A red team that finds nothing is a failed red team.** If after all eight attacks the plan is
  unchanged, state explicitly which attack you think was weakest and why you could not break it.
- **Separate "wrong" from "unproven".** Most plans are not wrong, they are unproven — the fix is a
  test, not a rewrite.
- **Never soften the finding for the operator's feelings.** Carl asked for no restrictions. The
  useful output is the one that says "this will not work, and here is the number that shows it."
- **Attack the plan, not the person.** Attribute causes to design decisions, not to competence.
- **Do not use this to block cheap reversible bets.** A pre-mortem on a 1-hour test is waste.
  Classify the decision first (`thinking/decision-quality` §0).

## Anti-patterns

| Anti-pattern | Looks like | Fix |
|---|---|---|
| Vague worry | "execution risk" | Name the mechanism and who does it |
| Risk theatre | 40 risks, none mitigated | Cap at 5, each with a mitigation or acceptance |
| Permission-seeking | Red team used to justify inaction | Add: "what would make this a yes?" |
| Consensus red team | Attacking what the plan already says it handles | Attack the frame, not the details |
| Single-hypothesis | Only attacks the main path | Always include "the ICP is simply wrong" |