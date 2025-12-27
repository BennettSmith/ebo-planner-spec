# 06) Testing layers aligned to architecture

## Goal

Define testing layers that match the spec-first architecture:

- **Spec → scenarios**
- **Service → domain / integration / system**
- **CLI → command & output stability**
- **Web → critical flows only**

## Why

Without explicit boundaries, tests become slow, flaky, and redundant. Clear layers keep confidence high while keeping maintenance cost low for a solo developer.

## Repos

- `ebo-planner-spec`
- `ebo-planner-backend`
- `ebo-planner-cli`
- `ebo-planner-web`

## Deliverables

- **Spec repo**
  - Document: `docs/testing.md` (or `planning/testing-standard.md`) defining:
    - what “scenario” files mean and how they are validated
    - what constitutes a breaking change from a scenario perspective
  - CI workflow: `.github/workflows/spec-validate.yml`
    - OpenAPI validation for `openapi/openapi.yaml`
    - Scenario validation (schema + internal consistency)
    - (If applicable) ensure examples referenced by scenarios exist and are well-formed
- **Backend repo**
  - Document: `docs/testing.md` defining a test taxonomy:
    - **Domain tests**: fast, pure, deterministic (no DB/network)
    - **Integration tests**: DB + adapters; run in CI with ephemeral dependencies
    - **System tests**: HTTP API against a running service (minimal set)
  - CI workflows:
    - Unit/domain tests on every PR
    - Integration tests on PR (or nightly if too slow; prefer PR for confidence)
    - System tests: small smoke set on PR, fuller set on main (optional)
- **CLI repo**
  - Document: `docs/testing.md` describing:
    - command parsing tests
    - “golden” output tests for a small set of key commands
    - stability policy for output formatting (what changes require a version bump)
  - CI workflow: run `go test ./...` plus golden tests
- **Web repo**
  - Document: `docs/testing.md` describing:
    - a tiny set of critical flow tests (auth + one primary user journey)
    - minimal unit tests only where logic is non-trivial
  - CI workflow:
    - unit tests + lint on PR
    - a small e2e/smoke suite (keep runtime low)

## Dependencies

- Depends on **Area 3 (Spec bundle & codegen standard)** so tests can assume deterministic contracts and generated code locations.
- Benefits from **Area 4 (Linting/formatting)** to keep CI output actionable and stable.

## v1 Scope (out of scope)

- Large end-to-end suites and broad browser/device matrices.
- Performance, load, chaos, or fuzz testing.
- Snapshot testing everywhere (keep snapshots targeted to stable outputs only).
- Running full system tests in every repo on every commit (keep cross-repo coupling minimal).
