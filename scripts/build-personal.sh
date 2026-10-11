#!/bin/bash
set -euo pipefail
TASK_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$TASK_ROOT/build/personal"
APP_DIR="$BUILD_DIR/Clicky Personal.app"
mkdir -p "$APP_DIR/Contents/MacOS" "$APP_DIR/Contents/Resources" "$BUILD_DIR/module-cache"
python3 - "$TASK_ROOT" "$APP_DIR" <<'PY'
import plistlib, sys
from pathlib import Path
root, app = map(Path, sys.argv[1:])
info = {
 'CFBundleIdentifier':'com.osiris.clickypersonal',
 'CFBundleName':'Clicky Personal', 'CFBundleDisplayName':'Clicky Personal',
 'CFBundleExecutable':'ClickyPersonal', 'CFBundlePackageType':'APPL',
 'CFBundleShortVersionString':'0.1.0', 'CFBundleVersion':'1',
 'LSMinimumSystemVersion':'14.2', 'LSUIElement':True,
 'CFBundleIconFile':'AppIcon', 'NSHighResolutionCapable':True,
 'VoiceTranscriptionProvider':'apple', 'PersonalSourcePath':str(root),
 'NSMicrophoneUsageDescription':'Clicky Personal records your question while you hold Shift + Control + Space.',
 'NSSpeechRecognitionUsageDescription':'Clicky Personal uses Mac speech recognition to transcribe your question.',
 'NSScreenCaptureUsageDescription':'Clicky Personal captures your screens when you ask for screen-aware help, and sends those images to your signed-in Codex account.'
}
(app/'Contents/Info.plist').write_bytes(plistlib.dumps(info))
PY
swiftc -swift-version 5 -parse-as-library -whole-module-optimization -O \
  -target arm64-apple-macos14.2 \
  -module-cache-path "$BUILD_DIR/module-cache" \
  "$TASK_ROOT"/leanring-buddy/*.swift \
  -o "$APP_DIR/Contents/MacOS/ClickyPersonal"
cp "$TASK_ROOT/leanring-buddy/Assets.xcassets/AppIcon.appiconset/512-mac.png" "$APP_DIR/Contents/Resources/AppIcon.png"
for resource in "$TASK_ROOT"/leanring-buddy/*.mp3; do cp "$resource" "$APP_DIR/Contents/Resources/"; done
codesign --force --sign - --identifier com.osiris.clickypersonal "$APP_DIR"
codesign --verify --deep --strict "$APP_DIR"
printf '%s\n' "$APP_DIR"
