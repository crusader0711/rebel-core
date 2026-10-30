# Runbook 01 — Apply the skin in Unraid

Source of the paths below: the original install notes for this skin and ThemeUI's behavior as described there. Anything not verified on a live server is marked.

## A. Custom CSS Override (no patching)
1. Install ThemeUI: Plugins › Install Plugin → `https://raw.githubusercontent.com/onyxhq-dev/ThemeUI/master/themeui.plg`.
2. Settings › Utilities › ThemeUI → **Enable = Yes**, **Theme = Black and White**, **Design = Modern**.
3. Paste all of `src/emerald-void.css` (or the offline `dist/emerald-void.local.css`) into **Custom CSS Override** → **Apply**.
4. Hard-refresh the browser. The logo watermark shows bottom-right. If it does not, open the browser's developer tools › Network and check the logo request.

## B. Selectable theme (survives reboots only if re-registered)
ThemeUI's plugin directory lives in RAM, so the theme must be re-registered after reboots and plugin updates.
1. Copy `src/emerald-void.css` and `scripts/install-emerald-void.sh` to the ThemeUI custom folder on the flash drive, `/boot/config/plugins/themeui/custom/`, then run `bash /boot/config/plugins/themeui/custom/install-emerald-void.sh`. The script is idempotent and checks the patched page parses (`php -l`) when PHP is available.
2. Settings › Utilities › ThemeUI → **Theme = Emerald Void** → **Apply**.
3. To persist: add the same `bash …` line to `/boot/config/go`, or run it from a "First Array Start" User Scripts job.

## C. Logo options
| Route | How | Status |
|---|---|---|
| Hosted | default `--rc-logo` URL (needs the repo public) | unverified until first push |
| Offline | `make local-css`, paste `dist/emerald-void.local.css` | self-contained; larger file (size limit of the override box not tested) |
| Flash copy | keep `rebel-core-logo.png` beside the theme files for safekeeping | not web-reachable; no web path verified |
| Other plugin | see README § "Local fallback" | that plugin's own docs; unverified here |
