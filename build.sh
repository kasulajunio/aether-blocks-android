#!/usr/bin/env bash
set -euxo pipefail
SDK=${ANDROID_HOME:-$ANDROID_SDK_ROOT}
BT="$SDK/build-tools/35.0.0"
JAR="$SDK/platforms/android-35/android.jar"
mkdir -p out/classes out/tests out/dex
javac -d out/tests src/com/fabio/aether/Rules.java tests/RulesTest.java
java -cp out/tests RulesTest | tee out/test-results.txt
javac -source 8 -target 8 -classpath "$JAR" -d out/classes src/com/fabio/aether/*.java
"$BT/aapt" package -f -M AndroidManifest.xml -I "$JAR" -F out/unsigned.apk
"$BT/d8" --lib "$JAR" --min-api 23 --output out/dex $(find out/classes -name "*.class")
(cd out/dex && zip -j ../unsigned.apk classes.dex)
"$BT/zipalign" -f 4 out/unsigned.apk out/aligned.apk
keytool -genkeypair -keystore out/demo.jks -storepass android -keypass android -alias demo -dname "CN=Aether Blocks Prototype" -keyalg RSA -keysize 2048 -validity 3650
"$BT/apksigner" sign --ks out/demo.jks --ks-pass pass:android --out out/Aether-Blocks-v0.1.apk out/aligned.apk
"$BT/apksigner" verify --verbose out/Aether-Blocks-v0.1.apk | tee out/apk-verification.txt
"$BT/aapt" dump badging out/Aether-Blocks-v0.1.apk > out/apk-info.txt
sha256sum out/Aether-Blocks-v0.1.apk > out/SHA256SUMS.txt
