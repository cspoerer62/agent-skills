---
name: offer-design
description: Turn a capability into a priced offer a specific buyer can say yes to — with the promise, the mechanism, the price, the risk reversal, and the proof. Use when deciding how to package and price anything we sell, when a buyer says "interesting but not now", or when converting a service into a product. Triggers on "what do we charge", "package this", "how do we sell it", "make it an offer", "guarantee", "tiers", "proposal".
---

# Offer Design

A capability is not an offer. An offer is a specific buyer, a specific outcome, a specific price, a
specific timeframe, and a specific answer to "what happens if it doesn't work".

## The eight components (all eight, or it isn't finished)

1. **Buyer.** The named role/segment (from `research/lead-sourcing-at-scale` Phase 1).
2. **Outcome, stated as a result the buyer would recognise.** Not "AI-generated website" but
   "a 5-page site that loads in under 1s and books appointments, live in 5 days".
3. **Mechanism.** *Why* this works — the 3 steps. Buyers need a causal story, not features. The
   mechanism is also what makes the offer hard to compare on price alone.
4. **Price + unit + payment mechanism.** One number, one unit. Three tiers max; the middle tier is
   where most buyers land, so design it that way on purpose.
5. **Time-to-value.** Days, not "ongoing". State the first milestone.
6. **Risk reversal.** The guarantee. Options, strongest to weakest: outcome guarantee ("we book
   you N appointments or you don't pay"), partial refund, performance-linked payment, or a free
   paid pilot. **Only offer a guarantee you have computed you can afford** — see `business/unit-economics`
   (assume 5–10% claim in the pessimistic column).
7. **Proof.** What makes it believable: a concrete result, a named reference, a live artifact,
   a relevant before/after. "We built X for Y and it did Z" beats any credential.
8. **Scarcity/urgency that is TRUE.** Capacity ("3 builds per week"), a deadline that exists for an
   external reason, a price that genuinely rises. **Fake scarcity is a business-ending habit** in a
   small market — one embarrassed buyer costs more than the urgency gained.

## Pricing logic, in order

1. **Anchor to the buyer's alternative cost**, not to our effort: what does the problem cost them
   per month (lost hours × their rate, lost jobs, compliance fine)? Price at a fraction of that.
   A $3,000/month loss justifies $500–1,000/month.
2. **Then check against our floor:** price ≥ 3 × (delivery cost + CAC/expected customers). If it
   doesn't clear, either raise price or cut delivery cost — never cut the hours.
3. **Then pick the shape:**
   - Recurring > one-off whenever the value is continuous (retainer, subscription, management fee).
   - Usage-based when value scales with volume, but only when the buyer can predict the bill.
   - Value-based when the outcome is measurable and large — but requires measurement agreement up front.
4. **Price for the segment, not the average.** Three tiers: a cheap "start here" (removes the
   decision), a main tier (where you want them), and a premium tier that exists mainly to make the
   main tier look reasonable. The premium tier must be *actually* deliverable if bought.
5. **Never discount silently.** Discount in exchange for something concrete: prepayment, a
   testimonial, a case-study right, a longer term, a referral. A discount with nothing in return
   teaches the buyer the price was fake.

## Offer one-liner formula

> "I help **[specific buyer]** get **[specific outcome]** in **[timeframe]**, using **[mechanism]**.
> It costs **[price]**. If it doesn't **[measurable result]**, **[risk reversal]**."

If any slot needs a paragraph, the offer is not yet designed.

## Objection pre-handling

Write the response to each *now*, so outreach and the page both carry it:

| Objection | What it really means | Pre-handle by |
|---|---|---|
| "Too expensive" | Value not seen, or wrong buyer | Anchor to their cost of the problem; show ROI |
| "Not now" | No urgency | Name the trigger event; tie a real deadline |
| "We tried something like this" | Prior failure = trust debt | Ask what failed; differentiate the mechanism |
| "Can you do it for less?" | Testing the price | Hold price, change scope |
| "I need to think about it" | Unclear next step | Offer a smaller, cheaper first step |
| Silence | Message didn't reach or didn't land | Change the channel/angle (see `sales/outbound-sequences`) |

## Output template

```
BUYER:            ...
OUTCOME:          ...
MECHANISM (3 steps): 1) ... 2) ... 3) ...
PRICE:            $X / <unit> / <period>   MODE: <card | invoice | platform>
PAYMENT MECHANISM AVAILABLE? <yes | no — needs Carl to wire a processor>
TIME TO VALUE:    <days> first milestone: ...
RISK REVERSAL:    <guarantee, and the pessimistic cost of honouring it>
PROOF:            <result / reference / live artifact>
TIERS:            $ / $$ / $$$
TRUE URGENCY:     <capacity | deadline | none>
FLOOR CHECK:      price vs 3×(delivery + CAC/n customers) = ...
FIRST TEST:       <cheapest way to find out if this offer sells — see business/experiment-engine>
```

## Rules

- **Only build the delivery after someone has said yes to the offer, or after a paid pilot.** The
  correct order is offer → yes → build. Building first is how agents waste a week.
- **Ask for money, not for feedback.** "Would you pay $X for this?" is the only question that
  produces real information. Compliments are free and therefore worthless.
- **Never present a price I have no mechanism to collect.** If there's no payment path, say so and
  escalate as a `surface_finding` — pricing and money movement are Carl's calls.
- **One offer per campaign.** Two offers in one message halves both.
- **Raise price before adding features.** Most failed offers are underpriced, not underfeatured.