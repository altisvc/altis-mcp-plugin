---
name: altis-meeting-prep
description: Use when the user is preparing for a meeting, call or diligence session with a company or its founders and wants a brief built from Altis research.
---

# Meeting prep from Altis

Follow the altis-research skill for how to call the tools. Then:

1. `lookup_company` → `get_company`. Note the coverage rung; if Altis has no report, say so up front.
2. If there is a report: `asset_outline`, then `fetch_asset` its summary and key debates.
3. `find_text` across the company's pieces for what a meeting turns on: `any_of` such as
   ["pricing", "churn", "retention", "competition", "moat", "risk"].
4. `list_latest` with `company` and a recent `since` for anything published since the report.

## Output

- **Thesis** — one paragraph, in Altis's own framing.
- **Key debates** — three, each with Altis's view and the evidence behind it.
- **What has changed** — anything newer than the report.
- **Questions to ask** — five, each tied to a debate or a gap in the research.
- **Sources** — every piece used, with its altis.vc link.
