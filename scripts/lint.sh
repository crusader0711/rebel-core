#!/usr/bin/env bash
# PII scan, CSS sanity (brace balance, hosted logo URL, no external @import), shellcheck if installed.
set -euo pipefail
cd "$(dirname "$0")/.."
rc=0
./scripts/pii-scan.sh || rc=1
./tests/integration/skin_check.sh || rc=1
if command -v shellcheck >/dev/null; then shellcheck -S warning scripts/*.sh hooks/* tests/unit/*.sh tests/integration/*.sh || rc=1; fi
exit $rc
