# 01) Cross-repo contract discipline

## Goal

Establish **hard, repeatable rules** so every consumer repo (service/CLI/web) uses the **same pinned spec version**, detects drift early, and validates contracts consistently.

## Why

Spec-first only works if **“what we ship” == “what we implement”**. Without discipline, you get silent breakage, mismatched clients, and contract ambiguity that surfaces late.

## Repos

- `ebo-planner-spec`
- `ebo-planner-backend`
- `ebo-planner-cli`
- `ebo-planner-web`

## Deliverables

- **Policy + conventions (spec repo)**
  - `planning/contract-policy.md`: source-of-truth rules for pinning, drift detection, and validation responsibilities.
  - Definition of accepted pin formats in `spec.lock`:

    - Prefer **spec tag** (e.g., `vX.Y.Z`)
    - Allow commit SHA only when necessary (document when/why)
- **Spec pinning enforcement (consumer repos)**
  - CI workflow (each consumer repo): `.github/workflows/spec-lock.yml`
    - Validates `spec.lock` exists and is well-formed
    - Validates the pinned ref resolves in the spec repo
    - Fetches the pinned spec bundle and verifies hashes (see Area 3)
    - Fails with actionable messages (what to run locally, what to update)
  - Script (each consumer repo): `scripts/verify_spec_lock.sh` (or a wrapper around an existing script)
    - Runs the same checks locally that CI runs
    - Supports `--ci` mode for strict failure output
- **Drift detection model**
  - Drift definition (v1): “consumer-generated or cached artifacts do not match the pinned spec bundle hash”
  - CI behavior (v1): fail PR if drift is detected
- **Contract validation expectations**
  - Consumer responsibility: validate generated code corresponds to pinned bundle (no ad-hoc regeneration from `main`)
  - Service responsibility: must not deploy if its generated server code is out of sync with pinned bundle

## Dependencies

- Depends on **Area 3 (Spec bundle & codegen standard)**: drift detection relies on deterministic bundle + manifest/hashes.
- Should be in place before **Area 6 (Testing layers)**: tests should assume deterministic contracts.
- Should be in place before **Area 2 (Release automation)**: releases should be blocked on contract compliance.

## v1 Scope (out of scope)

- Automated multi-repo PR generation (“spec change opens PRs everywhere”).
- Runtime contract negotiation / content-type versioning.
- Supporting multiple concurrent spec versions in the same binary.
- Complex semantic diff tooling beyond “bundle hash changed” + basic OpenAPI validation.
