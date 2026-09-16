---
name: unit-economics
description: Compute CAC, LTV, payback period, contribution margin, and the break-even conditions for any offer, channel, or campaign before time or money is spent on it. Use whenever a plan involves acquiring customers, pricing anything, spending on ads or outreach, or judging whether a channel "works". Triggers on "is this profitable", "will this pay for itself", "CAC", "LTV", "ROI", "break-even", "how many customers do we need", "ad budget".
---

# Unit Economics

The gate that runs *before* building. An agent's most common expensive mistake is producing
something beautiful that cannot pay for its own acquisition.

## The seven numbers

Compute all seven. If a number is unknown, write `UNKNOWN + how I'd get it` — never a plausible guess.

| # | Number | Definition | Note |
|---|---|---|---|
| 1 | **Price** | What the customer pays per unit per period | Unit = seat / lead / project / month |
| 2 | **Gross margin / unit** | Price − direct delivery cost (fees, hosting, data, contractor) | Payments take ~3–4%; marketplaces 10–30% |
| 3 | **CAC** | Total cost to acquire one paying customer (ad spend + tooling + **your hours × your rate**) | The hours line is the one everyone hides |
| 4 | **Conversion path** | Impressions → clicks → leads → conversations → customers, each as a rate | Multiply to get lead-to-customer |
| 5 | **Payback period** | CAC ÷ (monthly gross margin) | If > 12 months for a small business, treat as bad |
| 6 | **Churn / repeat rate** | % lost per month, or average number of purchases | Determines whether LTV is real |
| 7 | **LTV** | Gross margin × average customer lifespan (or × purchases) | Use *gross margin*, never revenue |

Then the two derived gates:
- **LTV : CAC** — below **1:1** = destroying money; **3:1** = healthy for outbound/SMB;
  below 2:1 on a paid channel is fragile.
- **Break-even volume** = fixed cost ÷ gross margin per unit. State it as "we need N customers/month
  to cover fixed costs", then check it against the reachable list size.

## Three columns, always

Never present one column. Every table gets:

| | Pessimistic | Base | Optimistic |
|---|---|---|---|
| Reply rate | | | |
| Lead→customer | | | |
| CAC | | | |
| Payback (mo) | | | |
| LTV:CAC | | | |
| Break-even customers/mo | | | |

**Decision rule: the plan must clear on the Pessimistic column, or it is a bet, labelled as one.**
If it only clears on Optimistic, say so in the first line of the output.

## Benchmarks to calibrate against (grade per `thinking/evidence-grading` — these are priors, not truths)

| Channel | Typical cold reply | Typical lead→sale |
|---|---|---|
| Targeted B2B cold email (warmed domain, small volume) | 1–10% | 5–20% |
| Untargeted bulk email | ~0–1% and deliverability damage | — |
| Cold DM (LinkedIn/X) | 5–20% response, low qualify rate | 1–5% |
| Local SMB door/phone | 10–30% contact | 10–25% |
| Inbound content/SEO | slow (3–9 months) | 1–5% |
| Paid search (intent) | — | 2–10% on landing page |

Use these only as the pessimistic column's *starting point*. Then replace them with our own measured
numbers as soon as one campaign has run. A benchmark that has never been replaced by a measurement
after 30 days is a sign the campaign isn't being instrumented.

## Procedure

1. **Write the funnel out loud** as arithmetic with numbers, one line per stage:
   `1000 reached × 4% reply = 40 conversations × 15% close = 6 customers`
2. **Cost each stage.** Include tooling, list cost, sender domain, time at an explicit hourly rate
   (use $50/h as a default placeholder for skilled work; state it).
3. **Compute all seven numbers**, three columns.
4. **Apply the gates.** Payback < 12 mo (or < 3 mo for one-off low-ticket), LTV:CAC ≥ 2 (≥3 preferred),
   break-even customers ≤ (reachable list × pessimistic conversion).
5. **Find the binding constraint** — usually *the size of the reachable list* or *deliverability*,
   not the price. Say which it is.
6. **State the pre-condition** for the numbers to hold: "these assume a warmed domain sending ≤30/day"
   or "these assume the list is genuinely 500 qualified records, not 5,000 scraped rows".
7. **Write kill criteria** into the plan (`thinking/decision-quality` §4): e.g. "kill if reply rate
   < 2% after 100 sends" or "kill if CAC > $X after the first $200 of spend".

## Worked shape (illustrative, must be replaced with real numbers)

```
OFFER: $300 one-time website build for local service businesses
Gross margin/unit: $300 − $20 (hosting/domain) − $60 (template labour) = $220
Funnel (pessimistic): 400 contacted × 3% reply = 12 conversations × 20% close = 2.4 customers
Cost to reach 400: list $0 (public directories) + tooling $25 + 20h × $50 = $1,025
CAC (pessimistic): $1,025 / 2.4 = $427   →  CAC > price. NOT VIABLE at 20h.
Base (10h, 5% reply, 25% close): $525 / 5 = $105 → LTV:CAC single-purchase 2.1  → marginal
Break-even at $500 fixed/mo: 3 customers/mo → requires ~500 contacts/mo
BINDING CONSTRAINT: my hours per build, not demand.
IMPLICATION: automate build (template + config) or raise price to $1,200 with a result guarantee.
```

Note what the worked shape does: it *changed the plan*. Numbers that don't change the plan were
decorative.

## Rules

- **Never quote revenue as profit.** Gross margin after fees is the only number that compounds.
- **Always include your own hours**, at an explicit rate. Free labour makes almost anything "viable".
- **One-off vs recurring changes everything.** Recurring margin pays CAC back; one-off needs margin
  ≥ CAC at first purchase.
- **Refunds and chargebacks count.** For infoproducts/services, assume 5–10% in pessimistic.
- **Money math is a `surface_finding`.** I do not spend, price, or invoice. I produce the table and
  the recommendation; Carl decides and executes.