# 02) Release automation

## Goal

Create a **tag-driven, low-touch release flow** per repo with predictable artifacts and simple version propagation rules suited to a solo developer.

## Why

Releases are where discipline collapses. Tag-driven automation keeps velocity high while maintaining auditability, reproducibility, and consistent artifacts.

## Repos

- `ebo-planner-spec`
- `ebo-planner-backend`
- `ebo-planner-cli`
- `ebo-planner-web`

## Deliverables

- **Shared conventions (documented in spec repo)**
  - Tag format per repo: `vX.Y.Z`
  - Release requirement: a matching entry exists in `CHANGELOG.md` (aligned with existing changelog discipline)
  - Artifact naming conventions and checksum expectations
  - Version propagation rule: each repo owns its version; consumers update `spec.lock` explicitly when adopting a new spec release
- **Spec repo**
  - Workflow: `.github/workflows/release.yml`
    - Trigger: `push` tags `v*`
    - Build: spec bundle artifact (see Area 3)
    - Publish: GitHub Release with attached bundle + manifest
- **Backend repo**
  - Workflow: `.github/workflows/release.yml`
    - Trigger: `push` tags `v*`
    - Build: container image
    - Publish: push to GHCR (preferred) + GitHub Release notes
    - Attach: image digest + build metadata (and optional SBOM; see Area 5)
- **CLI repo**
  - Workflow: `.github/workflows/release.yml`
    - Trigger: `push` tags `v*`
    - Build: binaries for a minimal set of targets (v1):

      - `darwin/arm64`, `darwin/amd64`, `linux/amd64`
    - Publish: GitHub Release with binaries + checksums
- **Web repo**
  - Workflow: `.github/workflows/release.yml`
    - Trigger: `push` tags `v*`
    - Build: deployable artifact (hosting-agnostic in v1)
    - Publish: GitHub Release notes + build metadata artifact
- **Version propagation rules**
  - Spec releases create immutable bundles.
  - Consumer repos only bump their versions when they ship changes.
  - Consumer repos update `spec.lock` when they adopt a new spec release; that update is reviewed like any other dependency bump.

## Dependencies

- Depends on **Area 3 (Spec bundle & codegen standard)** for the spec release artifact.
- Depends on **Area 1 (Cross-repo contract discipline)** so releases are gated on contract compliance.
- Should align with **Area 5 (Security baseline)** if you want checksums/SBOMs baked into release workflows from day one.

## v1 Scope (out of scope)

- Automated coordinated “release train” across repos.
- Homebrew/Scoop packaging for CLI.
- Multi-environment web deployment orchestration in CI (keep v1 to build + metadata).
- Complex release note generation beyond changelog-driven notes.
