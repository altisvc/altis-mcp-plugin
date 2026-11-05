#!/usr/bin/env bash
# Install the ChatGPT plugin on this Mac, for the ChatGPT desktop app (OpenAI's local-plugin route:
# developers.openai.com/plugins/build/plugins). Builds the package, copies it to
# ~/.codex/plugins/altis, and adds an "altis" entry to the personal marketplace
# ~/.agents/plugins/marketplace.json (other entries are kept; the file is backed up first).
# Then: restart the ChatGPT desktop app › Plugins Directory › the "Altis" marketplace › Install.
# Re-run after a change to update the installed copy (and restart the app again).
set -euo pipefail
cd "$(dirname "$0")/.."
scripts/package.sh >/dev/null
version=$(python3 -c 'import json; print(json.load(open("chatgpt/plugin.json"))["version"])')

dest="$HOME/.codex/plugins/altis"
rm -rf "$dest"
mkdir -p "$dest"
cp -R "dist/altis-chatgpt-$version/." "$dest/"

market="$HOME/.agents/plugins/marketplace.json"
mkdir -p "$(dirname "$market")"
[[ -f "$market" ]] && cp "$market" "$market.bak.$(date +%Y%m%d%H%M%S)"
python3 - "$market" <<'PY'
import json, os, sys
p = sys.argv[1]
d = json.load(open(p)) if os.path.exists(p) else {}
d.setdefault("name", "personal")
d.setdefault("interface", {"displayName": "Personal"})
plugins = [x for x in d.get("plugins", []) if x.get("name") != "altis"]
plugins.append({
    "name": "altis",
    "source": {"source": "local", "path": "./.codex/plugins/altis"},
    "policy": {"installation": "AVAILABLE", "authentication": "ON_INSTALL"},
    "category": "Research",
})
d["plugins"] = plugins
json.dump(d, open(p, "w"), indent=2)
open(p, "a").write("\n")
PY
echo "installed altis $version to $dest"
echo "marketplace: $market"
echo "now: restart the ChatGPT desktop app › Plugins Directory › install Altis"
