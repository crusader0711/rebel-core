#!/usr/bin/env bash
# Build deterministic artifacts into dist/ (sorted names, fixed mtime/owner, no gzip timestamp).
set -euo pipefail
cd "$(dirname "$0")/.."
VERSION="${VERSION:-$(git describe --tags --always 2>/dev/null || echo v0.0.0-dev)}"
rm -rf dist && mkdir -p dist
./scripts/build-local-css.sh
mktar() { out="$1"; shift; tar --sort=name --mtime='@0' --owner=0 --group=0 --numeric-owner -cf - "$@" | gzip -n -9 > "$out"; }
mktar "dist/rebel-core-skin-${VERSION}.tar.gz" src assets scripts/install-emerald-void.sh
mktar "dist/rebel-core-docs-${VERSION}.tar.gz" docs README.md
cp dist/emerald-void.local.css "dist/emerald-void.local-${VERSION}.css"
rm dist/emerald-void.local.css
echo "[build] $(ls dist | wc -l) artifacts in dist/"
