# fstyp 0.1 (binary only)
 - Package: [master/make/fstyp/](https://github.com/Freetz-NG/freetz-ng/tree/master/make/fstyp/)

**fstyp** erlaubt es einem Anwender, den Dateisystem-Typ eines
eingebundenen oder auch nicht eingebundenen Dateisystems zu ermitteln.

In Freetz wird fstyp von freetzmount genutzt, um das Dateisystem zu
erkennen und korrekt zu mounten.
Hinweis: Bei Verwendung der Option "mount-by-Label" wird das ganze
durch **blkid** erledigt (und fstyp wird hierfür überflüssig). Hat aber
den Nachteil, dass das Image etliche Kilobyte größer wird.

