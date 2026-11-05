---
name: altis-flag
description: Use while helping the user with their email, calendar, meetings, messages or documents (drafting a reply, preparing for a meeting, summarising a thread) when a company, sector or market topic comes up that Altis may have researched. Proactively checks Altis and flags relevant coverage.
---

# Flagging Altis coverage in the flow of work

When the user is working on something else and a **specific company, sector or market topic** comes
up (in an email you are reading or drafting, a meeting on the calendar, a document, a message),
check whether Altis has research on it, and if so mention it briefly.

## How

1. Pick out the companies and topics that matter to the task. Ignore the user's own company,
   generic tools, and people's names.
2. `lookup_company` for a company; `lookup_sector` or `search` for a sector or topic. One quick call
   each; do not read the research unless the user asks.
3. Where Altis has something, add one line at the end of your answer:
   **Altis has something on this:** <company or topic>: <the best piece's title>, <its altis.vc link>.
   The best piece is the report if there is one, else the newest landscape, pulse or signal.
4. Where Altis has nothing, say nothing about it.

## Keep it light

- At most three flags per answer; the most relevant first.
- Do not repeat a flag already made earlier in the conversation.
- Never let the check delay or replace the task the user asked for.
- If the user says to stop flagging, stop for the rest of the conversation.

For a deliberate sweep of past email and meetings, use the altis-coverage-sweep skill instead.
