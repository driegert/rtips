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

## Working alongside other agents

Up to three agents (Claude, Codex, pi, …) may share this working tree at once.
They coordinate through `.agent-board/` (gitignored, local only): one file per
agent, so nobody edits anyone else's file.

- **On start, and before any commit, push, `quarto render` or broad edit:**
  read every file in `.agent-board/`.
- **Post your own card** as `.agent-board/<your-name>.md` (pick a short name,
  e.g. `claude-hosting`, `codex-1`). Keep it current; delete it when you finish.
  ```
  task:    one line on what you're doing
  paths:   files/dirs you are editing (globs fine)
  status:  editing | committed, not pushed | waiting on user
  notes:   anything another agent should know (e.g. "commit 73f153b is mine")
  updated: 2026-11-08 15:40
  ```
- **Don't touch paths on another live card.** If you need one, ask the user.
- **An unexpected diff is someone else's work.** Don't revert, reformat, stage
  or "clean up" changes you didn't make, even in a file you're also editing.
- **Commit only your own changes, by explicit path:** `git commit -- <paths>`.
  Never `git add -A`, `git add .`, `git commit -a`, `git stash`,
  `git reset --hard`, `git checkout -- .`/`git restore .`, or `git clean`.
  If one file mixes your hunks with someone else's, stage only yours
  (`git apply --cached` of a patch) or ask the user.
- **Push only when the user asks.** A push sends every agent's local commits
  and redeploys the site. Say which commits are going out.
- **`quarto render` rewrites shared outputs** (`_site/`, `_freeze/`). Note on
  your card when you render, and don't commit `_freeze/` entries for tips
  another agent is editing.
- A card older than a day may be stale. Ask the user before deleting it.

## Videos

- No player page. Upload the edited render to
  `videos-r2:videos/r-tips/<r-tips-XX-YY-slug>.mp4` with rclone and embed a raw
  `<video controls src="https://videos.tmas.app/r-tips/<name>.mp4">` in the tip.
  Working example: tips/07-quarto/03-text-centering.qmd
- Scratch renders, transcripts and raw recordings live in `dev/` (untracked).

## To do

- Custom domain rtips.tmas.app: DNS (Cloudflare CNAME -> driegert.github.io,
  DNS only) and the GitHub Pages domain setting are done; site is live over
  HTTP. Waiting on GitHub's HTTPS certificate, then tick "Enforce HTTPS".
