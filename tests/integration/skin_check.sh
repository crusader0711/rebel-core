#!/usr/bin/env bash
# Skin checks: CSS structure, canonical hosted logo URL, asset hygiene (real PNG, no metadata), offline build, install script syntax.
set -uo pipefail
cd "$(dirname "$0")/../.." || exit 1
FAIL=0
ok(){ if eval "$2"; then echo "  PASS: $1"; else echo "  FAIL: $1"; FAIL=1; fi }
EXPECT="$(cat tests/fixtures/logo-url.txt)"
export EXPECT
ok "css braces balanced, no external @import" "python3 - <<'PY'
import re, sys
s = open('src/emerald-void.css', encoding='utf-8').read()
s = re.sub(r'/\*.*?\*/', '', s, flags=re.S)
sys.exit(0 if s.count('{') == s.count('}') and not re.search(r'@import', s) else 1)
PY"
ok "css logo URL equals the canonical hosted URL" "python3 - <<'PY'
import os, re, sys
s = open('src/emerald-void.css', encoding='utf-8').read()
m = re.findall(r'--rc-logo:\s*url\(\"([^\"]+)\"\)', s)
sys.exit(0 if m == [os.environ['EXPECT']] else 1)
PY"
LOGO_PATH="${EXPECT##*/main/}"
ok "logo path in URL exists in the repo" "test -f \"$LOGO_PATH\""
ok "logo is a real PNG with alpha" "python3 - <<'PY'
import struct, sys
d = open('assets/rebel-core-logo.png', 'rb').read()
sys.exit(0 if d[:8] == b'\x89PNG\r\n\x1a\n' and d[25] == 6 else 1)
PY"
ok "no metadata chunks in images (EXIF/XMP/text)" "python3 - <<'PY'
import re, sys
bad = 0
for p in ('assets/rebel-core-logo.png', 'assets/rebel-core-banner.jpg'):
    d = open(p, 'rb').read()
    if b'Exif\x00' in d[:300000] or b'<x:xmpmeta' in d or re.search(rb'tEXt|iTXt|zTXt|eXIf', d[:200000]): bad = 1
sys.exit(bad)
PY"
ok "install script parses (bash -n)" "bash -n scripts/install-emerald-void.sh"
offline_ok(){ ( VERSION=t ./scripts/build-local-css.sh >/dev/null && grep -q 'data:image/png;base64,' dist/emerald-void.local.css && ! grep -q 'raw.githubusercontent.com' dist/emerald-void.local.css ); r=$?; rm -rf dist; return $r; }
ok "offline build embeds data: URI and no hosted URL" "offline_ok"
[ $FAIL -eq 0 ] && echo "skin-check: ALL CHECKS PASS" || echo "skin-check: FAILED"
exit $FAIL
