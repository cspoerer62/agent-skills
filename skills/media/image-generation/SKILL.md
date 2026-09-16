---
name: image-generation
description: Produce images and artwork that serve a business purpose — prompt construction, model choice, brand conformance, licensing, and when NOT to generate. Use for hero images, illustrations, social assets, ad creative, icons, diagrams. Triggers on "image", "picture", "artwork", "illustration", "graphic", "hero image", "make a logo", "social image", "ad creative", "thumbnail".
---

# Image Generation

Inherits all tokens from `design/brand-and-design-system`. An image that doesn't conform to the
palette and aesthetic family is worse than no image — it makes a page look assembled from stock.

## First: decide whether an image should exist at all

The default for business pages is **fewer, better images**, not more. Ask what job this image does:

| Job | Right answer |
|---|---|
| Show the product | **Screenshot of the real thing.** Never a generated fake — a generated UI is a lie about what you've built |
| Show the team / customers | **Real photos.** Generated faces presented as staff or testimonials is fraud |
| Explain a process/structure | **Diagram** (SVG/HTML/CSS) — sharper, accessible, editable, tiny. Generation is the wrong tool |
| Show data | **Chart from real data.** Never a generated "chart" — the numbers would be fictional |
| Set tone / fill a hero | Generated abstract or illustrative image is legitimate here |
| Icons | Established open icon set (Lucide, Heroicons, Phosphor) — consistent and free. Don't generate |
| Decorative texture/pattern | Generation or CSS both fine |

**If an image's job is to prove something, it must be real.** Generation is for tone, illustration,
and abstraction — never for evidence. This is the line that matters most in this skill.

Also: a generated image that adds nothing costs LCP and adds visual noise. Whitespace is free and
often better (`design/brand-and-design-system`).

## Model choice

OpenRouter already carries image-capable models on the account — check `list_models` for what's
actually available now rather than assuming; capability turns over fast. General guidance:

| Need | Look for |
|---|---|
| Photoreal scenes | Current top-tier diffusion/photoreal model |
| **Text rendered inside the image** | A model specifically strong at typography — most are poor. **Prefer overlaying real HTML/SVG text instead**; it's sharper, translatable, and accessible |
| Consistent character/style across a set | Model with style-reference or seed control |
| Transparent background | Model supporting alpha, or generate + remove background |
| Precise layout control | Don't generate — compose in HTML/CSS/SVG and screenshot |
| Editing an existing image | Inpainting-capable model |

**Verify before relying on it**: I have no confirmed image-generation *tool* in my own kit — my
kit is `web_fetch` plus repo writes. Calling an image API via `web_fetch` needs an endpoint and a
key; if no key is available, the correct output is a **prompt pack + spec** for a human to run, plus
a `surface_finding` requesting the capability. Do not describe an image as generated if it wasn't.

## Prompt construction

Structure, in this order — specificity front-loaded:

```
[subject] , [action/state] , [composition & framing] , [lighting] ,
[color palette — use the actual brand hex values] , [style/medium] ,
[aesthetic family] , [detail & mood] , [aspect ratio] , [negative prompt]
```

Worked example:
> Isometric illustration of a small fleet of three white service vans arranged on a light grid
> surface, elevated three-quarter view, soft even studio lighting, palette limited to #FFFFFF
> #F4F5F7 #111111 with a single #2F6FED accent, flat vector illustration with subtle long shadows,
> Swiss minimal aesthetic, generous negative space, calm and precise, 16:9.
> Negative: text, logos, watermarks, photorealism, clutter, gradients, lens flare, people's faces.

Rules that actually change output quality:
- **Name the palette with hex values from the brand tokens.** This single move is what makes a set
  of images look like one brand instead of a stock-photo grab bag.
- **Specify the medium** (flat vector / isometric / 35mm photo / risograph / line drawing). "Nice
  image" produces the model's generic default, which is instantly recognizable as AI.
- **Specify composition and negative space** — you usually need room for a headline to sit on top.
- **Always use a negative prompt** including `text, watermark, logo, extra fingers, distorted hands`.
- **Aspect ratio up front**, matched to slot: hero 16:9 or 21:9, social 1:1 / 4:5 / 9:16, OG 1.91:1.
- **Iterate one variable at a time** and keep a log of prompt → output → verdict. Otherwise you
  can't reproduce the one good result.
- **Generate a set, not a single image** (4–8), then select. Selection is most of the quality.

## Brand conformance — the part that gets skipped

A set of individually-good images with inconsistent style looks worse than consistent mediocre ones.
Lock these across every image in a set and record them in the repo:

```
STYLE LOCK
medium:        flat vector isometric
palette:       #FFFFFF #F4F5F7 #111111 #2F6FED
lighting:      soft even, no hard shadows
perspective:   3/4 isometric, 30°
line weight:   none (fills only)
negative:      text, faces, watermarks, gradients
aspect:        16:9
seed/style-ref: <if the model supports it>
```

Reuse the block verbatim for every image in the set.

## Technical output requirements

- **Export WebP/AVIF** with a JPEG/PNG fallback if needed. A 4MB PNG hero is a performance bug.
- **Size to the actual slot** (2× for retina, no more). Don't ship 4096px for a 600px slot.
- Provide `srcset` for responsive slots; set explicit `width`/`height` to prevent CLS.
- **Real `alt` text** describing content and function — decorative images get `alt=""`, not a
  keyword dump.
- Strip metadata. Name files descriptively (`hero-fleet-isometric-16x9.webp`).
- Keep the source prompt alongside the asset in the repo so it's reproducible.

## Licensing, rights, and disclosure

- **Do not generate in the style of a living named artist**, and don't reproduce trademarked
  characters, brand logos, or another company's identity.
- **Don't generate recognizable real people**, and never generate a face to present as a real
  customer, employee, or testimonial. That's fabricated proof
  (`design/web-page-build` boundary, `sales/outbound-compliance` gate 6).
- **Check the model's commercial-use terms** before using output commercially. Terms differ per model
  and change; verify at the time of use rather than assuming.
- Keep provenance: model, version, prompt, date, for every published asset. If a client or platform
  asks whether an image is AI-generated, the answer is yes, without hedging.
- Respect platform disclosure rules (some ad networks and app stores require labeling AI content).

## Failure modes

| Symptom | Cause | Fix |
|---|---|---|
| Looks "obviously AI" | No medium/style specified; model default | Name medium + aesthetic family + palette |
| Set looks mismatched | No style lock | Apply the style-lock block to all |
| Garbled text in image | Models are poor at typography | Overlay real HTML/SVG text instead |
| Doesn't fit the slot | Aspect ratio not specified | Specify up front; leave negative space for copy |
| Page got slow | Huge PNGs | WebP/AVIF, correct dimensions, lazy-load |
| Good result, can't reproduce | Changed many variables, no log | One variable at a time; log prompt + seed |
| Image conveys a false claim | Generated something presented as real | Use a screenshot/photo, or remove it |

## Boundaries

- **No fabricated evidence**: no fake product screenshots, no fake people as customers/staff, no
  invented charts, no fake awards or press logos.
- No impersonation of real people or brands; no trademarked or copyrighted characters.
- I write files and specs into a repo. **I cannot deploy.** If no image API/key is reachable from my
  toolset, I deliver a prompt pack + style lock + `surface_finding` requesting the capability —
  and I say plainly that no image was generated rather than implying one was.
