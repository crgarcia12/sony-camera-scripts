function CopyFilesAndFixNames() {

    cd "C:\Users\crgar\Pictures\sonycamera"
    $folders = gci

    $folders | % { 
        $originName = $_.Name 
        $originName -match "(\d+)-(\d+)-(\d+)"
        $dia = $Matches[1]
        $mes = $Matches[2]
        $anio = $Matches[3]

        if(($anio -eq "2019")) {
            $destPath = "C:\tmp\sonycamera\$anio\$anio-$mes-$dia"
            if((test-Path $destPath) -eq $False) {
                mkdir $destPath
            }

            $files = gci "$originName\*"
    
    
            $files | % {
                $fileName = $_.Name
                if ((Test-Path "$destPath\$fileName") -eq $False) {
                    cp "$originName\$fileName" $destPath
                }
            }
        }
    }
}

function CheckMissingFiles() {
    cd "C:\Users\crgar\Pictures\sonycamera"

    $files = gci -r
    $destFiles = (gci \\crgarcia\photo\ -Recurse).Name

    $files | % {
        if($_.Extension.ToUpper() -eq ".JPG" -or $_.Extension.ToUpper() -eq ".MP4")
        {
            if($destFiles.Contains($_.Name) -eq $False) {
                Write-Verbose "$($_.FullName) does not exist" -Verbose
            }
        }
    
    }

}

CheckMissingFiles