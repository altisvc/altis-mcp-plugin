---
name: altis-coverage-sweep
description: Use when the user wants you to go through their email, calendar, meeting notes or messages and find what Altis has published on the companies, sectors and topics they are working on, either once (a lookback) or as a recurring check on new mail and meetings.
---

# Sweeping the user's work for Altis coverage

Matches what the user is actually working on (from their connected email, calendar, meeting notes
and messages) against Altis research, and says "Altis has something on this" where it does.
Needs those integrations connected; if none are, say so and ask the user to list the companies
and topics instead.

## Before you start, ask

1. **How far back to look:** 7 days, 30 days, 90 days, or skip the lookback.
2. **Whether to keep checking:** a recurring check on new mail and meetings, and how often
   (hourly, every 6 hours, daily or weekly), or just this once.

## Step 1: the lookback (unless the user chose skip)

1. Go through email (received **and** sent), calendar events and meeting notes in the window.
2. Pull out the specific **companies, sectors and topics the user is working on**. Leave out:
   newsletters they only received, their own company, generic tools (Zoom, Slack, Google…),
   and people's names.
3. Check each against Altis:
   - a company → `lookup_company`, then `get_company` for its coverage level and pieces;
   - a sector or theme → `lookup_sector` / `search`;
   - a topic that is neither → `semantic_search`.
4. Report, grouped by where it came up:
   - **Altis has something on this:** the company or topic, where it came up (the email subject or
     meeting title and date), its coverage level (what Altis has published on it), and the best piece with its altis.vc link (the
     report if there is one, else the newest landscape, pulse or signal).
   - **Checked, no Altis coverage:** a plain list, so the user sees the sweep was thorough.

Do not quote the user's private email in the report beyond the subject or meeting title needed to
say where something came up.

## Step 2: the recurring check (if the user asked for one)

Schedule a job on the chosen cadence that repeats Step 1 on anything **new since the last run**.
It messages the user **only when there is a match**, and never flags the same company or topic
twice within 30 days unless Altis has published something new on it since (check `list_latest`
with `company` and `since`).

To follow everything Altis publishes, not only what matches the user's work, use the altis-follow
skill as well.

## Always

Follow the altis-research skill for citing. Never present a company as covered from memory:
coverage is what `get_company` says.
