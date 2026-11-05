# Altis plugin for Claude

Altis research inside Claude: company reports, market landscapes, scans, pulses, signals
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
- **/altis:brief &lt;company&gt;**: the same brief as a command.

## Other services

`altis-follow` can deliver updates through email or messaging apps you've already connected to Claude.
`altis-coverage-sweep` and `altis-flag` read from email, calendar, meeting notes, messages or documents
you've connected, and may search Altis for company and topic names they find there. The plugin doesn't add
those connections.

## Install

Download the newest package, `altis-claude-<version>.zip`, from
[Releases](https://github.com/altisvc/altis-mcp-plugin/releases).

- **Claude Code:** `/plugin install altis --marketplace altisvc/altis-mcp-plugin`
  (older versions: `/plugin marketplace add altisvc/altis-mcp-plugin`, then `/plugin install altis`).
- **Claude.ai, desktop and Cowork:** Customize › Plugins › Add › **Upload plugin**, with the Claude zip.
  For a whole organization, an Owner uses Organization settings › Plugins & skills › Add › **Upload a plugin**.
- **Connector only:** Settings › Connectors › Add custom connector, name **Altis**, URL `https://mcp.altis.vc/mcp`.

Ask an Altis question. The first call opens altis.vc: sign in with your Altis account and click **Allow**.

## Example questions

- Brief me on Mercor in 300 words using Altis research.
- What has Altis published on nuclear fission since September?
- Prepare me for a meeting with Aaru: thesis, key debates and five questions to ask.
- Every morning, send me anything new Altis has published on AI infrastructure.

## Support

[support@altis.vc](mailto:support@altis.vc) · [Privacy policy](https://www.altis.vc/privacy)
