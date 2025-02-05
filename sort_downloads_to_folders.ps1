# PowerShell Script for Automatic File Organization
# Before running this script:
# 1. Open PowerShell as administrator
# 2. Run: Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
# 3. Navigate to the script directory
# 4. Run: .\sort_downloads_to_folders.ps1

while ($true) {
       Get-ChildItem -Path "$HOME\Downloads" | ForEach-Object {
        $file = $_.FullName

        if (Test-Path $file -PathType Container) {
            return
        }

        if ($file -like "*.mp3" -or $file -like "*.wav") {
            $targetDir = "$HOME\Downloads\music"
        }
        elseif ($file -like "*.jpg" -or $file -like "*.png" -or $file -like "*.jpeg" -or $file -like "*.gif") {
            $targetDir = "$HOME\Downloads\images"
        }
        elseif ($file -like "*.mp4" -or $file -like "*.mov") {
            $targetDir = "$HOME\Downloads\videos"
        }
        elseif ($file -like "*.pdf") {
            $targetDir = "$HOME\Downloads\pdf"
        }
        elseif ($file -like "*.zip" -or $file -like "*.tar*" -or $file -like "*.deb") {
            $targetDir = "$HOME\Downloads\zips-and-debeans"
        }
        elseif ($file -like "*.csv" -or $file -like "*.ods" -or $file -like "*.xlsx" -or $file -like "*.txt" -or $file -like "*.docx" -or $file -like "*.doc") {
            $targetDir = "$HOME\Downloads\docs"
        }
        elseif ($file -like "*.py" -or $file -like "*.ipynb" -or $file -like "*.db") {
            $targetDir = "$HOME\Downloads\python"
        }
        else {
            $targetDir = "$HOME\Downloads\extra"
        }

        if (-not (Test-Path $targetDir)) {
            New-Item -Path $targetDir -ItemType Directory
        }

        Move-Item -Path $file -Destination $targetDir
        Write-Output "$file moved to $targetDir"
    }

    Start-Sleep -Seconds 5
}
