---
name: web-page-build
description: Build a landing or marketing page that converts — message hierarchy, section order, copy rules, technical baseline, accessibility, and the measurement loop. Use for any page whose job is to get a visitor to act. Triggers on "landing page", "website", "build a page", "homepage", "our site", "conversion", "sign-up page", "web page".
---

# Web Page Build

**Gate: `business/unit-economics` runs BEFORE this skill, not after.** The classic autonomous-agent
failure is a beautiful page for something nobody pays for. If the unit economics aren't written
down, building the page is premature.

Inputs: positioning line from `research/competitor-teardown`, offer from `business/offer-design`,
aesthetic family from `design/brand-and-design-system`.

## Principle: the page has exactly one job

One page, one audience, one action. A page with three calls-to-action has none. Before writing any
markup, fill in:

```
AUDIENCE:  <the specific person, from the ICP>
THEY WANT: <outcome in their words, from discovery quotes>
ONE ACTION: <the single thing they do — book / buy / reply / submit>
SUCCESS METRIC: <% of visitors who do it, measured how>
```

If you can't fill these four lines, **stop** — the problem is positioning, not design, and no
amount of layout fixes it.

## Section order (the sequence that works, top to bottom)

| # | Section | Job | Rule |
|---|---|---|---|
| 1 | **Hero** | Answer "what is this and is it for me" in <5 seconds | Headline = outcome, not product category. Subhead = who it's for + how. One primary CTA, visible without scrolling |
| 2 | **Proof strip** | Immediate credibility | Logos, counts, a named quote. **Only true ones** |
| 3 | **Problem** | "They understand my situation" | Their words, from discovery. No invented pain |
| 4 | **Solution / how it works** | Reduce perceived risk | 3 steps max. Show, don't describe — a screenshot beats a paragraph |
| 5 | **Outcome / benefits** | Make the after-state concrete | Specific and measurable, not adjectives |
| 6 | **Objection handling** | Kill the top 3 reasons they won't act | Pull the real top 3 from `sales/pipeline-and-closing` |
| 7 | **Pricing** | Remove uncertainty | **Publish it.** Hiding price loses more self-serve buyers than it protects margin |
| 8 | **FAQ** | Catch the long tail | Real questions from real conversations only |
| 9 | **Final CTA** | Convert the persuaded | Same action as the hero. Never a new one |

**The hero headline is ~80% of the page's performance.** Spend proportional effort there.

Headline test — it must fail this sentence: *"Any competitor could put this on their site."*
- Bad: "Streamline Your Workflow" / "The Modern Platform for Teams" — category noise, interchangeable.
- Good: "Plan your week's van schedule in 20 minutes, not 4 hours." — outcome, specific, theirs.

## Copy rules

- **Second person.** "You get" not "we provide."
- **Specific numbers beat adjectives.** "Cuts Monday planning from 4 hours to 30 minutes" ≫
  "dramatically more efficient."
- **Strike every one of these on sight:** *seamless, robust, cutting-edge, revolutionary,
  next-generation, leverage, empower, unlock, elevate, game-changing, best-in-class, holistic,
  synergy, solutions.* They carry zero information and signal that no one thought about the reader.
- **No claim without evidence.** No invented testimonials, no fake logos, no fabricated counts, no
  "trusted by thousands" without the number. This is non-negotiable — fake proof is fraud, and it's
  the fastest way to end a business.
- **Read it aloud.** Anything you wouldn't say to a customer's face gets cut.
- **CTA text says what happens next**: "Book a 15-min call", "Start free — no card", "Get the
  quote". Never "Submit", "Learn more", "Click here".

## Technical baseline (non-negotiable)

- **Semantic HTML**: one `<h1>`, ordered headings, `<main>`/`<nav>`/`<footer>`, real `<button>`/`<a>`.
- **Mobile-first.** Most traffic is mobile; design the narrow viewport first, tap targets ≥44px.
- **Performance budget**: LCP <2.5s, CLS <0.1, total JS <100KB on a landing page. A marketing page
  needing a heavy SPA framework is over-built — static HTML/CSS is usually correct and always faster.
- **Images**: modern formats (WebP/AVIF), explicit `width`/`height` to prevent layout shift, lazy-load
  below the fold, real `alt` text.
- **Accessibility (WCAG 2.2 AA)**: contrast ≥4.5:1 body text, visible focus states, full keyboard
  operability, labelled form inputs, no information conveyed by color alone, `prefers-reduced-motion`
  honored. Accessibility is also SEO and also just more usable — it isn't charity.
- **SEO basics**: unique `<title>` (<60 chars) and meta description (<155), Open Graph + Twitter
  card, canonical URL, `sitemap.xml`, `robots.txt`, JSON-LD (`Organization`, `Product`, or
  `LocalBusiness` — the last one matters enormously for local trade businesses).
- **Forms**: minimum fields (every extra field costs conversions), inline validation, honest error
  messages, a real success state, spam protection that isn't a hostile CAPTCHA.
- **Privacy**: cookie/analytics consent where required; **don't load trackers before consent** in
  EU/UK. Prefer cookieless analytics and skip the banner entirely — faster and cleaner.
- **Security review** any page with a form or third-party script (upstream `trailofbits/skills`):
  validate server-side, no secrets in client code, CSP header, no unpinned third-party JS.

## Measurement loop

Shipping is the start, not the end. Instrument from day one:
1. **Visitors** (source/medium), 2. **scroll depth**, 3. **CTA clicks**, 4. **form starts**,
5. **form completions**, 6. **qualified outcomes**.

The drop-off between consecutive steps tells you what to fix — nothing else does:

| Drop-off | Diagnosis | Fix |
|---|---|---|
| Visitors → scroll | Hero fails the 5-second test | Rewrite headline. Highest leverage available |
| Scroll → CTA click | Not persuaded, or trust missing | Proof, objections, pricing clarity |
| Click → form start | Form looks costly | Fewer fields; state what happens next |
| Start → complete | Friction or distrust | Cut fields; show privacy; fix validation |
| Complete → qualified | **Traffic is wrong, page is fine** | Don't touch the page — fix targeting |

Change **one thing at a time** and give it enough traffic. Per `business/experiment-engine`: an A/B
test below a few hundred conversions per arm cannot distinguish a real effect from noise — at low
traffic, prefer decisive rewrites over 5% tweaks, and judge by qualified outcomes.

## Failure modes

| Symptom | Cause | Fix |
|---|---|---|
| Beautiful page, no conversions | Built before the offer was validated | Back to `business/offer-design` / unit economics |
| Traffic, no action | Hero doesn't state who it's for | Rewrite headline as outcome + audience |
| Leads all unqualified | Page is vague, attracts everyone | Add specificity and publish price — it self-filters |
| "Contact us for pricing" | Fear of anchoring | Publish a number or a range |
| Page nobody visits | No distribution plan | A page is not a channel. Pair with outreach/SEO/ads |
| 3 CTAs | Couldn't choose | Choose |

## Boundaries

- **I can write the files into a repo. I cannot deploy** — no Vercel/Netlify/Cloudflare token exists
  in my toolset. A finished page exits as a repo artifact plus a `surface_finding` noting it needs a
  deploy target. Don't describe an undeployed page as "live."
- **No fabricated social proof, testimonials, logos, counts, or results.** If proof doesn't exist,
  the page says what we will prove and how.
- No dark patterns: no fake countdowns, no fake stock counters, no confirm-shaming, no pre-checked
  consent boxes, no hidden unsubscribe. They convert marginally better once and cost the brand
  permanently — and several are illegal in the EU/UK.
- Don't claim a performance/accessibility number I haven't measured; run the check or say it's unmeasured.
