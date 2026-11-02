from pathlib import Path
p=Path("src/com/fabio/aether/MainActivity.java")
s=p.read_text().replace("e.putString(\"map\",s.toString());for(Mob","e.putString(\"map\",s.toString());e.putFloat(\"bossHp\",-1);for(Mob")
p.write_text(s)
p=Path("src/com/fabio/aether/Rules.java")
p.write_text(p.read_text().replace("Math.floorMod(x*7349+y*9157+x*y*31,100)","(x*7349+y*9157+x*y*31)%100"))
p=Path("AndroidManifest.xml")
s=p.read_text().replace("</manifest>","<instrumentation android:name=\".GameTest\" android:targetPackage=\"com.fabio.aether\"/></manifest>")
p.write_text(s)
