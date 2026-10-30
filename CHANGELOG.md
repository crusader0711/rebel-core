# Changelog

All notable changes to this repository are documented here. Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); repo tags follow SemVer.

## [Unreleased]

## [0.1.0] — 2026-10-30
### Added
- Emerald Void skin (`src/emerald-void.css`) for Unraid 7.2+ via ThemeUI; optional install script; static palette preview.
- REBEL CORE logo (transparent PNG, metadata-free) and README banner; logo watermark (section 4 of the CSS) loaded from the hosted URL via `--rc-logo`.
- Offline build `make local-css` embedding the logo as a `data:` URI.
- Canonical repository scaffold (tier T1): governance files, Makefile verbs, PII guard, hooks, CI, skin checks, release manifest + SHA256SUMS.
### Changed
- Skin source relocated to `src/`, install script to `scripts/`, preview to `examples/preview/` (preview now links the CSS instead of inlining a copy); license holder set to the project's contributors.
