# East Bay Overland — Planner Spec

This repo is the **source of truth** for:

- **Requirements / use case definitions**: `use-cases/`
- **Supporting spec docs + diagrams**: `specs`
- **API contract** (OpenAPI): `openapi.yaml`

Start here: `docs/README.md`

## How this is used

The backend repo (`ebo-planner-backend`) generates server glue and transport DTOs from this OpenAPI spec.

From the backend repo, regenerate code with:

```bash
make gen-openapi
```

By default, the backend Makefile assumes this repo lives next to it (as `../ebo-planner-spec`). If your checkout layout differs, run:

```bash
EBO_SPEC_DIR=/absolute/or/relative/path/to/ebo-planner-spec make gen-openapi
```

## Changelog & releases

- **For PRs**: update `CHANGELOG.md` under **`## [Unreleased]`** with a short note in the right section (`### Added`, `### Changed`, `### Deprecated`, `### Removed`, `### Fixed`, `### Security`).
- **To cut a release**: run `make changelog-release VERSION=x.y.z`, commit the updated `CHANGELOG.md`, tag `vX.Y.Z`, and push the tag.

More details: `docs/releasing.md`
