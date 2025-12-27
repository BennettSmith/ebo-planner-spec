# 03) Spec bundle & codegen standard

## Goal

Define **exactly what spec artifacts are published**, how consumers fetch them, where generated code lives, and how CI ensures generated code is up to date.

## Why

In spec-first systems, “codegen chaos” is a top source of friction. A boring, consistent standard prevents churn and keeps diffs reviewable.

## Repos

- `ebo-planner-spec`
- `ebo-planner-backend`
- `ebo-planner-cli`
- `ebo-planner-web`

## Deliverables

- **Spec bundle definition (spec repo)**
  - Document: `planning/spec-bundle-standard.md` describing:

    - Bundle contents (v1):

      - `openapi.yaml` (canonical)
      - `openapi.json` (normalized rendering; optional but helpful)
      - `bundle.manifest.json` including:

        - pinned ref (tag/commit)
        - SHA256 of each file
        - bundle schema/version
    - Determinism rules (avoid non-deterministic timestamps unless clearly separated)
    - Naming: `ebo-planner-spec-bundle-vX.Y.Z.zip`
- **Publishing mechanism (v1: GitHub Releases in spec repo)**
  - Spec release attaches:
    - zip bundle
    - `bundle.manifest.json` (also inside the zip)
- **Consumer fetching standard (backend/cli/web)**
  - A single approach across consumers:
    - Fetch bundle using the ref pinned in `spec.lock`
    - Verify SHA256 checksums against `bundle.manifest.json`
    - Cache bundle in a deterministic CI-friendly location
- **Where generated code lives (convention; enforceable by CI)**
  - Backend: `internal/gen/` (or `internal/oapi/`) + README “generated; do not edit”
  - CLI: `internal/gen/` (or `pkg/gen/` if exported types are needed)
  - Web: `src/gen/` (or `src/api/gen/`) for types/client stubs
- **CI enforcement model (each consumer repo)**
  - Workflow: `.github/workflows/codegen.yml`
    - On PR: fetch pinned bundle → run codegen → ensure `git diff` is clean
    - On main: same checks to prevent drift
  - Makefile targets (plan only):
    - `make spec-fetch`
    - `make gen`
    - `make verify-gen`

## Dependencies

- Should be completed before **Area 1 (Cross-repo contract discipline)**: drift detection relies on bundle + manifest.
- Should be completed before **Area 6 (Testing layers)**: tests should rely on stable generated code.
- Should precede **Area 2 (Release automation)**: spec releases publish the bundle.

## v1 Scope (out of scope)

- Custom codegen plugins and templating.
- Multi-language SDK packaging.
- Supporting multiple spec bundles concurrently in a repo.
- Advanced OpenAPI linting beyond basic validation + normalization.
