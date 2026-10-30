#!/usr/bin/env bash
# PII-guard tests, then skin checks (CSS structure, logo URL contract, asset hygiene, local-css build).
set -euo pipefail
cd "$(dirname "$0")/.."
./tests/unit/test_pii_scan.sh
./tests/integration/skin_check.sh
