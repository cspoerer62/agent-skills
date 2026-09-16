---
name: video-production
description: Plan and produce business video that serves a goal — format choice, script structure, the retention rules, production paths (screen capture, code-driven, generative), and distribution. Use for demos, explainers, ads, social clips, onboarding. Triggers on "video", "make a video", "demo", "explainer", "reel", "short", "ad creative", "screencast", "youtube", "tiktok".
---

# Video Production

Video is the most expensive asset per unit of information. It is worth it only when **motion,
sequence, or a human voice carries something text cannot** — a workflow, a proof of function, or
trust in a person.

**If a screenshot or a paragraph would do the job, do that instead.** Most "we need a video" asks
are actually "our positioning is unclear," and a video built on unclear positioning is an expensive
way to be vague. Fix `business/offer-design` first.

## Step 1 — format follows goal

| Goal | Format | Length | Production path |
|---|---|---|---|
| Prove the product works | **Screen capture demo**, real product, no narration polish | 45–90s | Screen recorder. Cheapest, highest trust |
| Explain a concept | Explainer w/ voiceover + simple motion graphics | 60–120s | Code-driven (Remotion) or slides + VO |
| Cold-outreach personalization | Personal talking-head, first frame says their name | **<45s** | Webcam. Effectiveness comes from being clearly unpolished and real |
| Paid social ad | Hook-first vertical clip | 15–30s | Fast cuts, captions burned in |
| Organic social | Vertical short, one idea | 15–60s | Native to platform |
| Onboarding / support | Screen capture, chaptered | 2–5min | Screen recorder + chapters |
| Landing-page hero loop | Silent product loop, no audio | 6–12s | Screen capture, cropped, autoplay-muted |
| Trust / about | Talking head, direct to camera | 60–90s | One take, real person |

**The most effective business video is almost always an unglamorous screen recording of the real
product solving the real problem.** Production value is not the variable that moves conversion;
clarity and proof are.

## Step 2 — script structure

### Short-form (<60s) — the hook dominates everything
```
0:00–0:03  HOOK      state the problem or the outcome. No logo, no intro, no "hey guys"
0:03–0:10  STAKES    why it matters / what it costs them
0:10–0:45  PAYOFF    the thing itself — show, don't tell
0:45–0:60  ACTION    one specific next step
```
**The first 3 seconds decide the video's fate.** Retention graphs are brutally consistent on this.
An intro animation before the hook is the single most common self-inflicted wound — cut every logo
sting, every "welcome back," every slow establishing shot.

### Demo (45–90s)
```
1. "Here's the problem" — show the painful current state (the spreadsheet, the whiteboard)
2. "Here's the fix"     — do the task in the product, in real time, unedited if possible
3. "Here's the result"  — the after-state, concretely
4. One CTA
```
Rules: **real data** (plausible and anonymized, never obviously fake `Test Test / asdf`), real
speed — if it takes 8 seconds to load, either show the 8 seconds or say you cut them. Silently
cutting latency is a claim about performance you can't keep.

### Writing rules
- Write the script as **spoken** language, then read it aloud and cut ~30%. Written-to-be-read prose
  sounds robotic aloud.
- One idea per sentence. Short sentences.
- Second person. "You'll see" not "the user can observe."
- No jargon the customer doesn't already use.
- Storyboard as a two-column table (**what's on screen** | **what's said**) before recording. This
  is where you catch that 20 seconds of the video show nothing.

## Step 3 — production paths

| Path | Tooling | Good for | Constraint |
|---|---|---|---|
| **Screen capture** | OS recorder / OBS | Demos, onboarding. Best trust per minute | Needs the real product to exist |
| **Code-driven** | Remotion (React), ffmpeg | Repeatable, templated, data-driven, bulk variants | Needs node + ffmpeg runtime |
| **Slides + VO** | Deck export + audio | Explainers, cheap and fast | Low engagement; keep short |
| **Talking head** | Phone/webcam + a $30 lav mic | Trust, outreach, about-us | Human required — I can't record |
| **Generative video** | Current text-to-video models | B-roll, abstract, tone pieces | Poor at text, hands, continuity, product accuracy. **Never for product demos** |
| **Stock + edit** | Licensed libraries | Filler b-roll | Generic; check license |

### Quality floor (in priority order — this order is not negotiable)
1. **Audio.** Bad audio kills a video faster than bad video. A cheap lav mic in a quiet room beats
   any camera upgrade. Record in the smallest carpeted room available.
2. **Captions, burned in.** The majority of social video is watched muted. Captions are also
   accessibility. Non-optional.
3. **Legibility.** If it's a screen recording, zoom in — text readable on a phone. Full-desktop
   captures are unreadable on mobile, which is where it will be watched.
4. **Pacing.** Cut every pause, every "um," every dead frame. Aim for no shot longer than 4 seconds
   without a change.
5. Resolution/lighting last. 1080p is plenty. A window is free lighting.

### Technical specs
- **Aspect**: 9:16 vertical for social shorts, 16:9 for YouTube/embeds/demos, 1:1 acceptable for feed.
  **Shoot/compose for the destination** — cropping 16:9 to 9:16 destroys framing.
- H.264 MP4 for compatibility; 1080p; ~8–12 Mbps; AAC audio at −14 LUFS.
- **First frame must work as a thumbnail** (it's the poster by default).
- Hero loops: silent, muted-autoplay, `<video muted loop playsinline>` + `poster`, under ~2MB, or
  the page performance budget in `design/web-page-build` is blown.

## Step 4 — distribution (decide before producing)

A video with no distribution plan is a hobby. Decide up front where it goes, because the format
depends on it:
- **Landing page** → silent loop or 60s demo above the fold
- **Cold outreach** → <45s, personal, hosted with a thumbnail preview; **never an attachment**
- **Paid social** → 3 hook variants of the same body, test the hooks (`business/experiment-engine`)
- **YouTube** → searchable title, real description, chapters; it's a search engine, not a feed
- **Sales follow-up** → short, specific to the objection raised

**Repurpose deliberately**: one 90s demo → 3 shorts (one per feature) + a hero loop + 5 stills.
Plan the repurposing before shooting so you capture the coverage you'll need.

## Measurement

| Metric | Reads as |
|---|---|
| **3-second retention** | Hook quality. Fix this before anything else |
| 50% retention | Whether the body earns attention |
| Completion rate | Length appropriateness — low means it's too long, not that viewers are lazy |
| CTA click rate | Whether the ask is clear and well-placed |
| Qualified outcomes | The only metric that pays. Views are vanity |

Kill criteria up front (`thinking/decision-quality`): if 3-second retention is below ~50% across
two hook variants, the problem is the hook or the audience — **do not re-edit the body.**

## Failure modes

| Symptom | Cause | Fix |
|---|---|---|
| Nobody watches past 3s | Intro/logo before the hook | Cut everything before the hook |
| High views, no action | No clear single CTA | One ask, stated and shown |
| Looks unprofessional | Bad audio (almost always) | Mic + quiet room, not a better camera |
| Unreadable on phone | Full-desktop screen capture | Zoom in; compose for 9:16 if social |
| Took a week, used once | No distribution/repurposing plan | Plan destinations before producing |
| Demo feels dishonest | Cut loading times, fake data | Show real speed and plausible data |
| Page slowed to a crawl | Autoplaying heavy hero video | ≤2MB, muted, `poster`, or use a GIF-like loop |

## Boundaries

- **I cannot record, render, or edit video.** No camera, no microphone, no ffmpeg, no node runtime
  in my toolset — verified: my kit is web access plus repo writes. What I produce is **scripts,
  storyboards, shot lists, specs, captions, and Remotion source code committed to a repo**; a human
  or a station box with node+ffmpeg does the render. Never describe a video as produced when only
  the script exists.
- **No fabricated demos** — no fake UI, no invented metrics on screen, no testimonial performed by
  someone who isn't a customer, no cutting latency while implying speed.
- No generated video of real people, no voice cloning of anyone without their explicit consent, no
  copyrighted music (use licensed or silence — silence with captions is fine and common).
- Check commercial-use terms on any generative model or stock asset at the time of use.
- Disclose AI-generated video where the platform requires it.
