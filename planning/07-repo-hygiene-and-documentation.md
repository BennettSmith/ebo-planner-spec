# 07) Repo hygiene & documentation

## Goal

Standardize what documentation exists, where it lives, and how cross-repo references work—**without duplicating** source-of-truth content.

## Why

In a multi-repo system, docs rot fastest. Clear boundaries reduce drift and make it easier for “future you” to re-enter context quickly.

## Repos

- `ebo-planner-spec`
- `ebo-planner-backend`
- `ebo-planner-cli`
- `ebo-planner-web`

## Deliverables

- **Spec repo: system-level docs home**
  - `README.md` includes:
    - repo map (spec → backend → cli/web)
    - how `spec.lock` works at a high level
    - links to each repo and their run instructions
  - `docs/` contains system-level documents (canonical):
    - architecture overview
    - contract discipline policy (Area 1)
    - spec bundle/codegen standard (Area 3)
    - release policy overview (Area 2)
- **Each repo: repo-local docs**
  - Minimal required docs per repo (v1):
    - `README.md`: what it is, how to run, how to test, how to release
    - `docs/releasing.md` (already present): align headings and required sections
    - `docs/testing.md` (Area 6)
    - `docs/dev-hygiene.md` (Area 4) or link to spec repo canonical doc
- **Avoiding duplication rules**
  - Spec repo is the only place that defines the contract and its lifecycle.
  - Consumer repos link to spec repo docs rather than re-stating policies.
  - Service repo documents service-specific behavior (auth, persistence, ops), not contract policy.
- **Repo hygiene baseline**
  - Each repo has:
    - clear `Makefile` targets for common tasks (build/test/lint/gen)
    - consistent directory conventions for generated code
    - a short “local dev quickstart” section in `README.md`

## Dependencies

- Best done after **Areas 1–3** so documentation can point to stable policies and artifacts.
- Refine after **Area 2 (Release automation)** once release mechanics are concrete.

## v1 Scope (out of scope)

- Full documentation site (Docusaurus/MkDocs) and versioned docs.
- Big ADR process beyond what already exists.
- Auto-syncing docs across repos (avoid tooling overhead).
