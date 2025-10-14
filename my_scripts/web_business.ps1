# Get the directory from the text file
$scriptDir = Split-Path $MyInvocation.MyCommand.Path
$dirFile = Join-Path $scriptDir "web_business_dir.txt"

if (Test-Path $dirFile) {
  $targetDir = Get-Content $dirFile | Select-Object -First 1

  if (Test-Path $targetDir) {
    Set-Location $targetDir

    $launchScript = Join-Path $targetDir "launch.ps1"
    if (Test-Path $launchScript) {
      & $launchScript
    }
    else {
      Write-Error "launch.ps1 not found in $targetDir"
    }
  }
  else {
    Write-Error "Directory not found: $targetDir"
  }
}
else {
  Write-Error "web_business_dir.txt not found in $scriptDir"
}
