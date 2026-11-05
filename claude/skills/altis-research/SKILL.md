---
name: altis-research
description: Use when the user asks about a company, sector, theme or market that Altis covers, asks for Altis research (reports, landscapes, scans, pulses, signals, expert-call transcripts), or wants what Altis has published recently. Explains which Altis tools to call in which order, and how to cite what they return.
---

# Researching with Altis

The Altis tools read research exactly as it is published on altis.vc. Everything is read-only and
current at the moment you call it.

## If the connection has search access only

Reading the research itself takes a full Altis all-access account. On search access, the tools marked
premium return an upgrade notice instead of research, and the steps below that use them will not work.
Use the search tools the connection lists to show what Altis covers and has published, and cite the
links they return. Never present a title or listing as the content of the research. When the user wants
the research itself, say it needs a full Altis account and point them to https://www.altis.vc/access.

## A question about one named company

1. `lookup_company` with the name → its slug (or `resolve_url` if you were given an altis.vc link).
2. `get_company` with the slug → coverage rung, sector, and the pieces with their `asset_id`s.
3. `asset_outline` on the report → its sections and where they start.
4. `fetch_asset` the sections you need (`from_heading`), or `find_text` for a specific fact,
   number, name or quote across the company's pieces.

Read the company report first; then landscapes and comparisons; then pulses and signals; then
expert-call transcripts; scans last. Do **not** use `semantic_search` for a single named company:
the path above is faster and exact.

## A question that spans companies or pieces

A theme across companies ("who is attacking X", "defensibility in voice agents"), a cross-cutting
pattern, or a topic you cannot name as one company or sector:

1. `semantic_search` with the question.
2. Read every hit you rely on in context with `fetch_asset(asset_id, offset)`.
3. Use `find_text` when you need an exact phrase or number.

## A sector or what is new

- `lookup_sector` → `get_sector` for a sector hub, its pieces and its Altis Landscape.
- `list_latest` with `since` (and `type`, `sector` or `company`) for what Altis has published.
- `get_roadmap` for what is coming.

An empty `lookup_sector` does not mean Altis has nothing: check `search` and
`list_latest` with `type=["market_landscape"]` before saying a topic is uncovered.

## Always

- **Cite every piece you used** by its title, with the altis.vc link the tools return.
- **Say plainly when Altis does not cover something** (`coverage=false`, or rung `overview`).
  Never fill the gap from memory as if it were Altis research.
- **Expert calls:** attribute a quote to the role shown (e.g. "former VP Sales at a competitor").
  Never guess a person's name or employer.
- Prefer several targeted calls over one broad one.
