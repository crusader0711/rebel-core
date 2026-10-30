# Contributing to rebel-core

**Tier:** T1 (public). Contributions welcome via pull request.

## Ground rules (non-negotiable)
- No credentials, keys, tokens, server names, hostnames, IPs or personal data. `make lint` runs the PII guard; CI repeats it.
- Images must carry no metadata; re-encode exports before committing (`make test` enforces it).
- Keep the CSS logo URL and `tests/fixtures/logo-url.txt` identical.
- Do not add Unraid paths you cannot verify; cite the source or label them unverified.

## Workflow
- Trunk-based: `main` protected; branches `feat/<slug>`, `fix/<slug>`, `docs/<slug>`; squash-merge.
- Conventional Commits (`feat:`, `fix:`, `docs:`, `test:`, `chore:`, `ci:`).
- `make setup` once (installs hooks); `make lint test` before every push.
- Architecture decisions → new ADR in `docs/decisions/`; accepted ADRs are immutable (supersede, don't edit).

## DCO
Sign off commits (`git commit -s`) to certify you have the right to contribute under the LICENSE.

## Release artifacts
`dist/` is gitignored. `RELEASE_MANIFEST.json` lists the `dist/` artifacts; the committed `SHA256SUMS` covers the manifest and passes `sha256sum -c SHA256SUMS` on a clean clone. Artifacts are deterministic (sorted, fixed mtime); their hashes ship in `dist/SHA256SUMS` — attach both to the GitHub release.
