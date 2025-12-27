#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FIX="${1:-}"

err() {
  printf "ERROR: %s\n" "$1" >&2
}

if [[ "${FIX}" != "" && "${FIX}" != "--fix" ]]; then
  err "Unknown argument: ${FIX} (expected: --fix)"
  exit 2
fi

if ! command -v node >/dev/null 2>&1; then
  err "node is required for markdown linting. Install Node.js, then re-run: make md-lint"
  exit 1
fi

# Pinned for deterministic behavior across dev/CI.
MDL_VERSION="0.14.0"

cd "${REPO_ROOT}"

if [[ "${FIX}" == "--fix" ]]; then
  npx --yes "markdownlint-cli2@${MDL_VERSION}" --fix
else
  npx --yes "markdownlint-cli2@${MDL_VERSION}"
fi


