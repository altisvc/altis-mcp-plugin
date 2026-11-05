---
name: altis-follow
description: Use when the user wants to follow Altis, be alerted or emailed when Altis publishes new research, get a recurring digest of new Altis pieces, or set up a scheduled check on Altis (overall, or for a sector, company or piece type).
---

# Following new Altis research

Sets up a recurring job that tells the user about new Altis research, so it reaches them without
their coming back to ask.

## Before you schedule anything, ask

1. **How often to check:** hourly, every 6 hours, daily or weekly. Do not guess "daily": a job the
   user did not choose is one they have to find and edit.
2. **What to follow:** everything Altis publishes, or only some sectors, companies or piece types
   (reports, landscapes, scans, pulses, signals, expert calls). Default: everything.
3. **Where to send it**, if you can deliver more than one way (this chat, email, a message).
   Default: wherever your scheduled tasks normally report.

## The job

Each run:

1. `list_latest` with `since` = the newest date already reported (on the first run, today: treat
   everything already published as seen). Add `sector`, `company` or `type` if the user narrowed it.
   Page through until the items are older than `since`.
2. Skip any `asset_id` already sent. A transcript's date is its call date, so it can arrive dated
   before a piece you already reported; remember ids, not only the date.
3. If nothing is new, **send nothing**. No "no new research" messages.
4. Otherwise send one short message: each new piece with its title, type, the company or sector it
   is about, its date, one line on what it is (from its title and listing, or a quick
   `asset_outline` / `fetch_asset` of its opening when the title is not enough) and its altis.vc
   link. Newest first. Group by sector when there are more than five.

## If you cannot schedule

Say so plainly, and offer the one-off version: `list_latest` with `since` set to the user's last
check, now.

## Always

Follow the altis-research skill for citing: every piece with its altis.vc link, nothing presented
as Altis research that the tools did not return.
