# Spec bundle standard (living standard)

## Goal

Define a **deterministic spec bundle** format and a standard consumer workflow to fetch and verify it, enabling reproducible codegen and drift detection.

## Why

Consumers need a stable artifact, not a moving target. Deterministic bundles make CI reliable, diffs reviewable, and failures actionable.

## Bundle contents (v1)

A spec bundle is a zip file containing:

- `openapi.yaml` (canonical contract)
- `openapi.json` (normalized rendering; optional but recommended)
- `bundle.manifest.json` (required)

## Manifest requirements (v1)

`bundle.manifest.json` MUST include:

- **bundle_format_version**: integer (start at 1)
- **spec_ref**: the tag or commit SHA the bundle corresponds to
- **files**: list of entries:
  - `path`
  - `sha256`
  - `bytes` (optional)

Determinism guidance:

- Avoid timestamps or machine-specific fields.
- If you include a timestamp, keep it clearly separated and do not include it in hash verification logic.

## Naming and publishing (v1)

- Bundle file name convention:
  - `ebo-planner-spec-bundle-vX.Y.Z.zip`
- Publishing:
  - Attach bundle + manifest to the GitHub Release created from the same tag.

## Consumer fetch + verify workflow (v1)

Given a pinned `spec.lock` ref:

- Fetch the spec bundle for that ref.
- Verify the bundle’s `bundle.manifest.json`:
  - every file listed exists in the bundle
  - every file’s SHA256 matches
- Use the verified bundle as the only input to codegen and contract validation.

## Cache guidance (v1)

- Cache the downloaded bundle in CI to reduce latency.
- Cache keys should include the pinned ref and manifest hash.

## Generated code placement (convention)

- Backend: `internal/gen/` (or `internal/oapi/`)
- CLI: `internal/gen/` (or `pkg/gen/`)
- Web: `src/gen/` (or `src/api/gen/`)

Each generated directory should include a short README stating:

- it is generated
- how to regenerate
- what spec ref it is based on (implicitly via `spec.lock`)

## CI enforcement expectations (v1)

- On PRs, consumers must:
  - fetch + verify pinned bundle
  - run codegen
  - ensure `git diff` is clean

## v1 non-goals

- Multi-language SDK packaging and distribution.
- Advanced OpenAPI lint rule sets and custom codegen plugins.
- Supporting multiple concurrent pinned specs in a single repo.
