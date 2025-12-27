# 09) Observability for the service

## Goal

Implement a **minimal observability baseline** for the backend service: structured logs, basic metrics, and a clear “later” list.

## Why

When something breaks in a production-like environment, observability is the multiplier. A minimal baseline avoids premature platform complexity while keeping debugging practical.

## Repos

- Primary: `ebo-planner-backend`
- Planning + conventions: `ebo-planner-spec`

## Deliverables

- **Logging (v1)**
  - Spec repo doc section (or backend doc): standard logging fields and format:
    - structured JSON logs
    - required fields: `timestamp`, `level`, `message`, `request_id`, `route`, `status`, `latency_ms`
    - error fields when present: `error`, `error_kind` (optional), `stack` (optional)
  - Backend doc: `docs/observability.md`:
    - how to run locally and see logs
    - how request IDs are created/propagated
    - what is considered PII and should not be logged
- **Metrics (v1)**
  - Backend doc defines a minimal metric set:
    - HTTP request count by route/status
    - HTTP request duration histogram
    - in-flight requests
  - Export format: Prometheus scrape endpoint (boring, widely supported)
  - (Optional v1) include Go runtime metrics via standard tooling
- **Operational expectations (documented)**
  - “Debugging checklist” for common incidents:
    - auth failures, DB failures, upstream timeouts, validation errors
  - Local-only tooling notes (docker-compose optional) without requiring a full observability stack in v1

## Dependencies

- Depends on the service’s middleware/HTTP structure (implementation detail).
- Should be implemented after **Area 4 (Hygiene)** and alongside **Area 6 (System tests)** if you want to assert request IDs exist in responses/logs.

## v1 Scope (out of scope)

- Distributed tracing (OpenTelemetry) end-to-end.
- Centralized log aggregation deployment (ELK/Loki/etc.).
- Alerting rules, SLOs, and paging.
- High-cardinality metrics (per-user, per-trip) and dashboard curation.
