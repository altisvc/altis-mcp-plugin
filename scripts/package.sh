#!/usr/bin/env bash
# Build both plugin packages from this repo, at the one version they share:
#   dist/altis-claude-<version>.zip    Claude  (the claude/ folder)
#   dist/altis-chatgpt-<version>/      ChatGPT (chatgpt/plugin.json, .app.json, and the skills from
#   dist/altis-chatgpt-<version>.zip   claude/skills) — the folder the desktop app installs, and a zip of it
#   dist/altis-chatgpt-public-<version>.zip  ChatGPT, for OpenAI's public directory (mcp.json, no .app.json)
#
# The version lives in four places and must match: claude/.claude-plugin/plugin.json,
# .claude-plugin/marketplace.json, chatgpt/plugin.json and the top heading of CHANGELOG.md.
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
version=$(ver claude/.claude-plugin/plugin.json)
chatgpt=$(ver chatgpt/plugin.json)
market=$(python3 -c 'import json; d=json.load(open(".claude-plugin/marketplace.json")); print(" ".join(sorted({d["metadata"]["version"], *[p["version"] for p in d["plugins"]]})))')
changelog=$(sed -n 's/^## \([0-9][0-9.]*\) .*/\1/p' CHANGELOG.md | head -1)

if [[ "$market" != "$version" || "$chatgpt" != "$version" || "$changelog" != "$version" ]]; then
  echo "version mismatch: claude/.claude-plugin/plugin.json=$version marketplace.json=$market chatgpt/plugin.json=$chatgpt CHANGELOG.md=$changelog" >&2
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
mkdir -p "$stage/claude"
cp -R claude/. "$stage/claude/"
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
# .app.json maps by its plugin_asdk_app_… id; plugin.json carries "apps": "./.app.json" under
# extensions.com.openai. mcp.json stays in the repo for the desktop app. The skills live in
# claude/skills, because the Claude directory reads only that folder, and are copied in here.
dir="dist/altis-chatgpt-$version"
rm -rf "$dir" "$dir.zip"
mkdir -p "$dir"
cp chatgpt/plugin.json chatgpt/README.md chatgpt/.app.json LICENSE "$dir/"
cp -R claude/skills "$dir/"
mkdir -p "$dir/assets"
cp claude/.claude-plugin/icon.png "$dir/assets/icon.png"
(cd "$dir" && zip -qr -X "../altis-chatgpt-$version.zip" . -x '*.DS_Store')
echo "$dir/ and $dir.zip"

# ChatGPT, for OpenAI's public directory. Public submission refuses `apps` and .app.json, so this
# package drops them and carries mcp.json instead; the connector is then connected in OpenAI's portal.
public="dist/altis-chatgpt-public-$version"
rm -rf "$public" "$public.zip"
cp -R "$dir" "$public"
rm "$public/.app.json"
cp chatgpt/mcp.json "$public/"
python3 - "$public/plugin.json" <<'PY_INNER'
import json, sys
path = sys.argv[1]
manifest = json.load(open(path))
del manifest["extensions"]["com.openai"]["apps"]
json.dump(manifest, open(path, "w"), indent=2, ensure_ascii=False)
open(path, "a").write("\n")
PY_INNER
(cd "$public" && zip -qr -X "../altis-chatgpt-public-$version.zip" . -x '*.DS_Store')
echo "$public/ and $public.zip"
echo "from $(git rev-parse --short HEAD)"

if $release; then
  notes=$(awk -v v="$version" '$0 ~ "^## "v" " {on=1; next} on && /^## / {exit} on' CHANGELOG.md)
  git rev-parse -q --verify "refs/tags/v$version" >/dev/null || git tag "v$version"
  git push origin HEAD:main "v$version"
  gh release create "v$version" "dist/altis-claude-$version.zip" "dist/altis-chatgpt-$version.zip" \
    --title "$version" --notes "$notes" --verify-tag
fi
