# 08) Issue templates & PR templates

## Goal

Add lightweight GitHub templates that enforce **spec-first thinking** and keep PRs consistent across repos, with low friction for a solo developer.

## Why

Templates prevent “forgot to update changelog/spec pin/tests” mistakes. They act like guardrails when you’re moving fast and switching contexts across repos.

## Repos

- `ebo-planner-spec`
- `ebo-planner-backend`
- `ebo-planner-cli`
- `ebo-planner-web`

## Deliverables

- **PR template per repo**
  - File: `.github/pull_request_template.md` including:
    - Summary + rationale
    - Change type (feature/fix/chore/docs)
    - Checkboxes:
      - changelog updated (or “not needed” + justification)
      - `spec.lock` updated if contract adoption is required
      - generated code updated (if applicable) and committed
      - tests added/updated (minimal expectation)
      - docs updated (if behavior changes)
- **Issue templates per repo**
  - Files:
    - `.github/ISSUE_TEMPLATE/bug.md`
    - `.github/ISSUE_TEMPLATE/feature.md`
    - `.github/ISSUE_TEMPLATE/chore.md`
  - Spec repo templates additionally prompt:
    - breaking vs non-breaking contract change
    - scenario updates required?
    - migration notes for consumers
- **Cross-repo consistency model**
  - Same headings and checkboxes everywhere.
  - Repo-specific small sections (e.g., backend includes “DB/migrations impact”, web includes “UX impact”).
  - Keep templates short enough that you’ll actually use them.

## Dependencies

- Should align with **Areas 1–4** so templates reference real checks and commands.
- Can be implemented anytime; low coupling.

## v1 Scope (out of scope)

- Complex automation (auto-labeling, project boards, bots).
- Mandatory issue creation for every PR.
- Enforcing templates via CI beyond gentle checks (keep friction low).
