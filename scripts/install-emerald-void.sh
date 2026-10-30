#!/bin/bash
# ============================================================================
# install-emerald-void.sh — register "Emerald Void" as a selectable ThemeUI theme
# ----------------------------------------------------------------------------
# WHY THIS EXISTS
#   ThemeUI's settings page only lists a hard-coded whitelist ($valid_themes),
#   and /usr/local/emhttp/plugins/ThemeUI lives in RAM (rebuilt from the plugin
#   .txz on every boot and every plugin update). So a drop-in theme needs:
#     1. the CSS copied into the plugin's themes/ dir,
#     2. the whitelist + swatch metadata patched in ThemeUI.page,
#     3. login-theme.sh re-run so the login page gets the theme inlined,
#   and it has to be re-applied at boot. Idempotent — safe to run repeatedly.
#
# USAGE
#   1. Put emerald-void.css and this script on the flash:
#        /boot/config/plugins/themeui/custom/emerald-void.css
#        /boot/config/plugins/themeui/custom/install-emerald-void.sh
#   2. bash /boot/config/plugins/themeui/custom/install-emerald-void.sh
#   3. Settings > Utilities > ThemeUI → pick "Emerald Void" → Apply.
#   4. Make it survive reboots — EITHER add to /boot/config/go:
#        bash /boot/config/plugins/themeui/custom/install-emerald-void.sh
#      OR run it from User Scripts at "First Array Start".
#
# If you'd rather not patch the plugin at all, skip this script entirely and
# paste emerald-void.css into ThemeUI's Custom CSS Override instead (see notes).
# ============================================================================
set -euo pipefail

THEME_ID="emerald-void"
THEME_LABEL="Emerald Void"
# swatches shown in the ThemeUI picker: bg, text, accent-2 (orange slot), red, accent-1
THEME_SWATCHES='"#050807","#c9efd6","#b4ff3c","#ff2a4d","#00ff88"'

FLASH_DIR="/boot/config/plugins/themeui/custom"
SRC_CSS="${FLASH_DIR}/${THEME_ID}.css"
PLUGIN_DIR="/usr/local/emhttp/plugins/ThemeUI"
PAGE="${PLUGIN_DIR}/ThemeUI.page"
LOGIN_SH="/boot/config/plugins/themeui/login-theme.sh"

log(){ echo "[${THEME_ID}] $*"; }

[[ -d "$PLUGIN_DIR" ]] || { log "ThemeUI plugin dir not found at $PLUGIN_DIR — is ThemeUI installed?"; exit 1; }
[[ -f "$SRC_CSS"   ]] || { log "theme CSS not found at $SRC_CSS"; exit 1; }
[[ -f "$PAGE"      ]] || { log "ThemeUI.page not found — plugin layout changed?"; exit 1; }

# 1. CSS into the live plugin
install -m 0644 "$SRC_CSS" "${PLUGIN_DIR}/themes/${THEME_ID}.css"
log "copied theme CSS into plugin themes/"

# 2a. whitelist
if ! grep -q "\"${THEME_ID}\"" "$PAGE"; then
    sed -i "s/\(\$valid_themes *= *\[\"default\"\)/\1,\"${THEME_ID}\"/" "$PAGE"
    log "patched \$valid_themes"
else
    log "\$valid_themes already contains ${THEME_ID}"
fi

# 2b. picker label + swatches (insert right after the \"default\" meta row)
if ! grep -q "\"${THEME_ID}\" *=> *\[\"label\"" "$PAGE"; then
    sed -i "/\"default\" *=> *\[\"label\"=>\"Default (Unraid)\"/a\\    \"${THEME_ID}\" => [\"label\"=>\"${THEME_LABEL}\", \"colors\"=>[${THEME_SWATCHES}]]," "$PAGE"
    log "patched \$theme_meta"
else
    log "\$theme_meta already contains ${THEME_ID}"
fi

# sanity: PHP must still parse
if command -v php >/dev/null 2>&1; then
    php -l "$PAGE" >/dev/null || { log "ThemeUI.page failed php -l after patch — restore plugin and report"; exit 1; }
fi

# 3. If this theme is the active one, re-inline it into the login page
if grep -q "THEME=\"${THEME_ID}\"" /boot/config/plugins/themeui/themeui.cfg 2>/dev/null && [[ -x "$LOGIN_SH" ]]; then
    bash "$LOGIN_SH" && log "login page re-themed"
fi

log "done. Settings > Utilities > ThemeUI → select '${THEME_LABEL}' → Apply."
