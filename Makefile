.PHONY: help ci openapi-validate changelog-verify changelog-release md-lint md-fix release-help

OPENAPI_SPEC ?= openapi/openapi.yaml

help:
	@echo "CI / verification:"
	@echo "  make ci"
	@echo "  make openapi-validate"
	@echo "  make md-lint"
	@echo ""
	@echo "Formatting helpers:"
	@echo "  make md-fix"
	@echo ""
	@echo "Changelog / releasing:"
	@echo "  make changelog-verify"
	@echo "  make changelog-release VERSION=0.1.0"
	@echo "Then commit, tag v0.1.0, and push the tag."

ci: changelog-verify openapi-validate md-lint

openapi-validate:
	@./scripts/validate_openapi.sh "$(OPENAPI_SPEC)"

changelog-verify:
	@./scripts/verify_changelog.sh

changelog-release:
	@if [ -z "$(VERSION)" ]; then \
		echo "ERROR: VERSION is required. Example: make changelog-release VERSION=0.1.0" >&2; \
		exit 2; \
	fi
	@./scripts/release_changelog.sh "$(VERSION)"

md-lint:
	@./scripts/lint_markdown.sh

md-fix:
	@./scripts/lint_markdown.sh --fix

release-help:
	@$(MAKE) help


