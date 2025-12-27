# Constitution — Overland Trip Planning Specification

## 1. Purpose

This repository is the **single source of truth** for the Overland Trip Planning system’s:

- Public API contract
- Domain language and invariants
- Use-case behavior definitions
- Acceptance scenarios and examples

If a change affects **what the system does** or **what clients can expect**, it must be represented here first.

This repository defines **what the system is**, not how it is implemented.

**We practice spec-first development.** All requirements changes — new features, changes to behavior defined by a use case, and API contract changes (OpenAPI) — **must originate in this spec repository**.

---

## 2. Authority Model

- This repository is authoritative for:
  - API structure and semantics
  - Domain terminology and invariants
  - Use-case behavior and authorization rules
- Implementation repositories (service, CLI, web app) **must conform** to this repository.
- No implementation repository may introduce externally visible behavior that is not defined here.

---

## 3. Scope

### 3.1 Allowed content

- OpenAPI contract (`openapi/openapi.yaml`)
- Domain model, glossary, and invariants
- Use-case specifications (`use-cases/UC-*.md`)
- Acceptance and system scenarios (`scenarios/`)
- Example request/response payloads (`examples/`)
- Contract-level architectural decisions (`adr/`)
- Changelog documenting externally visible changes

### 3.2 Disallowed content

- Service implementation details (DB schema, persistence strategies)
- Infrastructure or deployment configuration
- Client UI implementation details
- Generated code
- Secrets, credentials, or PII beyond anonymized examples

---

## 4. Contract-First Development Rules

### 4.1 Change order (mandatory)

1. Update this spec repository
2. Review and merge the change
3. Tag a release
4. Update consuming repositories to the new tag
5. Implement or adapt behavior

Skipping step (1) for externally visible changes is not allowed.

### 4.2 What must change together

- API changes → OpenAPI **must** be updated
- Behavior or rules changes → relevant use cases **must** be updated
- User-visible behavior changes → scenarios **should** be updated

---

## 5. Versioning (Semantic Versioning)

This repository uses **Semantic Versioning**: `vMAJOR.MINOR.PATCH`.

### 5.1 Breaking changes (MAJOR)

Examples:

- Removing or renaming endpoints
- Removing or renaming fields
- Changing field meaning or type
- Tightening validation that rejects previously valid requests
- Changing authorization rules that affect existing clients
- Altering state transitions (e.g., publish/cancel semantics)

### 5.2 Additive changes (MINOR)

Examples:

- Adding new endpoints
- Adding new optional fields
- Adding new enum values (clients must tolerate unknown values)

### 5.3 Non-behavioral changes (PATCH)

Examples:

- Documentation corrections
- Clarifying descriptions
- Example improvements
- Non-normative formatting changes

---

## 6. Use-Case Authority

- Every externally visible operation must map to a documented use case.
- Use cases define:
  - Preconditions
  - Main flow
  - Alternate flows
  - Error conditions
  - Authorization rules
  - Domain invariants enforced
- OpenAPI describes **structure**; use cases describe **behavior**.
- If OpenAPI and a use case disagree, the **use case is authoritative**.

---

## 7. Acceptance Scenarios

- Scenarios represent end-to-end narratives suitable for system testing.
- They should reference use cases explicitly.
- Scenarios are normative for behavior but not for implementation.
- Consumers are encouraged to use scenarios as acceptance tests.

---

## 8. Conventional Commits & Changelog

### 8.1 Commit format

All commits must follow **Conventional Commits**, for example:

- `feat(api): add trip artifact links`
- `feat(use-cases): define publish preconditions`
- `fix(spec): correct rsvp enum description`
- `chore: reorganize scenarios`

### 8.2 Changelog

- Every change that affects external behavior must be recorded in `CHANGELOG.md`.
- Changelog entries must reference:
  - impacted endpoints
  - impacted use cases
  - migration notes when applicable

---

## 9. Development workflow (mandatory)

### 9.1 Branches only

- All work MUST happen on a branch (no direct commits to `main`).
- Branch names MUST be: `{type}/{slug}`
  - `{type}` MUST be one of: `chore`, `bug`, `refactor`, `feature`
  - `{slug}` MUST be a short, lowercase, hyphenated description
  - Examples:
    - `feature/trip-publish-contract`
    - `bug/rsvp-status-enum-docs`
    - `refactor/reorganize-use-cases`
    - `chore/changelog-guard-tuning`

### 9.2 Pre-flight before PR

- Before creating or updating a PR, you MUST run `make ci` locally and it MUST pass.

### 9.3 Pull requests required

- Every change MUST be delivered via a pull request.
- CI must be green before merge (required checks).

### 9.4 Automation via `gh`

- Cursor agents SHOULD use the GitHub CLI (`gh`) to create PRs and set titles/descriptions.
- Cursor agents MUST enable auto-merge using **squash** for routine changes (so PRs merge automatically once required checks/reviews are satisfied).

Example:

```bash
gh pr create --fill
gh pr merge --auto --squash
```

---

## 10. Review Requirements

The following changes require at least one explicit reviewer:

- Any change to `openapi/openapi.yaml`
- Any change affecting:
  - trip publishing
  - cancellation
  - RSVP behavior
  - authorization rules
- Any breaking change (MAJOR version bump)

---

## 11. Repository Layout Conventions

Recommended structure:

- `openapi/` — canonical API contract
- `domain/` — domain model and glossary
- `use-cases/` — use-case specifications
- `scenarios/` — acceptance narratives
- `examples/` — request/response examples
- `adr/` — contract-level decisions

---

## 12. Consumer Responsibilities

- Consumers must pin to an explicit tag (no floating branches).
- Generated clients or servers must be reproducible from the pinned spec.
- Consumers must not rely on undocumented behavior.

---

## 13. Non-Goals

- This repository does not contain implementation code.
- This repository does not define UI or UX behavior.
- This repository is not a dumping ground for design ideas.
- This repository does not negotiate behavior — it declares it.

---

## 14. Guiding Principle

> **If it affects interoperability, trust, or expectations, it belongs here first.**
