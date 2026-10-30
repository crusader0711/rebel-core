---
name: apply-rebel-core
description: Apply or modify the Emerald Void skin and its REBEL CORE logo — keep the logo URL, the CSS and the test fixture in sync, and verify with make test.
---
1. Read `AGENTS.md` (rules) and `docs/runbooks/01-apply-in-unraid.md`.
2. Edit `src/emerald-void.css`; the logo is only ever set through `--rc-logo` (section 4).
3. If the logo file or URL changes, update `tests/fixtures/logo-url.txt` and `README.md` in the same change.
4. Verify: `make lint test`; for the offline variant `make local-css`.
5. Never claim an Unraid path works unless the source is cited; hand off merge/tag/publish to the owner.
