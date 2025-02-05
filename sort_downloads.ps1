# PowerShell Script for Automatic File Organization
Write-Output "Script started - monitoring Downloads folder..."

while ($true) {
    try {
        Write-Output "`nChecking Downloads folder..."
        $files = Get-ChildItem -Path "$HOME\Downloads"
        Write-Output "Found $($files.Count) items"

        foreach ($item in $files) {
            if ($item.PSIsContainer) {
                Write-Output "Skipping directory: $($item.Name)"
                continue
            }

            $file = $item.FullName
            Write-Output "Processing file: $($item.Name)"

            $targetDir = switch -Wildcard ($file) {
                "*.mp3" { "$HOME\Downloads\music" }
                "*.wav" { "$HOME\Downloads\music" }
                "*.jpg" { "$HOME\Downloads\images" }
                "*.png" { "$HOME\Downloads\images" }
                "*.jpeg" { "$HOME\Downloads\images" }
                "*.gif" { "$HOME\Downloads\images" }
                "*.mp4" { "$HOME\Downloads\videos" }
                "*.mov" { "$HOME\Downloads\videos" }
                "*.pdf" { "$HOME\Downloads\pdf" }
                "*.zip" { "$HOME\Downloads\archives" }
                "*.tar*" { "$HOME\Downloads\archives" }
                "*.deb" { "$HOME\Downloads\archives" }
                "*.csv" { "$HOME\Downloads\documents" }
                "*.ods" { "$HOME\Downloads\documents" }
                "*.xlsx" { "$HOME\Downloads\documents" }
                "*.txt" { "$HOME\Downloads\documents" }
                "*.docx" { "$HOME\Downloads\documents" }
                "*.doc" { "$HOME\Downloads\documents" }
                "*.py" { "$HOME\Downloads\python" }
                "*.ipynb" { "$HOME\Downloads\python" }
                "*.db" { "$HOME\Downloads\python" }
                default { "$HOME\Downloads\other" }
            }

            Write-Output "Target directory: $targetDir"

            if (-not (Test-Path $targetDir)) {
                Write-Output "Creating directory: $targetDir"
                New-Item -Path $targetDir -ItemType Directory -Force | Out-Null
            }

            try {
                Move-Item -Path $file -Destination $targetDir -ErrorAction Stop
                Write-Output "Successfully moved: $($item.Name) to $targetDir"
            }
            catch {
                Write-Warning "Failed to move '$($item.Name)': $($_.Exception.Message)"
            }
        }
    }
    catch {
        Write-Error "Error processing files: $($_.Exception.Message)"
    }

    Write-Output "Waiting 5 seconds before next check..."
    Start-Sleep -Seconds 5
}
