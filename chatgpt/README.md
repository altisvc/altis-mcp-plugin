# ChatGPT

The ChatGPT plugin is built from the same repo and skills as the Claude plugin, in OpenAI's plugin format.

## How it is put together

- The package (`altis-chatgpt-<version>.zip`) carries `plugin.json`, the skills, and `.app.json`.
- The connector is the Altis MCP server (`https://mcp.altis.vc/mcp`) registered in ChatGPT
  (chatgpt.com/plugins › Add › **Add custom MCP server** › Create as a plugin). `.app.json` links the package to it,
  and `plugin.json` points at `.app.json` (`extensions.com.openai.apps`).
- The package leaves out `mcp.json`: a plugin that bundles its own MCP server is desktop-only. `mcp.json` stays in
  the repo for the desktop install (`scripts/install-chatgpt-local.sh`).

## Install or update

- **First time:** chatgpt.com/plugins › **Add** › **Upload plugin archive**.
- **Update:** open the existing plugin › ⋯ › **Upload new version**.
- **Share with a workspace:** Personal › ⋯ on Altis › **Publish** (workspace admin).

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
