#!/usr/bin/env bash
# Claude Rail — install the latest release (no source, no GitHub account needed).
#   curl -fsSL https://raw.githubusercontent.com/dhamija/claude-rail-releases/main/install.sh | bash
# Downloads the newest release tarball, unpacks it, and runs its installer: it puts the build in
# ~/.claude-rail (CLAUDE_RAIL_HOME to change), installs the app's dependencies, links the skills and
# commands into ~/.claude, enables the hooks and creates the Dock launcher. Later: `claude-rail update`.
set -euo pipefail
REPO="dhamija/claude-rail-releases"
[ "$(uname)" = "Darwin" ] || { echo "Claude Rail is a macOS app."; exit 1; }
for t in curl tar python3 node; do command -v "$t" >/dev/null || { echo "$t is required (node 18+: https://nodejs.org)"; exit 1; }; done
echo "==> Finding the latest Claude Rail release"
URL="$(curl -fsSL -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$REPO/releases/latest" \
  | python3 -c 'import json,sys; r=json.load(sys.stdin); print(next(a["browser_download_url"] for a in r.get("assets",[]) if a["name"].endswith(".tar.gz")))')"
[ -n "$URL" ] || { echo "no release found"; exit 1; }
TMP="$(mktemp -d)"
echo "==> Downloading ${URL##*/}"
curl -fsSL -o "$TMP/rail.tar.gz" "$URL"
mkdir -p "$TMP/rail" && tar xzf "$TMP/rail.tar.gz" -C "$TMP/rail"
bash "$TMP/rail/install.sh" "$@"
rm -rf "$TMP"
