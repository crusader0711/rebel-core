#!/usr/bin/env bash
# Offline variant of the skin: replaces the hosted logo URL with a data: URI so the CSS needs no network
# and no server-side file path. Output: dist/emerald-void.local.css (deterministic; same input -> same bytes).
set -euo pipefail
cd "$(dirname "$0")/.."
CSS=src/emerald-void.css
PNG=assets/rebel-core-logo.png
OUT=dist/emerald-void.local.css
mkdir -p dist
python3 - "$CSS" "$PNG" "$OUT" <<'PY'
import base64, re, sys
css_p, png_p, out_p = sys.argv[1:]
css = open(css_p, encoding="utf-8").read()
b64 = base64.b64encode(open(png_p, "rb").read()).decode("ascii")
pat = re.compile(r'--rc-logo:\s*url\("https://raw\.githubusercontent\.com/[^"]+"\);')
if len(pat.findall(css)) != 1:
    sys.exit("build-local-css: expected exactly one hosted --rc-logo declaration")
css = pat.sub('--rc-logo: url("data:image/png;base64,%s");' % b64, css)
open(out_p, "w", encoding="utf-8", newline="\n").write(css)
print("[local-css] wrote %s (%d bytes)" % (out_p, len(css.encode())))
PY
