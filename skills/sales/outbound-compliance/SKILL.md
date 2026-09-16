---
name: outbound-compliance
description: The gate that must be passed before any cold outreach is sent, and before any lead list is built. Covers CAN-SPAM, GDPR/PECR, CASL, consent basis, suppression, sending-domain hygiene, and what data may be collected about a person at all. Use before writing a sequence, before sourcing leads, and before asking a human to press send. Triggers on "cold email", "outreach", "send", "lead list", "scrape", "prospect", "unsubscribe", "GDPR", "opt-in", "buy a list", "find their email".
---

# Outbound Compliance

This skill exists to **enable sending**, not to prevent it. Cold outreach done wrong burns the
sending domain, the company identity, and occasionally produces a fine — and all three are
unrecoverable in a way that a slow pipeline is not. Done right it is a repeatable channel.

`sales/pipeline-and-closing` and `sales/outbound-sequences` are both downstream of this file. Read
this first, every time.

## The gate — all six must be YES before a single message goes out

| # | Gate | Fails if |
|---|---|---|
| 1 | **Lawful basis** for contacting this person exists and is named | You can't say which basis in one sentence |
| 2 | **The data was lawfully obtained** | It came from a login-walled scrape, a CAPTCHA bypass, or a purchased list of unknown provenance |
| 3 | **Identity is truthful** — real company, real human, real reply-to | From/reply-to is a lookalike, or the sender persona is invented |
| 4 | **Opt-out is present and works** | No unsubscribe route, or one that requires a login/reply-and-hope |
| 5 | **Suppression list checked** | No suppression file exists, or it wasn't consulted |
| 6 | **Claims in the message are true** | Any result, client, guarantee, or capability we cannot evidence |

**If any gate fails, the correct output is a `surface_finding` explaining which gate and what would
fix it — not a softened version of the message.**

## Lawful basis by jurisdiction — the short, operational version

This is operational guidance for choosing a posture, **not legal advice**; jurisdiction-specific
sign-off for a real sending program is a human/lawyer decision and should go out as a finding.

| Regime | Applies to | B2B cold email allowed? | The operative constraint |
|---|---|---|---|
| **CAN-SPAM** (US) | Commercial email to US recipients | **Yes**, opt-out regime | No deceptive headers/subject, valid physical postal address in the message, honor opt-out within 10 business days, clear identification as a commercial message |
| **GDPR + PECR** (UK/EU) | Any EU/UK person's data, incl. work email | **Corporate** addresses: generally yes under *legitimate interests*. **Sole traders / partnerships / personal-format addresses**: treated closer to individuals — need consent | Legitimate Interests Assessment (LIA) must exist *in writing before sending*; relevance to their actual job is what makes the interest legitimate; right to object must be honored immediately |
| **CASL** (Canada) | Canadian recipients | **Consent regime** — the strictest of the three | Needs express or *implied* consent (implied = existing business relationship, or a **conspicuously published** business address relevant to their role). Identify sender, provide opt-out. Penalties are real |
| **Sector overlays** | Healthcare, finance, minors, political | Often no | If the audience is regulated, escalate to a human before sending anything |

**Default posture when unsure of a recipient's jurisdiction: apply the strictest one that could
apply (CASL-grade).** Guessing in the permissive direction is how programs get killed.

### Writing the Legitimate Interests Assessment (the thing people skip)

Three questions, answered in writing, stored in the repo next to the sequence:
1. **Purpose** — what is the interest? ("Offer a service that addresses a problem specific to their
   role at a company of this type.")
2. **Necessity** — is direct contact actually needed to achieve it, or would advertising do?
3. **Balance** — would this person reasonably expect a message like this at this address? Would
   they be harmed or merely mildly annoyed? Volume and relevance dominate this answer.

If the honest answer to #3 is "they'd be surprised and irritated," the targeting is wrong — fix
the targeting, which also fixes the reply rate. Compliance and relevance point the same direction
almost always. That is the single most useful thing in this skill.

## Data collection — what may be gathered about a person

**Allowed:**
- Publicly published business contact details on a company's own site (`/contact`, `/team`).
- Official APIs and licensed data providers, used within their ToS and license.
- Public registries (Companies House, SEC/EDGAR, state business registries, official statistics).
- Opt-in lists we built ourselves, with the opt-in record retained.
- `robots.txt`-respecting reads of public pages at polite rate.

**Never:**
- Logging into a platform (LinkedIn, Maps, a directory) to extract data at scale. Breaks ToS, gets
  the *customer-facing* account banned, and any skill that wants credentials to do it is a
  credential-exfiltration primitive.
- Bypassing a CAPTCHA, paywall, or login wall.
- Buying a list whose consent provenance can't be evidenced. "The vendor says it's opt-in" is not
  evidence; ask for the opt-in record and the collection notice.
- Email permutation + verification bombing to guess addresses (`f.last@`, `first@`…). Guessed
  addresses hit spam traps, which is how domains die.
- Inferring or recording special-category data (health, ethnicity, religion, politics, sexuality,
  union membership) about a prospect. Ever, for any reason.

**Retention:** keep only fields with an operational use — name, role, company, public business
address, source URL, date collected, lawful basis. Delete on request, and record the deletion.

## Sending-domain hygiene — the practical survival rules

Deliverability is a compliance outcome, not a marketing trick.

- **Never send cold traffic from the primary company domain.** Use a separate but clearly-owned
  domain (e.g. `getcompany.com` alongside `company.com`) so a burn doesn't take invoices and
  password resets down with it.
- **SPF, DKIM, DMARC** all configured and passing *before* the first send. DMARC at least `p=none`
  with reporting, moving to `quarantine`.
- **Warm up**: ~10–20 sends/day/mailbox for the first two weeks, scaling gradually. Multiple
  mailboxes beat one high-volume mailbox.
- **Hard ceiling ~50/day/mailbox** for cold. Above that, reputation degrades regardless of content.
- **Validate the list** for syntax, MX, and known spam traps. Bounce rate >3% = stop and clean.
- **No link shorteners, no tracking pixels on cold** — both are spam signals and, in the EU, a
  pixel is itself a consent question. One plain link to a real page, or no link at all on touch 1.
- **Kill switches**: stop the whole program if bounce >3%, spam complaints >0.1%, or reply
  sentiment turns hostile.

## Message-level requirements

Every cold message must contain, without exception:
1. Who we are — real company name.
2. Why this person specifically (the relevance sentence; also the highest-performing line).
3. A truthful offer with no invented proof.
4. An opt-out that works: "reply STOP and I'll remove you" is acceptable for 1:1-style plain-text
   sending **only if the removal is actually executed** and logged; an unsubscribe link is required
   for anything bulk/templated.
5. A physical postal address where CAN-SPAM applies.

Never: fake `Re:` / `Fwd:` subject lines, fake "as discussed", fake mutual connections, invented
urgency/scarcity, or a persona who isn't a real person at the company.

## Suppression — the file that must exist

A single suppression list, consulted before every send, append-only:
- everyone who opted out, ever, on any channel or domain;
- everyone who said no (from `sales/pipeline-and-closing` stage 6-Lost);
- role addresses that shouldn't be cold-contacted (`abuse@`, `postmaster@`, `legal@`, `privacy@`);
- competitors, current customers (they belong to a different sequence), and known spam traps.

**An opt-out is global and permanent, not per-campaign.** Re-contacting a suppressed address is
the single fastest route to a complaint that sticks.

## Procedure

1. Define the segment and write the **relevance sentence** — why this exact role at this exact type
   of company. If you can't write it, stop; the list is wrong.
2. Identify jurisdiction mix. Choose the strictest applicable regime.
3. Write the lawful basis (and the LIA if relying on legitimate interests). Store it in the repo.
4. Verify data provenance for every source: where from, when, under what ToS/license. Grade it with
   `thinking/evidence-grading` — a list whose provenance is grade D/E does not get sent to.
5. Confirm domain hygiene (SPF/DKIM/DMARC, warmup state, separate domain).
6. Check the suppression list.
7. Draft via `sales/outbound-sequences`; re-check every claim for truth.
8. Run the six-gate table. Record PASS/FAIL per gate with one line of evidence each.
9. **Hand to a human to send.** I have no sender.

## Boundaries

- I can research, draft, sequence, build and grade lists, and write the compliance record. I
  **cannot send** — no sending tool exists in my kit, by design. Every finished sequence exits as a
  `surface_finding` or a repo artifact for Carl.
- I will not build a list by any method in the "Never" section above, and if asked to, the answer is
  a finding explaining the licensed/API path that achieves the same goal.
- Nothing here is legal advice. A real sending program at volume needs human sign-off on
  jurisdiction; that hand-off is mandatory, not optional.
- If a gate fails and there's pressure to send anyway, that decision belongs to Carl with the failure
  written down in front of him — never to me silently.
