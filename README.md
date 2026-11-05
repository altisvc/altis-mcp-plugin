# Altis plugin for Claude and ChatGPT

Altis research inside Claude and ChatGPT: company reports, market landscapes, scans, pulses, signals
and expert-call transcripts, exactly as published on [altis.vc](https://www.altis.vc). Answers cite the
Altis pieces they draw on, with links.

You sign in with your Altis account the first time you use it; there is no key to copy. Any Altis account
can search what Altis covers and has published. Reading the research itself takes an all-access account:
see [altis.vc/access](https://www.altis.vc/access).

## What you get

- **The Altis connector** (`https://mcp.altis.vc/mcp`): read-only access to Altis research.
- **Skills:**
  - **altis-research**: how to find and read Altis research, and cite it.
  - **altis-meeting-prep**: a meeting brief on a company from Altis research.
  - **altis-follow**: new Altis research delivered on a schedule you choose.
  - **altis-coverage-sweep**: what Altis has on the companies and topics in your email, calendar and meetings.
  - **altis-flag**: a short note when Altis has research on something you are working on.
  - **altis-brief**: a 300-word brief on one company, with sources.
- **/altis:brief &lt;company&gt;** (Claude): the same brief as a command.

## Other services

`altis-follow` can deliver updates through email or messaging apps you've already connected to Claude.
`altis-coverage-sweep` and `altis-flag` read from email, calendar, meeting notes, messages or documents
you've connected, and may search Altis for company and topic names they find there. The plugin doesn't add
those connections.

## Install

Download the newest packages from [Releases](https://github.com/altisvc/altis-mcp-plugin/releases):
`altis-claude-<version>.zip` for Claude, `altis-chatgpt-<version>.zip` for ChatGPT.

### Claude

- **Claude Code:** `/plugin install altis --marketplace altisvc/altis-mcp-plugin`
  (older versions: `/plugin marketplace add altisvc/altis-mcp-plugin`, then `/plugin install altis`).
- **Claude.ai, desktop and Cowork:** Customize › Plugins › Add › **Upload plugin**, with the Claude zip.
  For a whole organization, an Owner uses Organization settings › Plugins & skills › Add › **Upload a plugin**.
- **Connector only:** Settings › Connectors › Add custom connector, name **Altis**, URL `https://mcp.altis.vc/mcp`.

Ask an Altis question. The first call opens altis.vc: sign in with your Altis account and click **Allow**.

### ChatGPT

chatgpt.com/plugins › **Add** › **Upload plugin archive**, with the ChatGPT zip. Connecting opens altis.vc:
sign in and click **Allow**. More in [`chatgpt/`](chatgpt/README.md).

## Example questions

- Brief me on Mercor in 300 words using Altis research.
- What has Altis published on nuclear fission since September?
- Prepare me for a meeting with Aaru: thesis, key debates and five questions to ask.
- Every morning, send me anything new Altis has published on AI infrastructure.

## Support

[support@altis.vc](mailto:support@altis.vc) · [Privacy policy](https://www.altis.vc/privacy)

---

## Maintainers

### Layout

```
.claude-plugin/plugin.json        the Claude plugin
.claude-plugin/marketplace.json   this repo as a Claude plugin marketplace (one plugin, at ./)
.mcp.json                         the connector for Claude (no key: sign-in)
plugin.json, mcp.json, .app.json  the ChatGPT plugin (OpenAI's plugin format) and its registered connector
skills/*/SKILL.md                 the skills, shared by both plugins
commands/*.md                     slash commands (Claude)
scripts/package.sh                builds both packages into dist/ (git-ignored); --release publishes them
scripts/install-chatgpt-local.sh  installs the ChatGPT package for the ChatGPT desktop app on this Mac
chatgpt/                          ChatGPT notes and listing text
```

### Versions and releases

Every version is a [GitHub release](https://github.com/altisvc/altis-mcp-plugin/releases) with both
packages attached. The zips are never committed: a release is built from its tag.

One version for both plugins, in four places that must match: `.claude-plugin/plugin.json`,
`.claude-plugin/marketplace.json`, `plugin.json` and the top entry of `CHANGELOG.md`.

1. Bump the version in the three manifests and add a `CHANGELOG.md` entry, written for users (what they get,
   not how it works); commit.
2. `scripts/package.sh --release`: checks the versions, validates the Claude plugin, builds both zips, tags
   `v<version>`, pushes `main` and the tag, and creates the release with the changelog entry as its notes.
   Plain `scripts/package.sh` only builds.
3. Update the installed plugins with **Upload new version** on the existing plugin, not **Add** (which creates
   a second one): in Claude, Organization settings › Plugins & skills › Inventory › **altis** › ⋯; in ChatGPT,
   chatgpt.com/plugins › Personal › **Altis** › ⋯.
