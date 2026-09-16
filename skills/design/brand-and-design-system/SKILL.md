---
name: brand-and-design-system
description: Turn design from a taste argument into a repeatable decision — pick a named aesthetic family, then derive tokens (type scale, color, spacing, radius, motion) and hold every artifact to them. Use before building any page, deck, image, or video so output is consistent. Triggers on "design", "brand", "logo", "colors", "font", "style", "make it look good", "design system", "does this look right".
---

# Brand & Design System

Design disagreements are unresolvable when framed as taste ("I don't like the blue"). They are
trivially resolvable when framed as **conformance to a chosen system** ("that blue isn't in the
palette"). This skill's entire purpose is to convert the first conversation into the second.

Pairs with upstream `bergside/awesome-design-skills` (67 named aesthetic families with a
machine-readable `index.json`) and `anthropics/skills` → `brand-guidelines`, `theme-factory`,
`canvas-design`. Feeds `design/web-page-build` and `media/image-generation`.

## Step 1 — choose a named aesthetic family FIRST

Do not start with colors. Start by naming the family, because the family constrains every later
choice and makes them consistent by construction.

| Family | Looks like | Right when | Wrong when |
|---|---|---|---|
| **Minimal / Swiss** | Lots of white space, one accent, strong type hierarchy | Default. B2B, professional services, anything credibility-led | You need warmth or personality |
| **Editorial** | Serif headlines, generous measure, magazine grid | Content-led, thought leadership, long-form | Product UI, conversion pages |
| **Premium / luxury** | Dark or muted, tight tracking, restrained motion, serif or refined sans | High price point, trust-critical | Cheap/self-serve — it reads as mismatched |
| **Professional / corporate** | Blue-grey, safe, dense information | Enterprise, finance, regulated, local trade | Consumer, differentiation-led |
| **Bento** | Modular rounded cards in a grid | Feature showcase, dashboards, "many things at once" | Single narrative flow |
| **Neobrutalism** | Hard borders, flat blocks, raw type, harsh shadows | Dev tools, deliberate anti-polish | Trust-critical (money, health, legal) |
| **Glassmorphism** | Blur, translucency, gradients | Tech-forward, visual product | Accessibility priority — contrast is hard |
| **Bold / high-contrast** | Huge type, saturated color | Consumer, campaigns, youth | Information density |
| **Clean / modern SaaS** | Rounded sans, soft shadows, one gradient accent | Software products. Safe, unmemorable | Needing differentiation |

**Selection rule: the family must match the price point and the trust requirement.** Expensive,
trust-critical things look restrained; cheap, playful things can be loud. Mismatch here is what
makes a site feel "off" in a way people can't name — a premium price on a neobrutalist page reads
as unserious, and a bold consumer offer on a corporate-blue page reads as dead.

**Pick one. Write down its name. Do not blend families** — blending is the single most common
cause of amateur-looking output.

## Step 2 — derive tokens

Tokens are the contract. Once written, every artifact conforms or is wrong; there is nothing to argue about.

### Type
- **Two typefaces maximum** (often one with two weights). A display/heading face + a body face.
- **Body text 16–18px minimum**, line-height 1.5–1.65, measure **60–75 characters** — this single
  constraint does more for perceived quality than any other.
- **Modular scale**, ratio 1.2 (conservative) or 1.25/1.333 (dramatic). Compute once, use only
  these sizes:
  `12 / 14 / 16 / 20 / 25 / 31 / 39 / 49` (1.25 from 16)
- Headings: tighter line-height (1.1–1.25) and slightly negative letter-spacing at large sizes.
- **System font stacks are legitimate and fast.** A webfont costs real LCP; justify it or skip it.

### Color
Fewer colors than you think. The discipline is the point.
```
--bg            page background
--surface       cards/panels (one step off bg)
--text          body            (contrast ≥4.5:1 on bg — verify, don't eyeball)
--text-muted    secondary       (contrast ≥4.5:1 — muted text is where AA fails most often)
--border        hairlines
--accent        ONE brand color — CTAs and links only
--accent-hover
--success / --warning / --danger   semantic only, never decorative
```
Rules:
- **One accent.** Two accents means neither is a signal. The accent is reserved for *the action*; if
  it's also the heading color and the icon color, the CTA stops being findable.
- **Verify contrast numerically** (WCAG 2.2 AA: 4.5:1 body, 3:1 large text and UI boundaries). Never
  "looks fine to me."
- **Never encode meaning in color alone** — add an icon, label, or shape.
- Neutrals do the work; the accent is a garnish.

### Spacing
One base unit (4px or 8px), and **only** multiples of it: `4 8 12 16 24 32 48 64 96 128`.
Arbitrary values (13px, 22px) are the signature of an ad-hoc design.
- **Relatedness is communicated by proximity.** Space *between* groups must clearly exceed space
  *within* a group — this is the most-violated and highest-impact layout rule.

### Radius, elevation, motion
- Radius: pick one scale (`0 / 4 / 8 / 16 / full`) and apply consistently. Sharp = serious; round = friendly.
- Elevation: 2–3 shadow levels max. Shadows imply hierarchy — flat things aren't clickable.
- Motion: 150–250ms, ease-out for entrances. **Honor `prefers-reduced-motion`.** Motion clarifies
  state change; decorative motion is a liability.

## Step 3 — write it down, then conform

Emit a real artifact — a `DESIGN.md` plus CSS custom properties (or the framework's token file) — in
the repo:

```css
:root{
  --font-display:...; --font-body:...;
  --step-0:1rem; --step-1:1.25rem; --step-2:1.563rem; --step-3:1.953rem;
  --space-1:.25rem; --space-2:.5rem; --space-3:.75rem; --space-4:1rem; --space-6:1.5rem; --space-8:2rem;
  --radius:8px; --bg:#fff; --text:#111; --accent:#...;
}
```

Then the review question is never "do I like this?" It is **"which token does this violate?"**

## Logo & identity (pragmatic)

For an early business the logo matters far less than consistency. A **wordmark in the brand
typeface**, set properly, is credible, free, instantly consistent, and beats a bad icon. Requirements:
legible at 16px favicon size, works in one color, works on light and dark. Don't commission an
identity before the offer is validated — it's a spend that can't be judged yet.

## Checklist before shipping any artifact

- [ ] Named aesthetic family stated, and the artifact matches it
- [ ] Only palette colors used; **contrast verified numerically** at AA
- [ ] Only type-scale sizes; body ≥16px; measure 60–75ch
- [ ] Only spacing-scale values; group spacing > intra-group spacing
- [ ] One accent, used only for the primary action
- [ ] Consistent radius and ≤3 elevation levels
- [ ] Keyboard focus visible; `prefers-reduced-motion` honored
- [ ] Renders correctly at 360px wide
- [ ] Real content, not lorem ipsum — **layout that only works with placeholder text is broken**

## Failure modes

| Symptom | Cause | Fix |
|---|---|---|
| "Looks amateur", can't say why | Blended families; arbitrary spacing | Name one family; snap all values to scale |
| Nothing stands out | Accent used everywhere | Reserve accent for the action only |
| Cramped/hard to read | Measure too wide, line-height too tight, body too small | 60–75ch, 1.5+, ≥16px |
| Looks fine to me, fails audit | Contrast eyeballed | Compute ratios |
| Inconsistent across pages | Tokens never written down | Emit DESIGN.md + CSS vars; review against tokens |
| Breaks with real content | Designed around placeholder text | Rebuild with longest realistic strings |

## Boundaries

- I produce specs, tokens, CSS, and markup into a repo. **I cannot deploy**, and I have no design
  tool — output is code and documentation.
- **No copying another company's identity**, and no using logos, fonts, or imagery without a license.
  Check font licenses for web + commercial use; prefer open families (Inter, Source, IBM Plex, Public
  Sans) or system stacks.
- No fabricated brand assets implying affiliation or endorsement that doesn't exist.
- Accessibility floor (WCAG 2.2 AA) is a **constraint, not a preference** — a design that requires
  breaking it is rejected and re-derived, not shipped with an exception.
