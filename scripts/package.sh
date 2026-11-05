#!/usr/bin/env bash
# Build both plugin packages from this repo, at the one version they share:
#   dist/altis-claude-<version>.zip    Claude  (.claude-plugin/plugin.json, .mcp.json, skills, commands)
#   dist/altis-chatgpt-<version>/      ChatGPT (plugin.json, mcp.json, skills) — the folder the desktop
#   dist/altis-chatgpt-<version>.zip   app installs, and a zip of it for submission
#
# The version lives in four places and must match: .claude-plugin/plugin.json,
# .claude-plugin/marketplace.json, plugin.json (ChatGPT) and the top heading of CHANGELOG.md.
# This refuses to build if they disagree, or if the Claude plugin does not validate.
#
# Release: bump the version in the three manifests, add a CHANGELOG entry, commit, then
# `scripts/package.sh --release`: after building, it tags v<version>, pushes main and the tag, and creates
# the GitHub release with both zips and the CHANGELOG entry as notes (needs a clean tree and `gh`).
# Then upload each zip as a new version of the existing plugin (README "Versions and releases").
set -euo pipefail
cd "$(dirname "$0")/.."

release=false
[[ "${1:-}" == "--release" ]] && release=true

ver() { python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["version"])' "$1"; }
version=$(ver .claude-plugin/plugin.json)
chatgpt=$(ver plugin.json)
market=$(python3 -c 'import json; d=json.load(open(".claude-plugin/marketplace.json")); print(" ".join(sorted({d["metadata"]["version"], *[p["version"] for p in d["plugins"]]})))')
changelog=$(sed -n 's/^## \([0-9][0-9.]*\) .*/\1/p' CHANGELOG.md | head -1)

if [[ "$market" != "$version" || "$chatgpt" != "$version" || "$changelog" != "$version" ]]; then
  echo "version mismatch: .claude-plugin/plugin.json=$version marketplace.json=$market plugin.json=$chatgpt CHANGELOG.md=$changelog" >&2
  exit 1
fi
if $release && [[ -n "$(git status --porcelain)" ]]; then
  echo "refusing to release: uncommitted changes" >&2
  exit 1
fi
if $release && git rev-parse -q --verify "refs/tags/v$version" >/dev/null && [[ "$(git rev-list -n1 "v$version")" != "$(git rev-parse HEAD)" ]]; then
  echo "refusing to release: tag v$version exists on another commit; bump the version" >&2
  exit 1
fi
if [[ -n "$(git status --porcelain)" ]]; then
  echo "warning: uncommitted changes; the packages will not match a commit" >&2
fi

stage=$(mktemp -d)
trap 'rm -rf "$stage"' EXIT
mkdir -p dist

# Claude
mkdir -p "$stage/claude/.claude-plugin"
cp .claude-plugin/plugin.json .claude-plugin/icon.png "$stage/claude/.claude-plugin/"
cp -R .mcp.json skills commands README.md LICENSE "$stage/claude/"
if command -v claude >/dev/null 2>&1; then
  claude plugin validate "$stage/claude" | tail -1
fi
out="dist/altis-claude-$version.zip"
rm -f "$out"
(cd "$stage/claude" && zip -qr -X "$OLDPWD/$out" . -x '*.DS_Store')
echo "$out ($(wc -c < "$out" | tr -d ' ') bytes)"

# ChatGPT. The upload at chatgpt.com/plugins marks a plugin that bundles its own MCP server
# (mcp.json) as desktop-only (2026-10-28), so the web package leaves mcp.json out. The MCP comes
# from the server registered in ChatGPT ("Add custom MCP server" › "Create as a plugin"), which
# .app.json maps by its plugin_asdk_app_… id once that file exists; plugin.json must then carry
# "apps": "./.app.json" under extensions.com.openai. mcp.json stays in the repo for the desktop app.
dir="dist/altis-chatgpt-$version"
rm -rf "$dir" "$dir.zip"
mkdir -p "$dir"
cp -R plugin.json skills README.md LICENSE "$dir/"
if [[ -f .app.json ]]; then cp .app.json "$dir/"; fi
(cd "$dir" && zip -qr -X "../altis-chatgpt-$version.zip" . -x '*.DS_Store')
echo "$dir/ and $dir.zip"
echo "from $(git rev-parse --short HEAD)"

if $release; then
  notes=$(awk -v v="$version" '$0 ~ "^## "v" " {on=1; next} on && /^## / {exit} on' CHANGELOG.md)
  git rev-parse -q --verify "refs/tags/v$version" >/dev/null || git tag "v$version"
  git push origin HEAD:main "v$version"
  gh release create "v$version" "dist/altis-claude-$version.zip" "dist/altis-chatgpt-$version.zip" \
    --title "$version" --notes "$notes" --verify-tag
fi
