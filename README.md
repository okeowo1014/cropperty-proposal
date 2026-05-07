# Cropperty — Website & Mobile App Proposal

Interactive pitch deck for the Cropperty website and mobile app build, prepared by **Semester Integrated Limited**.

Live site: <!-- replace after Pages is enabled -->
https://YOUR-GITHUB-USERNAME.github.io/cropperty-proposal/

## Contents

- `index.html` — the interactive pitch deck (single-file, no build step required)
- `Cropperty_Web_and_Mobile_App_Proposal.docx` — full written proposal (linked from the deck's Download CTA)
- `mockups/` — brand mark + concept screens (SVG and PNG)

## Run locally

Just open `index.html` in any modern browser, or serve the folder:

```bash
python3 -m http.server 8000
# then open http://localhost:8000
```

## Responsive

The deck is responsive across mobile (≥320px), tablet (≥768px) and desktop (≥1280px). Breakpoints:

- Hero collapses to single column at <980px
- Feature grids: 3 → 2 → 1 columns at 980px / 560px
- Phone stack scales proportionally on small screens
- Competitor comparison table is horizontally scrollable on <720px viewports
- Nav menu collapses; brand and CTA stay visible

## Deploy to GitHub Pages — one-shot

From inside this folder, after `git init`:

```bash
gh repo create cropperty-proposal --public --source=. --remote=origin --push
gh api -X POST repos/:owner/cropperty-proposal/pages -f source.branch=main -f source.path=/
```

Site goes live at `https://<your-username>.github.io/cropperty-proposal/` within a minute.

(If you don't have the GitHub CLI: create the repo on github.com, then push with the standard `git remote add` + `git push`, and enable Pages from Settings → Pages → Branch: `main` / `/(root)` → Save.)

## License

Confidential. Prepared for Cropperty founders. Validity: 30 days from 7 May 2026.
