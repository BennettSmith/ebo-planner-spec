# 05) Security baseline

## Goal

Put in place a **minimal security and supply-chain baseline** that scales with a solo developer: secret hygiene, dependency visibility, and basic artifact integrity.

## Why

Security debt is cheapest to avoid early. The key is “small and always on,” not “big and never used.”

## Repos

- `ebo-planner-spec`
- `ebo-planner-backend`
- `ebo-planner-cli`
- `ebo-planner-web`

## Deliverables

- **Secret handling expectations (policy + repo hygiene)**
  - Spec repo doc: `planning/05-security-baseline.md` (this document) defines:

    - no secrets in git, no `.env` committed, no local keys checked in
    - how to handle local dev secrets (documented per repo)
  - Confirm `.gitignore` conventions per repo (plan item; implement later)
  - GitHub settings checklist (documented steps):

    - enable secret scanning and push protection where available
- **Dependency scanning**
  - Add Dependabot per repo:

    - `.github/dependabot.yml` with weekly cadence
    - group updates to reduce noise for a solo maintainer
  - Minimal code scanning policy:

    - use GitHub’s built-in scanning defaults where available
    - otherwise, keep v1 to dependency + secret scanning
- **Release integrity (minimal)**
  - For CLI releases:

    - publish checksums for binaries
  - For backend image releases:

    - publish image digest
  - Optional-but-reasonable v1:

    - generate SBOM for release artifacts (document tool choice; implement later)
- **Container baseline (backend)**
  - Document expectations:

    - minimal base image
    - run as non-root where feasible
    - no baked-in secrets
    - clearly documented ports and env vars

## Dependencies

- Should align with **Area 2 (Release automation)** so integrity artifacts are attached during releases.
- Can proceed in parallel with **Area 4 (Linting/formatting)** because they’re operationally separate.

## v1 Scope (out of scope)

- Full threat modeling.
- High-complexity SLSA/provenance work.
- Enterprise secret management integration (Vault, etc.).
- Pen testing automation and dedicated security tooling stacks.
