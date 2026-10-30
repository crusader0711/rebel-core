.DEFAULT_GOAL := help
SHELL := /usr/bin/env bash

help:        ## List available targets
	@grep -E '^[a-z-]+:.*##' $(MAKEFILE_LIST) | sed -E 's/:.*##/\t/' | sort

setup:       ## Install git hooks (core.hooksPath=hooks/)
	./scripts/setup.sh

lint:        ## PII scan, CSS/asset checks, shellcheck
	./scripts/lint.sh

test:        ## PII-guard tests + skin checks
	./scripts/test.sh

pii-scan:    ## PII guard: generic patterns + optional PII_DENYLIST (outside the repo)
	./scripts/pii-scan.sh

local-css:   ## Offline skin: dist/emerald-void.local.css with the logo embedded (no network)
	./scripts/build-local-css.sh

build:       ## Deterministic dist/ artifacts
	./scripts/build.sh

release:     ## RELEASE_MANIFEST.json + SHA256SUMS (usage: make release VERSION=vX.Y.Z)
	./scripts/release.sh $(VERSION)

clean:       ## Remove build artifacts and caches
	rm -rf dist

.PHONY: help setup lint test pii-scan local-css build release clean
