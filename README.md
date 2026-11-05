# Altis plugin for Claude and ChatGPT

Altis research inside Claude and ChatGPT: company reports, market landscapes, scans, pulses, signals
and expert-call transcripts, exactly as published on [altis.vc](https://www.altis.vc). Answers cite the
Altis pieces they draw on, with links.

You sign in with your Altis account the first time you use it; there is no key to copy. Any Altis account
can search what Altis covers and has published. Reading the research itself takes an all-access account:
see [altis.vc/access](https://www.altis.vc/access).

## Install

- **Claude:** see [`claude/`](claude/README.md).
- **ChatGPT:** see [`chatgpt/`](chatgpt/README.md).

## Support

[support@altis.vc](mailto:support@altis.vc) · [Privacy policy](https://www.altis.vc/privacy)

---

## Maintainers

### Layout

```
.claude-plugin/marketplace.json   this repo as a Claude plugin marketplace (one plugin, at ./claude)
claude/                           the Claude plugin, and the only folder the plugin directory reads
  .claude-plugin/                 its manifest and listing icon
  .mcp.json                       the connector (no key: sign-in)
  skills/*/SKILL.md               the skills, shared by both plugins
  commands/*.md                   slash commands
chatgpt/                          the ChatGPT plugin (OpenAI's plugin format)
  plugin.json, .app.json          its manifest and registered connector
  mcp.json                        the connector for the desktop install
  skills                          a symlink to claude/skills, so there is one copy to edit
  listing.md                      the directory listing text
scripts/package.sh                builds both packages into dist/ (git-ignored); --release publishes them
scripts/install-chatgpt-local.sh  installs the ChatGPT package for the ChatGPT desktop app on this Mac
```

### Versions and releases

Every version is a [GitHub release](https://github.com/altisvc/altis-mcp-plugin/releases) with both
packages attached. The zips are never committed: a release is built from its tag.

One version for both plugins, in four places that must match: `claude/.claude-plugin/plugin.json`,
`.claude-plugin/marketplace.json`, `chatgpt/plugin.json` and the top entry of `CHANGELOG.md`.

1. Bump the version in the three manifests and add a `CHANGELOG.md` entry, written for users (what they get,
   not how it works); commit.
2. `scripts/package.sh --release`: checks the versions, validates the Claude plugin, builds both zips, tags
   `v<version>`, pushes `main` and the tag, and creates the release with the changelog entry as its notes.
   Plain `scripts/package.sh` only builds.
3. Update the installed plugins with **Upload new version** on the existing plugin, not **Add** (which creates
   a second one): in Claude, Organization settings › Plugins & skills › Inventory › **altis** › ⋯; in ChatGPT,
   chatgpt.com/plugins › Personal › **Altis** › ⋯.
