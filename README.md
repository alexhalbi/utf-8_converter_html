Powershell HTML to UTF-8 Converter
=======
PowerShell script which automatically converts HTML files to UTF-8 with BOM with automatic change of encoding meta tag (```<META http-equiv="content-type" content="text/html; charset=UTF-8">```), if tag allready exists. Each File will be converted wich has a .*htm* ending (* is for any alphanumeric Symbol). If the Script is not able to determine the Doctype with BOM then all special characters which could be an error will be replaced with the HTML special characters.

Usage
-------
- Set ```$source``` and ```$destination``` folder in code
- Save PowerShell File as UTF-8 with BOM (Notepad++) to execute
- Run with right click "Execute with PowerShell"

Debug output
-------
Remove ```#``` before the ```WriteHost``` lines

Add new characters to replace
-------
To add another Character to replace just add it to the ```$characterMapReplace``` List :
```$characterMapReplace.example = "ReplaceMe"```
and to the ```$characterMapChar``` List with the same reference:
```$characterMapChar.example = "ImReplaced"```

Powershell HTML zu UTF-8 Konverter
=======
PowerShell Skript zum automatischen konvertieren von HTML Files in UTF-8 mit BOM mit automatischer Änderung des Meta Tags (```<META http-equiv="content-type" content="text/html; charset=UTF-8">```), wenn das Tag schon im File existiert. Jede Datei mit einer ```.*htm*``` Endung wird konvertiert (* steht für jedes alphanumerische Symbol).

Verwendung
-------
- ```$source``` und ```$destination``` Ordnername im Code angeben
- PowerShell File als UTF-8 mit BOM Speichern [(Notepad++)](https://notepad-plus-plus.org/)
- Ausführen: Rechtsklick mit Powershell ausführen

Debug output
-------
```#``` vor den ```WriteHost``` Zeilen entfernen.

Zeichen zum ersetzen hinzufügen
-------
Zum hinzufügen anderer Zeichen welche ersetzt werden sollen, einen eintrag zur ```$characterMapReplace``` Liste hinzufügen:
```$characterMapReplace.example = "ReplaceMe"```
Und auch zur ```$characterMapChar``` Liste mit der selben Referenz:
```$characterMapChar.example = "ImReplaced"```

Thanks
=======
- Thank to [Frank Richard](https://www.blogger.com/profile/09790670975486771457) for his [code](http://franckrichard.blogspot.co.at/2010/08/powershell-get-encoding-file-type.html) to determine file encoding with BOM.
- [UTF-8 Encoding Debugging Chart](http://www.i18nqa.com/debug/utf8-debug.html)
- [SelfHTML HTML/Zeichenreferenz](https://wiki.selfhtml.org/wiki/Referenz:HTML/Zeichenreferenz#Latin1-Erg.C3.A4nzung)