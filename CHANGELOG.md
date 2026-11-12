# Changelog

What changed for people using the Altis plugin in Claude or ChatGPT. Each version is a
[release](https://github.com/altisvc/altis-mcp-plugin/releases) with both packages attached.

## 0.1.8 — 2026-11-12

The skills describe a company's coverage by what Altis has published on it ("Altis has a Company
Report on Harvey") and read the server's new `coverage_level` field.

## 0.1.7 — 2026-11-03

New skill **altis-brief**: a 300-word brief on one company, with sources. It was a Claude-only
command (`/altis:brief`, which still works); as a skill it is in ChatGPT too, so both plugins have
the same six skills.

Signing in with any Altis account now gives you search; reading the research itself takes an all-access
account. The plugin's descriptions and the altis-research skill say so.

## 0.1.6 — 2026-10-30

New skills:
- **altis-follow**: get new Altis research delivered on a schedule you choose (hourly, every 6 hours,
  daily or weekly), for everything Altis publishes or only the sectors and companies you pick. Quiet
  when there is nothing new.
- **altis-coverage-sweep**: look through your recent email, calendar and meeting notes and find what
  Altis has published on the companies and topics you are working on, once or on a schedule.
- **altis-flag**: while Claude or ChatGPT helps with your email, meetings or documents, a short note
  when Altis has research on a company or topic that comes up.

## 0.1.5 — 2026-10-30

ChatGPT: the plugin now includes the Altis connector, so skills and sign-in come together in one install.

## 0.1.4 — 2026-10-28

ChatGPT: the plugin works on the web, not only in the desktop app.

## 0.1.3 — 2026-10-28

The Altis plugin for ChatGPT, with the same skills as the Claude plugin.

## 0.1.2 — 2026-10-28

Packaging and release tooling. No change for users.

## 0.1.1 — 2026-10-28

The Altis connector address is now `https://mcp.altis.vc/mcp`.

## 0.1.0 — 2026-10-28

First version of the Altis plugin for Claude: the Altis connector (sign in with your Altis account),
the skills **altis-research** and **altis-meeting-prep**, and the command `/altis:brief`.
