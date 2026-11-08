# R Tips book

Quarto book of R tips (`tips/`), deployed to GitHub Pages.

## Deploy contract

- CI (`.github/workflows/deploy.yml`) renders with NO R installed: results come
  from the committed `_freeze/` folder (`freeze: auto` in `_quarto.yml`).
- Before pushing: run `quarto render` locally, then commit the updated `_freeze/`.
  Without it, pages render without computed results — CI cannot rebuild them.
- `_freeze/` is tracked; knitr `*_cache/` directories are ignored.

## Conventions

- Section numbering lives in `_quarto.yml` only — `number-sections: true` with
  `number-depth: 1` (top-level headings numbered, subsections unnumbered).
  Do not set numbering options in tip files.
- Figure captions on `.columns` blocks: wrap the columns div in an outer fenced
  div with one more colon (`:::::`) carrying the `#fig-` id and the caption text.
- Nesting fenced divs: the outer div needs more colons than the inner one.
- Centering text in PDFs: `:::{.center data-latex=""}` — `data-latex=""` is
  required or centering silently fails. KOMA `\usekomafont{...}` commands match
  the header font style (default PDF class is `scrartcl`).
- Column vertical centering is handled by `assets/style.css`.

## Videos

- No player page. Upload the edited render to
  `videos-r2:videos/r-tips/<r-tips-XX-YY-slug>.mp4` with rclone and embed a raw
  `<video controls src="https://videos.tmas.app/r-tips/<name>.mp4">` in the tip.
  Working example: tips/07-quarto/03-text-centering.qmd
- Scratch renders, transcripts and raw recordings live in `dev/` (untracked).

## To do

- Custom domain rtips.tmas.app: discussed but not configured (no CNAME file or
  GitHub Pages domain setting yet).
