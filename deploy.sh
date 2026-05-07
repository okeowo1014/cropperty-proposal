#!/usr/bin/env bash
# Idempotent GitHub Pages deploy for the Cropperty proposal site.
#
# • First run  → initialises git, creates the repo on GitHub, enables Pages, pushes.
# • Every run after → stages changes, commits, pushes. Site updates in ~30s.
#
# Prereqs:  brew install gh   (or: https://cli.github.com)
#           gh auth login
# Run from inside the cropperty-proposal-site folder.

set -e

REPO_NAME="${1:-cropperty-proposal}"
VISIBILITY="${2:-public}"   # public or private (Pages requires public on free plans)
COMMIT_MSG="${COMMIT_MSG:-Update cropperty proposal site ($(date +%Y-%m-%d))}"

# ── 1. ensure git is initialised ─────────────────────────────────────────────
if [ ! -d .git ]; then
  echo "→ initialising git"
  git init -q
  git checkout -B main
fi

# ── 2. stage + commit any changes (only if there are any) ────────────────────
git add -A
if git diff --cached --quiet; then
  echo "→ no changes to commit"
else
  echo "→ committing: $COMMIT_MSG"
  git commit -q -m "$COMMIT_MSG"
fi

# ── 3. ensure remote exists (create the GitHub repo on first run) ────────────
if ! git remote get-url origin >/dev/null 2>&1; then
  echo "→ creating GitHub repo: $REPO_NAME ($VISIBILITY)"
  gh repo create "$REPO_NAME" "--$VISIBILITY" --source=. --remote=origin --push

  echo "→ enabling GitHub Pages on main / root"
  USER=$(gh api user -q .login)
  gh api -X POST "repos/$USER/$REPO_NAME/pages" \
    -f source.branch=main -f source.path=/ \
    || echo "  (Pages may already be enabled — continuing.)"
else
  # ── 4. push to existing remote ─────────────────────────────────────────────
  BRANCH=$(git branch --show-current)
  echo "→ pushing $BRANCH to origin"
  if ! git push -u origin "$BRANCH" 2>/dev/null; then
    git push origin "$BRANCH"
  fi
fi

# ── 5. report URL ────────────────────────────────────────────────────────────
USER=$(gh api user -q .login 2>/dev/null || echo "<your-username>")
PAGES_URL="https://${USER}.github.io/${REPO_NAME}/"
echo ""
echo "✓ Done. Live at:"
echo "  $PAGES_URL"
echo ""
echo "(GitHub Pages typically rebuilds in 30–60 seconds.)"
