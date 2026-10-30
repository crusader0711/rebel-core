# Architecture

rebel-core is a small repository: one **skin** (CSS), one **logo** (hosted + embeddable), one optional **installer**, one **preview**.

```
src/emerald-void.css ──paste or drop-in──► ThemeUI on Unraid 7.2+
        │  --rc-logo
        ├── hosted:  https://raw.githubusercontent.com/crusader0711/rebel-core/main/assets/rebel-core-logo.png
        └── offline: make local-css → data: URI inside dist/emerald-void.local.css
```

- **Skin:** section 1 mirrors ThemeUI's variable contract; section 2 is the atmosphere layer; section 3 sets the Unraid API web-component tokens; section 4 is the logo watermark.
- **Logo:** one variable, `--rc-logo`. The watermark is `body::before`, fixed, non-interactive, hidden in print. It does not depend on any Unraid element selector.
- **State:** none. No storage, no scripts.
- **Verification:** `tests/integration/skin_check.sh` (CSS structure, canonical URL, asset hygiene, offline build) and `tests/unit/test_pii_scan.sh`.
- **Integrity:** deterministic release artifacts, `RELEASE_MANIFEST.json`, `SHA256SUMS` (see `docs/runbooks/00-release.md`).
