#!/usr/bin/env bash
set -e

# نزّل Flutter (stable) وأضفه للـ PATH
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PWD/flutter/bin:$PATH"

flutter --version
flutter config --enable-web
flutter pub get

# إبني نسخة الويب
flutter build web --release
chmod +x vercel-build.sh
