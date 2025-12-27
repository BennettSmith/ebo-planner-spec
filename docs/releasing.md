# Releasing

## Updating the changelog in PRs

- Add an entry to `CHANGELOG.md` under **`## [Unreleased]`**.
- Put it under the most appropriate section:
  - `### Added`, `### Changed`, `### Deprecated`, `### Removed`, `### Fixed`, `### Security`
- Keep entries short and user-impact focused (what changed and why it matters).

## Cutting a release

1. Ensure `CHANGELOG.md` has entries under `## [Unreleased]`.
2. Cut the release section (moves Unreleased entries into a dated version section):

```bash
make changelog-release VERSION=x.y.z
```

3. Commit the changelog update:

```bash
git add CHANGELOG.md
git commit -m "chore(release): vX.Y.Z"
```

4. Create and push the git tag:

```bash
git tag vX.Y.Z
git push --tags
```

## SemVer (very short)

- **MAJOR**: breaking changes
- **MINOR**: backwards-compatible features
- **PATCH**: backwards-compatible fixes
