#!/usr/bin/env bash
# One-shot GitHub Pages deploy for the Cropperty proposal site.
# Prereqs:  brew install gh   (or: https://cli.github.com)
#           gh auth login
# Run from inside the cropperty-proposal-site folder.

set -e

REPO_NAME="${1:-cropperty-proposal}"
VISIBILITY="${2:-public}"  # public or private (Pages requires public on free plans)

echo "→ initialising git (if needed)"
git init -q 2>/dev/null || true
git checkout -B main 2>/dev/null || true
git add -A
git commit -q -m "Cropperty proposal site" 2>/dev/null || git commit -q --allow-empty -m "Cropperty proposal site"

echo "→ creating GitHub repo: $REPO_NAME ($VISIBILITY)"
gh repo create "$REPO_NAME" "--$VISIBILITY" --source=. --remote=origin --push

echo "→ enabling GitHub Pages on main / root"
USER=$(gh api user -q .login)
gh api -X POST "repos/$USER/$REPO_NAME/pages" -f source.branch=main -f source.path=/ \
  || echo "  (Pages may already be enabled — continuing.)"

PAGES_URL="https://${USER}.github.io/${REPO_NAME}/"
echo ""
echo "✓ Done. Your site will be live at:"
echo "  $PAGES_URL"
echo ""
echo "(GitHub Pages takes 30–60 seconds to build the first time.)"
