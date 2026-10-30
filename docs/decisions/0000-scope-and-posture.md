# docs/decisions/0000-scope-and-posture.md
Date: 2026-10-30   Status: accepted

## Context
A personal Unraid skin needs a stable home, a logo URL a browser can load, and a version history.

## Decision
One small repository holds the skin, the logo and the checks. The skin is pure CSS targeting ThemeUI; the logo is referenced by one variable. The owner alone merges, tags and publishes.

## Consequences
No dependency on any server path to show the logo. Wrong for anything needing scripts or server-side state.
