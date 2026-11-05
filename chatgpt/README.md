# Altis plugin for ChatGPT

Altis research inside ChatGPT, with the same skills as the Claude plugin. You sign in with your Altis account when
you connect: any account can search what Altis covers and has published, and an all-access account reads the research
itself. Support: [support@altis.vc](mailto:support@altis.vc).

## How it is put together

- The package (`altis-chatgpt-<version>.zip`) carries `plugin.json`, the skills (`skills` here is a symlink to `claude/skills`), and `.app.json`.
- The connector is the Altis MCP server (`https://mcp.altis.vc/mcp`) registered in ChatGPT
  (chatgpt.com/plugins › Add › **Add custom MCP server** › Create as a plugin). `.app.json` links the package to it,
  and `plugin.json` points at `.app.json` (`extensions.com.openai.apps`).
- The package leaves out `mcp.json`: a plugin that bundles its own MCP server is desktop-only. `mcp.json` stays in
  the repo for the desktop install (`scripts/install-chatgpt-local.sh`).

## Install or update

Download the newest package, `altis-chatgpt-<version>.zip`, from
[Releases](https://github.com/altisvc/altis-mcp-plugin/releases).

- **First time:** chatgpt.com/plugins › **Add** › **Upload plugin archive**.
- **Update:** open the existing plugin › ⋯ › **Upload new version**.
- **Share with a workspace:** Personal › ⋯ on Altis › **Publish** (workspace admin).

## Public directory

Upload `altis-chatgpt-public-<version>.zip` at platform.openai.com/plugins. It carries `mcp.json` and leaves out
`.app.json` and `apps`, which public submission refuses. The connector is then connected in the portal.

## Connector only, without the plugin

Settings › Apps & Connectors › Advanced › **Developer mode** on, then Create:

| Field | Value |
|---|---|
| Name | Altis |
| Description | Search and read Altis research: covered companies, sectors, reports, scans and expert calls. Sign in with your Altis account. |
| MCP server URL | `https://mcp.altis.vc/mcp` |
| Authentication | OAuth (ChatGPT finds the Altis sign-in on its own) |

Menu names change; check OpenAI's current docs.

## Directory listing

The listing text is in [`listing.md`](listing.md).
