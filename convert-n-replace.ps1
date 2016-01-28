$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
    $source = "path"
    $destination = "output"

    foreach ($i in Get-ChildItem -Path $source -Include *.htm* -Recurse -Force) {
        if ($i.PSIsContainer) {
            continue
        }

        $path = $i.DirectoryName -replace $source, $destination
        $name = $i.Fullname -replace $source, $destination

        if ( !(Test-Path $path) ) {
            New-Item -Path $path -ItemType directory
        }

        $content = get-content $i.Fullname

        if ( $content -ne $null ) {
            
            $content = $content -replace '(charset=.*")','charset=UTF-8"' 
            Write-Host $name
            [System.IO.File]::WriteAllLines($name, $content, $Utf8NoBomEncoding)
            
        } else {
            Write-Host "No content from: $i"   
        }
    }
