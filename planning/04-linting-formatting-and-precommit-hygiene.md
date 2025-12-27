# 04) Linting, formatting, and pre-commit hygiene

## Goal

Adopt a **minimal, non-annoying** baseline for formatting/linting across repos, with fast local checks and CI consistency.

## Why

You want “clean by default” without turning solo development into a fight. Consistency reduces review overhead and prevents style churn, especially around generated code.

## Repos

- `ebo-planner-spec`
- `ebo-planner-backend`
- `ebo-planner-cli`
- `ebo-planner-web`

## Deliverables

- **Repo-local tooling decisions (boring defaults)**
  - Backend/CLI (Go):
    - Formatting: `gofmt`
    - Baseline correctness: `go test`, `go vet`
    - Optional v1: `staticcheck` or `golangci-lint` (keep rules minimal)
  - Web:
    - Formatting: `prettier`
    - Linting: `eslint` (and `next lint` if applicable)
  - Spec:
    - Markdown hygiene check (minimal; avoid bikeshedding)
    - YAML validation for `openapi/openapi.yaml` (basic syntax + OpenAPI validation handled in Area 6)
- **Pre-commit hygiene (low friction)**
  - Choose one:

    - `pre-commit` framework with a small hook set, or
    - a simple `scripts/install_hooks.sh` per repo
  - Hooks (v1):

    - run formatter(s) on staged files
    - prevent accidental manual edits to generated directories (or at least warn)
- **CI workflows**
  - `.github/workflows/lint.yml` per repo:
    - runs formatter checks
    - runs minimal lints
    - finishes quickly (target: minutes, not tens of minutes)
- **Documentation**
  - `docs/dev-hygiene.md` per repo (or a single canonical doc in spec repo that others reference) describing:
    - required tooling
    - “how to run locally”
    - how generated code is treated

## Dependencies

- Should be finalized after **Area 3 (Spec bundle & codegen standard)** so generated code locations are defined and handled consistently.
- Should precede **Area 6 (Testing layers)** so CI stays stable and fast.

## v1 Scope (out of scope)

- Heavy lint rulesets / stylistic bikeshedding.
- Mandatory hooks for all operations (recommend, don’t enforce).
- Enforcing lint/format on generated code beyond “don’t hand-edit.”
