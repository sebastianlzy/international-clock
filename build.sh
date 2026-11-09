#!/bin/sh
set -eu
cd "$(dirname "$0")"

app="International Clock.app"
mkdir -p "$app/Contents/MacOS"
module_cache=$(mktemp -d "${TMPDIR:-/tmp}/singapore-clock.XXXXXX")
trap 'rm -rf "$module_cache"' EXIT
architecture=$(uname -m)
swiftc -O -target "$architecture-apple-macos13.0" -module-cache-path "$module_cache" SingaporeClock.swift -o "$app/Contents/MacOS/SingaporeClock"

cat > "$app/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key><string>SingaporeClock</string>
    <key>CFBundleIdentifier</key><string>local.singapore-clock</string>
    <key>CFBundleName</key><string>International Clock</string>
    <key>CFBundlePackageType</key><string>APPL</string>
    <key>CFBundleVersion</key><string>1</string>
    <key>LSUIElement</key><true/>
</dict>
</plist>
PLIST

xattr -dr com.apple.FinderInfo "$app" 2>/dev/null || true
codesign --force --sign - "$app"
