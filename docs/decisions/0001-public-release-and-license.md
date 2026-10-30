# docs/decisions/0001-public-release-and-license.md
Date: 2026-10-30   Status: proposed

## Decision
Publish as a public repository under the MIT license (template §4: MIT for public) so the logo can be served from `raw.githubusercontent.com`, which only serves public files without authentication. Server names, hostnames, IPs and personal data are never carried. The PII guard (`scripts/pii-scan.sh`, hooks, CI) is a mandatory control; any owner deny-list stays outside the repo. History is a single orphan commit.

## Consequences
Anything not safe for the public never enters the tree. A private repository would not give a usable logo URL; switching to private later breaks the hosted URL (use the offline build instead).
