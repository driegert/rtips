# R Tips

Short R Tips videos (each under 5 min), each with a companion page running the
same code. One Quarto **book** project: the 7 checklist sections are parts,
each tip is a chapter, and every chapter renders to its own HTML page.

- **Site**: hosted on GitHub Pages (built on push by GitHub Actions from
  frozen results — R never runs in CI)
- **Videos**: hosted on Cloudflare R2 at `https://videos.tmas.app/r-tips/` —
  they never live in this repo
- **Data**: the MATH 1051 lab datasets live in `data/` so the site is
  self-contained; `diamonds`/`mtcars` are built in, `us_temperature` comes
  from `openintro`

## Layout

```
_quarto.yml        book config: 7 parts, one .qmd per tip
index.qmd          landing page with the full tip map
tips/<part>/<nn-slug>.qmd   one page per tip
data/              lab datasets (af_grades, sleep, potato_chips, owid-co2-data.xlsx, production.csv)
assets/            css / logo for the site
_freeze/           saved code results (committed; CI renders from these)
renv.lock          exact R package versions (renv/ itself is ignored)
.github/workflows/deploy.yml   renders _site/ from _freeze/ and deploys to GitHub Pages on push
```

Tip files are zero-padded `nn-slug.qmd` inside their part folder
(`01-getting-started`, …, `07-quarto`).

## Authoring a new tip

1. Film the video; name it `r-tips-<part>-<tip>-<slug>.mp4`
   (e.g. `r-tips-01-01-install-load.mp4`).
2. Upload to R2:
   `rclone copyto r-tips-01-01-install-load.mp4 videos-r2:videos/r-tips/r-tips-01-01-install-load.mp4`
3. Replace the *coming soon* callout in the tip's `.qmd` with:
   ````
   <video controls src="https://videos.tmas.app/r-tips/r-tips-01-01-install-load.mp4" style="width:100%"></video>
   ````
   followed by a couple of sentences, the same code as runnable chunks, and a
   link to the related MATH 1051 lab where one exists.

## Building locally

```sh
Rscript -e "renv::restore()"   # once, or after renv.lock changes
quarto render                   # output in _site/ (gitignored)
```

`execute: freeze: auto` means a tip's R code only re-runs when its `.qmd`
changes; results are saved in `_freeze/`. **Commit `_freeze/` along with the
`.qmd`** — the GitHub build has no R and uses those saved results. To force a
re-run of one tip: `quarto render tips/<part>/<nn-slug>.qmd`.

## Deploying

Render locally, commit (including `_freeze/`), push to `main` — GitHub Actions
runs Quarto on the frozen results and publishes to GitHub Pages. One-time setup after the first push: in the repo
settings → Pages, set the source to **GitHub Actions** (not a branch).

## Data files

| File | Source |
|---|---|
| `af_grades.csv` | MATH 1051 labs |
| `sleep.csv` | MATH 1051 labs |
| `potato_chips.csv` | MATH 1051 labs |
| `owid-co2-data.xlsx` | MATH 1051 labs (kept as xlsx, ~9 MB, loaded with `readxl`) |
| `production.csv` | factory production data (MATH 1051/1052 workshops) |
