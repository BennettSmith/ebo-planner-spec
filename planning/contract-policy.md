# Contract policy (living standard)

## Goal

Define the contract discipline rules that make **spec-first** real across repos, with deterministic enforcement in CI and simple local workflows.

## Why

Without explicit rules, contracts drift silently and changes land without a clear adoption step. The result is mismatched clients, brittle releases, and wasted time debugging “wrong version” issues.

## Applies to

- **Spec repo**: produces immutable contract artifacts
- **Consumer repos** (backend/cli/web): pin and adopt contract versions explicitly

## Contract source of truth

- The canonical contract lives in: `openapi/openapi.yaml`
- Scenarios/examples in the spec repo clarify intent but do not override the contract unless explicitly defined as normative.

## Pinning rule (required)

- Every consumer repo MUST include `spec.lock`.
- `spec.lock` MUST pin a specific spec release ref:
  - Prefer a tag: `vX.Y.Z`
  - Allow a commit SHA only for short-lived work; convert to a tag before release
- Consumer builds, codegen, tests, and releases MUST use the pinned ref—never `main`/HEAD.

## Adoption rule (required)

Adopting a new spec version in a consumer repo is a deliberate change:

- Update `spec.lock`
- Fetch the new bundle
- Re-run codegen
- Update tests as needed
- Update changelog when user-visible behavior changes (consistent with existing changelog discipline)

## Drift definition (v1)

Drift exists when:

- The spec bundle fetched at `spec.lock` does not match the expected manifest hashes, OR
- Generated code in the repo is not reproducible from the pinned bundle using the standard codegen process.

## Validation expectations by repo

- **Spec repo**
  - Must validate OpenAPI correctness in CI.
  - Must publish deterministic spec bundles on release tags.
- **Backend repo**
  - Must fail CI if generated server code is not in sync with `spec.lock`.
  - Must not release if contract checks fail.
- **CLI/Web repos**
  - Must fail CI if generated client types/stubs are not in sync with `spec.lock`.
  - Must not release if contract checks fail.

## CI enforcement model (required)

Each consumer repo should have:

- A “spec lock verification” workflow that:
  - validates `spec.lock`
  - fetches bundle for pinned ref
  - verifies bundle hashes
  - runs codegen and ensures `git diff` is clean

## Error-message standards (v1)

CI failures should be actionable:

- state what changed (pin mismatch, bundle mismatch, generated code drift)
- state the fix (commands to run locally, files to update)

## v1 non-goals

- Automated multi-repo PR fan-out.
- Supporting multiple spec versions simultaneously.
- Sophisticated compatibility analysis beyond basic validation and drift detection.
