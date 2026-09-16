#!/usr/bin/env bash
# install.sh — load the agent-skills library into a Claude-Code-compatible skills dir.
#
# Usage:
#   ./install.sh                  # original skills + vetted upstream set
#   ./install.sh --original-only  # only the skills written in this repo
#   ./install.sh --dry-run        # print, do not install
#
# Upstream skills are installed with `npx skills add <owner>/<repo> --copy` so the
# installed file is a real copy (reviewable, hashable) rather than a symlink to a cache.
# After install, verify a skill's SKILL.md hash against registry.json before trusting it.

set -euo pipefail

MODE="full"
DRY=""
for arg in "$@"; do
  case "$arg" in
    --original-only) MODE="original" ;;
    --dry-run)       DRY="1" ;;
    -h|--help)       sed -n '2,12p' "$0"; exit 0 ;;
    *) echo "unknown arg: $arg" >&2; exit 2 ;;
  esac
done

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${SKILLS_DIR:-$HOME/.claude/skills}"
AGENT="${SKILLS_AGENT:-claude-code}"

run() {
  if [[ -n "$DRY" ]]; then echo "  DRY: $*"; else echo "  RUN: $*"; eval "$@"; fi
}

echo "== agent-skills install =="
echo "   source: $HERE"
echo "   dest:   $DEST"
echo "   mode:   $MODE"
echo

# ---------------------------------------------------------------- original skills
echo "-- original skills (this repo)"
mkdir -p "$DEST"
for skill_dir in "$HERE"/skills/*/*/; do
  name="$(basename "$skill_dir")"
  [[ -f "$skill_dir/SKILL.md" ]] || continue
  echo "  + $name"
  run "rm -rf '$DEST/$name' && cp -r '$skill_dir' '$DEST/$name'"
done
echo

if [[ "$MODE" == "original" ]]; then
  echo "done (original only)."
  exit 0
fi

# ---------------------------------------------------------------- upstream skills
echo "-- upstream skills (vetted set)"
if ! command -v npx >/dev/null 2>&1; then
  echo "  !! npx not found — skipping upstream install."
  echo "     Either install Node, or vendor the repos manually and copy the skill dirs."
  echo "     Full list to install is in registry.json (field: repos[].install)."
  exit 0
fi

# Each line: <owner>/<repo>   (the whole repo's installable skill set)
REPOS=(
  "coreyhaines31/marketingskills"          # MIT, 50 marketing/sales skills — the big one
  "anthropics/skills"                      # official: brand-guidelines, frontend-design, canvas-design, ...
  "ComposioHQ/awesome-claude-skills"       # lead-research-assistant, competitive-ads-extractor, video-downloader, ...
  "alirezarezvani/claude-skills"           # 772-skill community collection (business, c-level, ops)
  "bergside/awesome-design-skills"         # 67 DESIGN.md / SKILL.md design styles
  "trailofbits/skills"                     # security review for anything I ship
)

for repo in "${REPOS[@]}"; do
  echo "  + $repo"
  run "npx -y skills add '$repo' -g -a '$AGENT' --copy -y"
done

# Individual skills worth pulling by name (see registry.json for why).
SINGLES=()
while IFS=$'\t' read -r repo skill; do
  [[ -z "${repo:-}" ]] && continue
  SINGLES+=("$repo|$skill")
done < <(jq -r '.singles[]? | [.source, .skill] | @tsv' "$HERE/registry.json" 2>/dev/null || true)

if (( ${#SINGLES[@]} > 0 )); then
  echo "-- single skills"
  for entry in "${SINGLES[@]}"; do
    repo="${entry%%|*}"; skill="${entry##*|}"
    echo "  + $repo :: $skill"
    run "npx -y skills add '$repo' -g -s '$skill' -a '$AGENT' --copy -y"
  done
fi

echo
echo "done."
echo "Verify against registry.json before trusting a freshly installed upstream skill:"
echo "  find $DEST -name SKILL.md -exec shasum -a 256 {} + | head"