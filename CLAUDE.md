# altis-mcp-plugin — agent rules

The Claude and ChatGPT plugins for the **Altis MCP** at `https://mcp.altis.vc/mcp` (sign-in required).
Not the free catalogue MCP linked in the altis.vc footer.

- `claude/` is the Claude plugin and the only folder the plugin directory reads, so everything it needs is inside
  it. `chatgpt/` is the ChatGPT plugin; its package takes the skills from `claude/skills`, and `chatgpt/skills`
  is a symlink to them. Edit skills in `claude/skills`; never replace the symlink with a copy.
- Tool names and arguments in `claude/skills/` and `claude/commands/` must match the server's tools (its `tools/list`).
  Check before editing; never invent a tool.
- The core of `claude/skills/altis-research/SKILL.md` is mirrored in the server's own instructions, so clients
  without the plugin get it too. Change one, consider the other.
- `claude/.mcp.json` carries no key: the server sends clients to sign in on www.altis.vc (OAuth).
  Never put a `pmcp_` key, a personal URL `/mcp/<key>`, or any secret in this repo.
- The MCP URL, `https://mcp.altis.vc/mcp`, appears in `claude/` and `chatgpt/`.
  Never use any other host for it.
- One version for both plugins: bump it in `claude/.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`
  and `chatgpt/plugin.json` on every change users should pick up, add a `CHANGELOG.md` entry, build with
  `scripts/package.sh`, and tag `v<version>`. The script refuses a version mismatch.
- The MCP URL is in `claude/.mcp.json` AND `chatgpt/mcp.json`: change both together. The skills are shared.
- Releases are GitHub releases with both zips attached (`scripts/package.sh --release`); never commit a zip.
- This repo may become public. Everything in it (the READMEs, `chatgpt/`, `CHANGELOG.md`, which becomes the
  release notes, and this file) is written so it can be: what users get and how to maintain the plugin, not
  how the server works. No internal repo or file names, account names, env vars, people's names or emails
  (contact is support@altis.vc), keys, or debugging notes.
