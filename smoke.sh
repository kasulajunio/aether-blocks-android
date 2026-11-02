#!/usr/bin/env bash
set -euxo pipefail
adb install -r out/Aether-Blocks-v0.1.apk
adb shell am instrument -w com.fabio.aether/.GameTest | tee out/android-tests.txt
grep -q "OK: 13 testes" out/android-tests.txt
adb shell am force-stop com.fabio.aether
adb logcat -c
adb shell am start -W -n com.fabio.aether/.MainActivity
sleep 3
adb shell input tap 500 500
sleep 3
adb shell pidof com.fabio.aether
adb exec-out screencap -p > out/screenshot.png
if adb logcat -d -s AndroidRuntime:E | grep -q "FATAL EXCEPTION"; then exit 1; fi
