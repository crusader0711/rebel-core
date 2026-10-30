# Security Policy

## Supported versions
| Version | Supported |
|---|---|
| 0.x (main) | ✅ |

## Reporting a vulnerability
Please **do not open a public issue**. Report privately through GitHub's private vulnerability reporting (repository **Security** tab → **Report a vulnerability**). Include reproduction steps and impact.
Acknowledgement within 72 h; coordinated disclosure window 90 days.

## Scope notes
- The skin is plain CSS: no scripts, no credentials, no server-side state. None may be added.
- `scripts/install-emerald-void.sh` runs as root on the owner's Unraid server and patches ThemeUI's files in RAM; read it before running it. It makes no network calls.
