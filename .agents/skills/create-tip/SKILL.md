---
name: create-tip
description: Scaffold and register a new R Tips page in the Quarto book at the repo root. Use when asked to add, write, scaffold, or register a new tip, or to attach a video or figures to an existing one.
---

# Create a new R Tips tip

Read the repo `AGENTS.md` first — it holds the deploy contract, the fenced-div
and figure-caption conventions, and the agent coordination board rules.

## Where things go

- Tip file: `tips/<part>/<nn>-<slug>.qmd`, zero-padded `nn` matching the part
  (example: `tips/07-quarto/03-text-centering.qmd`).
- Figures for a tip: `tips/<part>/<nn>-<slug>-figures/`, referenced with
  relative paths.
- Register every tip in TWO places: the `book: chapters:` list in `_quarto.yml`
  and the listing in `index.qmd`.
- Scratch and test renders go in `dev/` (untracked).

## Placeholder vs finished tip

Unfinished tips are placeholders: a `::: {.callout-note}` block saying
*Coming soon*, what the tip will cover, and the pending video filename. The
title carries a `[soon]{.soon}` badge. When a tip is finished, remove the
badge and the placeholder block.

## Tip structure

1. Front matter: `title` only. Never set numbering options in a tip file —
   they live in `_quarto.yml` (`number-sections: true`, `number-depth: 1`).
   Escape `&` and `>` in titles as `&amp;` / `&gt;` so the sidebar badge
   renders.
2. A `**Format Supported**: ...` line (e.g. `PDF (LaTeX)`).
3. `## Solution` — a `:::{.callout-tip}` with a `###` heading and the minimal
   code block that solves the tip.
4. `## Video` — the embed or its placeholder.
5. `## Discussion` — the how and why, with worked examples and figures.

## Video embed

While the video is not on R2 yet, keep the placeholder callout-note naming the
future file (`r-tips-<nn>-<slug>.mp4`). Once it is uploaded, embed:

```html
<video controls style="width: 100%; max-width: 720px; height: auto;" src="https://videos.tmas.app/r-tips/r-tips-<nn>-<slug>.mp4">

</video>
```

Upload with rclone: `rclone copyto <edited.mp4>
videos-r2:videos/r-tips/r-tips-<nn>-<slug>.mp4`, then verify a range request
returns HTTP 206. Videos go straight to R2; this book has no player pages.

## Before you commit or push

Run `quarto render` from the repo root and commit the updated `_freeze/`
alongside the tip — CI has no R and cannot build results. Follow the
`.agent-board/` coordination protocol in `AGENTS.md`.
