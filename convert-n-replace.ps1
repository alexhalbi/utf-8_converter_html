#Alexander Halbarth ET10/15 03.02.2015
#PowerShell Script to convert HTML Files to UTF-8 wirth BOM
#CAUTION: This Script has to be saved as UTF-8 with BOM to be executable (use Notepad++ to convert)!!!
#PowerShell Skript zum konvertieren von HTML Dateien in UTF-8 mit BOM
#ACHTUNG: Das File muss als UTF-8 mit BOM gespeichert werden!! Kann in Notepad++ konvertiert werden

$sw = [Diagnostics.Stopwatch]::StartNew()
$Utf8Encoding = New-Object System.Text.UTF8Encoding($True)
$source = "C:\Users\Alexander\Desktop\TEST\path"			#no trailing \ !!! am Ende ein KEIN \ !!!
$destination = "C:\Users\Alexander\Desktop\TEST\output"		#no trailing \ !!! am Ende ein KEIN \ !!!

#Characters wich should be replaced (Regex are accepted!)
#Buchstaben welche ersetzt werden sollen: (Regex werden akzeptiert!)
$characterMapReplace = New-Object system.collections.hashtable
$characterMapReplace.AnfZU = 'â€ž'			#Anführungszeichen unten
$characterMapReplace.AnfZOV = 'â€[^žœš˜°™“”]'	#Anführungszeichen oben verkehrt
$characterMapReplace.AnfZO = 'â€œ'			#Anführungszeichen oben
$characterMapReplace.BL = 'â€“'				#Bindestrich lang
$characterMapReplace.BL2 = 'â€”'			#Bindestrich lang
$characterMapReplace.Euro = "â‚¬"
$characterMapReplace.Bstr = 'â€š'			#Beistrich
$characterMapReplace.Dacherl = 'Ë†'			#Dacherl
$characterMapReplace.Promille = 'â€°'		#Promille
$characterMapReplace.Apstr1 = 'â€˜'			#Apostroph1&lsquo;
$characterMapReplace.Apstr2 = 'â€™'			#Apostroph2&rsquo;
$characterMapReplace.TM = 'â„¢'
$characterMapReplace.Pfund = 'Â£'
$characterMapReplace.Yen = 'Â¥'
$characterMapReplace.Paragr = 'Â§'
$characterMapReplace.CircC = 'Â©'
$characterMapReplace.hochA = 'Âª'
$characterMapReplace.hochO = 'Âº'
$characterMapReplace.CircR = 'Â®'
$characterMapReplace.Grad = 'Â°'
$characterMapReplace.PlusMinus = 'Â±'
$characterMapReplace.Hoch1 = 'Â¹'
$characterMapReplace.Hoch2 = 'Â²'
$characterMapReplace.Hoch3 = 'Â³'
$characterMapReplace.My = 'Âµ'
$characterMapReplace.P = 'Â¶'
$characterMapReplace.SeitDachR = 'Â«'
$characterMapReplace.SeitDachL = 'Â»'
$characterMapReplace.Viertel = 'Â¼'
$characterMapReplace.Halb = 'Â½'
$characterMapReplace.Dreiviertel = 'Â¾'
$characterMapReplace.FrageZ = 'Â¿'
$characterMapReplace.not = 'Â¬'
$characterMapReplace.Agrave = 'Ã€'
$characterMapReplace.Acirc = "Ã‚"
$characterMapReplace.Atilde = "Ãƒ"
$characterMapReplace.Auml = 'Ã„'
$characterMapReplace.Aring = 'Ã…'
$characterMapReplace.AElig = "Ã†"
$characterMapReplace.Ccedil = "Ã‡"
$characterMapReplace.Egrave = "Ãˆ"
$characterMapReplace.Eacute = "Ã‰"
$characterMapReplace.Ecirc = "ÃŠ"
$characterMapReplace.Euml = "Ã‹"
$characterMapReplace.Igrave = "ÃŒ"
$characterMapReplace.Icirc = "ÃŽ"
$characterMapReplace.Oacute = 'Ã“'
$characterMapReplace.Ocirc = 'Ã”'
$characterMapReplace.Otilde = "Ã•"
$characterMapReplace.Ouml = "Ã–"
$characterMapReplace.times = "Ã—"
$characterMapReplace.Ugrave = "Ã™"
$characterMapReplace.Uacute = "Ãš"
$characterMapReplace.Ucirc = "Ã›"
$characterMapReplace.Uuml = "Ãœ"
$characterMapReplace.THORN = "Ãž"
$characterMapReplace.szlig = "ÃŸ"
$characterMapReplace.aacute = "Ã¡"
$characterMapReplace.acirc = "Ã¢"
$characterMapReplace.atilde = "Ã£"
$characterMapReplace.auml = "Ã¤"
$characterMapReplace.aring = "Ã¥"
$characterMapReplace.aelig = "Ã¦"
$characterMapReplace.ccedil = "Ã§"
$characterMapReplace.egrave = "Ã¨"
$characterMapReplace.eacute = "Ã©"
$characterMapReplace.ecirc = "Ãª"
$characterMapReplace.euml = "Ã«"
$characterMapReplace.igrave = "Ã¬"
$characterMapReplace.iacute = "Ã­"
$characterMapReplace.icirc = "Ã®"
$characterMapReplace.iuml = "Ã¯"
$characterMapReplace.eth = "Ã°"
$characterMapReplace.ntilde = "Ã±"
$characterMapReplace.ograve = "Ã²"
$characterMapReplace.oacute = "Ã³"
$characterMapReplace.ocirc = "Ã´"
$characterMapReplace.otilde = "Ãµ"
$characterMapReplace.ouml = "Ã¶"
$characterMapReplace.divide = "Ã·"
$characterMapReplace.oslash = "Ã¸"
$characterMapReplace.ugrave = "Ã¹"
$characterMapReplace.uacute = "Ãº"
$characterMapReplace.ucirc = "Ã»"
$characterMapReplace.uuml = "Ã¼"
$characterMapReplace.yacute = "Ã½"
$characterMapReplace.thorn = "Ã¾"
$characterMapReplace.yuml = "Ã¿"

#Replacement Character (HTML special characters)
#Wodurch ersetzt wird (HTML Sonderzeichen funktioniert zuverlässiger)
$characterMapChar = New-Object system.collections.hashtable
$characterMapChar.AnfZU = "&bdquo;"	#Anführungszeichen unten
$characterMapChar.AnfZOV = "&rdquo;"	#Anführungszeichen oben verkehrt
$characterMapChar.AnfZO = "&ldquo;"	#Anführungszeichen oben
$characterMapChar.BL = "&ndash;"	#Bindestrich lang
$characterMapChar.BL2 = "&mdash;"	#Bindestrich lang
$characterMapChar.Euro = "&euro;"
$characterMapChar.Bstr = ","			#Beistrich
$characterMapChar.Dacherl = "\^"			#Dacherl
$characterMapChar.Promille = "&permil;°"		#Promille
$characterMapChar.Apstr1 = "&lsquo;"			#Apostroph1
$characterMapChar.Apstr2 = "&rsquo;"			#Apostroph2
$characterMapChar.TM = "&trade;"
$characterMapChar.Pfund = "&pound;"
$characterMapChar.Yen = "&yen;"
$characterMapChar.Paragr = "&sect;"
$characterMapChar.CircC = "&copy;"
$characterMapChar.hochA = "&ordf;"
$characterMapChar.hochO = "&ordm;"
$characterMapChar.CircR = "&reg;"
$characterMapChar.Grad = "&deg;"
$characterMapChar.PlusMinus = "&plusmn;"
$characterMapChar.Hoch1 = "&sup1;"
$characterMapChar.Hoch2 = "&sup2;"
$characterMapChar.Hoch3 = "&sup3;"
$characterMapChar.My = "&micro;"
$characterMapChar.P = "&para;"
$characterMapChar.SeitDachR = "&laquo;"
$characterMapChar.SeitDachL = "&raquo;"
$characterMapChar.Viertel = "&frac14;"
$characterMapChar.Halb = "&frac12;"
$characterMapChar.Dreiviertel = "&frac34;"
$characterMapChar.FrageZ = "&iquest;"
$characterMapChar.not = "&not;"
$characterMapChar.Agrave = "&Agrave;"
$characterMapChar.Acirc = "&Acirc;"
$characterMapChar.Atilde = "&Atilde;"
$characterMapChar.Auml = "&Auml;"
$characterMapChar.Aring = "&Aring;"
$characterMapChar.AElig = "&AElig;"
$characterMapChar.Ccedil = "&Ccedil;"
$characterMapChar.Egrave = "&Egrave;"
$characterMapChar.Eacute = "&Eacute;"
$characterMapChar.Ecirc = "&Ecirc;"
$characterMapChar.Euml = "&Euml;"
$characterMapChar.Igrave = "&Igrave;"
$characterMapChar.Icirc = "&Icirc;"
$characterMapChar.Oacute = "&Oacute;"
$characterMapChar.Ocirc = "&Ocirc;"
$characterMapChar.Otilde = "&Otilde;"
$characterMapChar.Ouml = "&Ouml;"
$characterMapChar.times = "&times;"
$characterMapChar.Oslash = "&Oslash;"
$characterMapChar.Ugrave = "&Ugrave;"
$characterMapChar.Uacute = "&Uacute;"
$characterMapChar.Ucirc = "&Ucirc;"
$characterMapChar.Uuml = "&Uuml;"
$characterMapChar.THORN = "&THORN;"
$characterMapChar.szlig = "&szlig;"
$characterMapChar.aacute = "&aacute;"
$characterMapChar.acirc = "&acirc;"
$characterMapChar.atilde = "&atilde;"
$characterMapChar.auml = "&auml;"
$characterMapChar.aring = "&aring;"
$characterMapChar.aelig = "&aelig;"
$characterMapChar.ccedil = "&ccedil;"
$characterMapChar.egrave = "&egrave;"
$characterMapChar.eacute = "&eacute;"
$characterMapChar.ecirc = "&ecirc;"
$characterMapChar.euml = "&euml;"
$characterMapChar.igrave = "&igrave;"
$characterMapChar.iacute = "&iacute;"
$characterMapChar.icirc = "&icirc;"
$characterMapChar.iuml = "&iuml;"
$characterMapChar.eth = "&eth;"
$characterMapChar.ntilde = "&ntilde;"
$characterMapChar.ograve = "&ograve;"
$characterMapChar.oacute = "&oacute;"
$characterMapChar.ocirc = "&ocirc;"
$characterMapChar.otilde = "&otilde;"
$characterMapChar.ouml = "&ouml;"
$characterMapChar.divide = "&divide;"
$characterMapChar.oslash = "&oslash;"
$characterMapChar.ugrave = "&ugrave;"
$characterMapChar.uacute = "&uacute;"
$characterMapChar.ucirc = "&ucirc;"
$characterMapChar.uuml = "&uuml;"
$characterMapChar.yacute = "&yacute;"
$characterMapChar.thorn = "&thorn;"
$characterMapChar.yuml = "&yuml;"
  
foreach ($i in Get-ChildItem -Path $source -Include *.*htm* -Recurse -Force) {
    if ($i.PSIsContainer) {
		continue
	}
	
	$encoding=''
	
	[byte[]]$byte = get-content -Encoding byte -ReadCount 4 -TotalCount 4 -Path $i.Fullname

	if($byte.Length -lt 3) {
		Write-Host "File Empty: $($i.Fullname)"
		continue
	}

	 # EF BB BF (UTF8)
	 if ( $byte[0] -eq 0xef -and $byte[1] -eq 0xbb -and $byte[2] -eq 0xbf )
	 { $encoding = "UTF8" }
	 # FE FF  (UTF-16 Big-Endian)
	 elseif ($byte[0] -eq 0xfe -and $byte[1] -eq 0xff)
	 { $encoding = "Unicode UTF-16 Big-Endian" }
	 # FF FE  (UTF-16 Little-Endian)
	 elseif ($byte[0] -eq 0xff -and $byte[1] -eq 0xfe)
	 { $encoding = "Unicode UTF-16 Little-Endian" }
	 # 00 00 FE FF (UTF32 Big-Endian)
	 elseif ($byte[0] -eq 0 -and $byte[1] -eq 0 -and $byte[2] -eq 0xfe -and $byte[3] -eq 0xff)
	 { $encoding = "UTF32 Big-Endian" }
	 # FE FF 00 00 (UTF32 Little-Endian)
	 elseif ($byte[0] -eq 0xfe -and $byte[1] -eq 0xff -and $byte[2] -eq 0 -and $byte[3] -eq 0)
	 { $encoding = "UTF32 Little-Endian" }
	 # 2B 2F 76 (38 | 38 | 2B | 2F)
	 elseif ($byte[0] -eq 0x2b -and $byte[1] -eq 0x2f -and $byte[2] -eq 0x76 -and ($byte[3] -eq 0x38 -or $byte[3] -eq 0x39 -or $byte[3] -eq 0x2b -or $byte[3] -eq 0x2f) )
	 { $encoding = "UTF7"}
	 # F7 64 4C (UTF-1)
	 elseif ( $byte[0] -eq 0xf7 -and $byte[1] -eq 0x64 -and $byte[2] -eq 0x4c )
	 { $encoding = "UTF-1" }
	 # DD 73 66 73 (UTF-EBCDIC)
	 elseif ($byte[0] -eq 0xdd -and $byte[1] -eq 0x73 -and $byte[2] -eq 0x66 -and $byte[3] -eq 0x73)
	 { $encoding = "UTF-EBCDIC" }
	 # 0E FE FF (SCSU)
	 elseif ( $byte[0] -eq 0x0e -and $byte[1] -eq 0xfe -and $byte[2] -eq 0xff )
	 { $encoding = "SCSU" }
	 # FB EE 28  (BOCU-1)
	 elseif ( $byte[0] -eq 0xfb -and $byte[1] -eq 0xee -and $byte[2] -eq 0x28 )
	 { $encoding = "BOCU-1" }
	 # 84 31 95 33 (GB-18030)
	 elseif ($byte[0] -eq 0x84 -and $byte[1] -eq 0x31 -and $byte[2] -eq 0x95 -and $byte[3] -eq 0x33)
	 { $encoding = "GB-18030" }
	
	#Write-Host "$($i.Fullname) Encoding=$($encoding)"# uncomment for Debug output
	
	if($encoding -eq "UTF8") {
		continue
	}
	
	$outputpath = $i.DirectoryName -replace [regex]::Escape($source), $destination
	$outputFullname = "$($outputpath)\$($i.Name)"
	#Write-Host "Writing to: $($outputFullname)"# uncomment for Debug output
	if ( !(Test-Path $outputpath) ) {
		New-Item -Path $outputpath -ItemType directory
	}

	$content = get-content $i.Fullname

	# Set HTML File encoding
	if ( $content -ne $null ) {
		$content = $content -replace '(charset=.*")','charset=UTF-8"' 
		if($encoding -eq ''){	#If encoding is not recognized then Failover replacing all special characters
			foreach ($key in $characterMapReplace.Keys) {
				$content = $content -replace $characterMapReplace[$key], $characterMapChar[$key]
			}
		}
		
		[System.IO.File]::WriteAllLines($outputFullname, $content, $Utf8Encoding)
	} else {
		Write-Host "No content from: $i"   
	}
}
	
$sw.Stop()

Write-Host "Finished. Time elapsed $($sw.Elapsed) Press any key to continue ..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")