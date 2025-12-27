# ADR 0002: Deterministic spec bundle publishing + consumer verification

## Status

Accepted

## Context

Consumers (backend/cli/web) need a stable, reproducible way to:

- fetch the exact contract version pinned in `spec.lock`
- validate it has not been tampered with or partially updated
- run code generation deterministically

Using raw files from a branch (e.g., `main`) or ad-hoc downloads creates ambiguity and drift, especially when multiple consumers are involved.

## Decision

We will publish a **deterministic spec bundle** from the spec repo on tagged releases and require consumers to:

- fetch the bundle by the pinned ref in `spec.lock`
- verify the bundle using a manifest with SHA256 hashes
- use the verified bundle as the only input to codegen and contract validation

The operational “living standard” for this decision is:

- [`planning/spec-bundle-standard.md`](../planning/spec-bundle-standard.md)

## Consequences

- **Pros**
  - Clear, immutable artifact for each spec release
  - Simple drift detection using manifest hashes
  - Supports consistent codegen and CI enforcement across consumers
- **Cons**
  - Requires defining and maintaining a bundle format + manifest schema
  - Adds a small amount of release automation to the spec repo

## Alternatives considered

- **Publish only raw `openapi.yaml`**
  - Rejected: lacks integrity metadata and makes verification harder.
- **Consumers normalize/convert spec themselves**
  - Rejected: increases divergence risk and moves complexity into every repo.
- **Host spec artifacts in an external package registry**
  - Deferred: GitHub Releases is simpler and sufficient for v1.

## Notes

This ADR focuses on the **artifact standard and verification**. Cross-repo discipline and CI expectations are captured in ADR 0001 and [`planning/contract-policy.md`](../planning/contract-policy.md).
