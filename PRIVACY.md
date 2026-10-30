# Privacy & Data Handling

This repository contains a CSS skin, a logo, an install script for an Unraid server, and a static preview page.

## What it touches
| Class | Examples | Handling |
|---|---|---|
| Skin CSS | `src/emerald-void.css` | static styling; no scripts, no storage |
| Logo request | the hosted logo URL | the viewer's browser requests one image from `raw.githubusercontent.com`; GitHub sees that request under its own terms. The offline build (`make local-css`) makes no request |
| Install script | `scripts/install-emerald-void.sh` | runs on the owner's own server; edits the ThemeUI plugin files there; sends nothing anywhere |
| Telemetry | none | no analytics or tracking |

## Rules
- **No PII in the repository:** no personal email addresses, phone numbers, addresses, server or host names, IPs, account numbers, or credentials. `scripts/pii-scan.sh` enforces this (hooks + CI); reviewed false positives live in `config/pii-allowlist.txt`.
- Images are metadata-free (checked by `make test`).
