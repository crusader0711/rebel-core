# AGENTS.md — rebel-core (source of truth for AI agents)

**Tier:** T1 · **Template:** Canonical Repository Structure Template v1.0 · **Repo tags:** SemVer (pre-1.0: interface unstable)

An Unraid WebUI skin ("Emerald Void", for ThemeUI on Unraid 7.2+) plus the REBEL CORE logo and its hosted URL.
Automation drafts and verifies; **the owner merges, tags and publishes — every time.**

## Layout (where things are)
| Path | What |
|---|---|
| `src/emerald-void.css` | the skin; section 4 holds the logo (`--rc-logo`) |
| `assets/` | `rebel-core-logo.png` (transparent, hosted/embedded), `rebel-core-banner.jpg` (README banner) |
| `scripts/` | `install-emerald-void.sh` (runs on the server), `build-local-css.sh`, lint/test/build/release, `pii-scan.sh` |
| `examples/preview/` | static HTML mock of the palette (links `src/emerald-void.css`) |
| `docs/` | `architecture.md`, `decisions/`, `runbooks/` (release, apply in Unraid) |
| `hooks/`, `config/` | git hooks, PII allow-list |
| `tests/` | `unit/` (PII-guard tests), `integration/skin_check.sh`, `fixtures/logo-url.txt` (canonical logo URL) |

## Commands that actually work
```
make setup       # install git hooks (core.hooksPath=hooks/)
make lint        # PII scan, skin checks, shellcheck (if installed)
make test        # PII-guard tests + skin checks
make local-css   # dist/emerald-void.local.css (logo as data: URI)
make build       # deterministic dist/ artifacts
make release VERSION=vX.Y.Z   # RELEASE_MANIFEST.json + SHA256SUMS
make clean
```

## Rules
- The hosted logo URL in the CSS must equal `tests/fixtures/logo-url.txt`. Renaming/moving the logo means changing both and re-running `make test`.
- Do not invent Unraid file paths or web paths. Cite only what the original install docs or a plugin's own documentation state, and label unverified ones.
- Images must carry no metadata (EXIF/XMP/text chunks); `make test` enforces it. Re-encode before adding any photo or export.
- No credentials, tokens, keys, server names, hostnames, IPs or personal data in any file. Example values use RFC 5737 ranges.
- ## PII guard
  Every commit/push is scanned by `scripts/pii-scan.sh` (hooks + CI). Hits are removed or, if reviewed false positives, added to `config/pii-allowlist.txt`. An owner deny-list kept **outside** the repo can be supplied via `PII_DENYLIST=/path` (never commit it).
