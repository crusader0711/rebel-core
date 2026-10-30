# Changelog

All notable changes to this repository are documented here. Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); repo tags follow SemVer.

## [Unreleased]

## [0.1.1] — 2026-10-30
### Changed
- Skin (`src/emerald-void.css`): revised section 3 for Unraid 7.2's Update OS / Connect / API pages (`@unraid/ui`, Tailwind v4). The Tailwind `--color-*` palette scales (gray/neutral/zinc/slate, yellow/amber/lime, green/emerald/primary, blue/sky/cyan/teal/indigo/purple, pink/red/unraid-red/unraid-green) and the brand tokens are now remapped directly; shadcn HSL and Nuxt UI semantic tokens extended; class-level fallbacks and a 1px emerald ring on badges and pills added; optional UNRAID wordmark tint (3.4). Section 1 borders lightened (`#1c3a29` → `#214f37`, input border `#2f6a47` → `#3a7d55`).
- Preview (`examples/preview/emerald-void-preview.html`): new row of Update OS badges and pills to show the token remap.
- Version bump to 0.1.1; `RELEASE_MANIFEST.json` and `SHA256SUMS` regenerated.
### Unchanged
- Section 4 (logo watermark), the hosted logo URL, the image files and the install script.

## [0.1.0] — 2026-10-30
### Added
- Emerald Void skin (`src/emerald-void.css`) for Unraid 7.2+ via ThemeUI; optional install script; static palette preview.
- REBEL CORE logo (transparent PNG, metadata-free) and README banner; logo watermark (section 4 of the CSS) loaded from the hosted URL via `--rc-logo`.
- Offline build `make local-css` embedding the logo as a `data:` URI.
- Canonical repository scaffold (tier T1): governance files, Makefile verbs, PII guard, hooks, CI, skin checks, release manifest + SHA256SUMS.
### Changed
- Skin source relocated to `src/`, install script to `scripts/`, preview to `examples/preview/` (preview now links the CSS instead of inlining a copy); license holder set to the project's contributors.
