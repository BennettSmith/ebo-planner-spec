# Foundational setup plan (index)

## Purpose

This folder contains a **foundational setup plan** for a spec-first, multi-repo system:

**Spec → Service → CLI / Web**

The documents are intentionally “boring and reliable,” optimized for a **solo developer** using **GitHub Actions**.

## How to use this plan

- Treat each `planning/0X-...md` file as a self-contained agent prompt later.
- Implement in the recommended order to avoid rework.
- Keep v1 small: enforce determinism, pin contracts, automate releases, and keep CI fast.

## Recommended implementation order (prevents rework)

- **03 → 01 → 04 → 06 → 02 → 05 → 07 → 08 → 09**

### Rationale (short)

- **03 Spec bundle & codegen standard**: everything depends on a concrete, deterministic spec artifact and a shared codegen approach.
- **01 Contract discipline**: once artifacts exist, enforce pinning + drift detection everywhere.
- **04 Hygiene**: keep generated code and formatting stable; make CI output readable.
- **06 Testing layers**: build confidence aligned to architecture without runaway E2E.
- **02 Release automation**: ship repeatably once checks and artifacts exist.
- **05 Security baseline**: add always-on hygiene (secrets/deps/integrity) without heavy ceremony.
- **07 Docs/hygiene**: centralize system docs and remove duplication once practices are real.
- **08 Templates**: encode the rules into low-friction PR/issue flows.
- **09 Observability**: add service runtime visibility once core build/test/release is stable.

## Documents

- `01-cross-repo-contract-discipline.md`
- `02-release-automation.md`
- `03-spec-bundle-and-codegen-standard.md`
- `04-linting-formatting-and-precommit-hygiene.md`
- `05-security-baseline.md`
- `06-testing-layers-aligned-to-architecture.md`
- `07-repo-hygiene-and-documentation.md`
- `08-issue-templates-and-pr-templates.md`
- `09-observability-for-the-service.md`

## Cross-cutting standards (living documents referenced by the above)

- `contract-policy.md` (pinning, adoption, drift definition, CI expectations)
- `spec-bundle-standard.md` (bundle format, manifest/hashes, consumer verification)

## ADRs (decision records that point to the living standards)

- [`adr/0001-contract-discipline-via-spec-lock.md`](../adr/0001-contract-discipline-via-spec-lock.md)
- [`adr/0002-deterministic-spec-bundle-and-consumption.md`](../adr/0002-deterministic-spec-bundle-and-consumption.md)
