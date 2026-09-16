---
name: decision-quality
description: Run a decision through a pre-decision checklist before committing time, money, or reputation to it. Use when choosing between options, when about to start a project or a build, when asked "should we do X", when sizing a bet, or whenever a plan is about to become irreversible. Triggers on "should we", "which option", "worth it", "go/no-go", "decide", "prioritize", "what first".
---

# Decision Quality

Most bad decisions made by an agent are not wrong answers — they are *unasked questions*. This
skill forces the questions before the work starts, and writes the exit criteria before the exit is
emotionally expensive.

## 0. Classify the decision

| Type | Test | Process |
|---|---|---|
| **Reversible / cheap** | Undo cost < 1 day of work and < $100 | Decide now. Do not deliberate. Deliberation is the expensive part. |
| **Reversible / expensive** | Undo costs real money or a week | Write a 5-line plan, decide within 48h, set a review date. |
| **Irreversible** | Cannot be undone (a public launch, a signed contract, money out the door, a domain/name) | Full checklist below. |
| **Recurring** | Same decision will come up weekly | Do not decide it again — write a **policy** (a rule) and apply the rule. |

Naming the type is 80% of the value. Agents over-deliberate on reversible calls and under-deliberate
on irreversible ones.

## 1. State the decision as a question with a deadline

> "Choose between A and B by <date>, or default to <do nothing>."

A decision without a default and a deadline is a wish. Write both down.

## 2. Base rate first

Before reasoning about *this* case, ask: what normally happens to things like this?
- What fraction of similar projects/offers/pages/channels work?
- If I have no data, what is the honest prior? For a first cold-outreach campaign reply rate is
  single-digit percent; for a first landing page conversion, low single digits.

Write the prior as a number. Then ask what evidence would move it. If nothing you have would move
it more than a little, the honest answer is usually "decide cheaply and get real data".

## 3. Expected value, with the denominator stated

```
EV = P(success) × payoff − cost − P(failure) × downside
```

Then the part agents skip: **state the denominator.** "This generates $2k/mo" is meaningless
without: per how many hours, over how many months, at what churn, net of fees.

## 4. Kill criteria — written now

Write, before starting:

> "I will stop if, by <date>, <metric> is not at least <threshold>."

Rules:
- The metric must be **observable without new infrastructure**.
- The threshold must be one you would have accepted *before* you cared.
- The date must be short enough that stopping is cheap (default: 2 weeks for a build, 1 week for an
  outreach channel, 1 day for a page test).

This is the single highest-value output of the skill. Reviewing a live project without pre-written
kill criteria always produces "give it more time".

## 5. Pre-mortem (see `thinking/premortem-red-team`)

Ask: it is 90 days later and this failed. Write the three most likely causes. For each, either
add a mitigation *to the plan* or accept it explicitly.

## 6. What would change my mind

Write the falsifier: "I would reverse this if I learned ___." If you cannot write one, you are
not making a decision, you are expressing a preference.

## 7. Decide and record

```
DECISION:        <what>
TYPE:            reversible-cheap | reversible-expensive | irreversible | policy
DATE:            <decision date>   REVIEW: <review date>
DEFAULT IF NO ACTION: <...>
PRIOR:           <base rate>
EV:              <formula with numbers, denominator stated>
KILL CRITERIA:   stop if <metric> < <threshold> by <date>
PREMORTEM TOP 3: <causes + mitigation>
FALSIFIER:       reverse if <...>
```

## Anti-patterns

| Anti-pattern | What it looks like | Counter |
|---|---|---|
| Sunk-cost continuation | "we've already built half of it" | Kill criteria were written before; apply them mechanically |
| Analysis as avoidance | 6th research doc on a cheap reversible call | Classify first; cheap+reversible → decide now |
| Narrative override | A great story beats three weak numbers | Numbers get grades (see `thinking/evidence-grading`); the story doesn't |
| Option-keeping | Refusing to choose so nothing is lost | Not choosing *is* choosing the default — name it |
| Denominator omission | "% return!" with no time or base | Every number gets N and window |
| Decision re-litigation | Re-deciding weekly | If it recurs, write a policy and stop deciding |

## Output

A filled-in decision record, ideally committed to a repo so a later cycle can check whether the
kill criteria fired. A decision with no recorded kill criteria and review date is not finished.