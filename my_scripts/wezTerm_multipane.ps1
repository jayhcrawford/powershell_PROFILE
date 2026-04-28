param(
  [string]$File = "urfriends_repo_paths.txt"
)

# ---- RESOLVE SCRIPT DIRECTORY (ALWAYS CORRECT) ----
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$FilePath = Join-Path $ScriptDir $File

# ---- VALIDATE FILE ----
if (!(Test-Path $FilePath)) {
  Write-Error "File not found: $FilePath"
  exit 1
}

$repos = Get-Content $FilePath |
ForEach-Object { $_.Trim() } |
Where-Object { $_ -ne "" }

if ($repos.Count -eq 0) {
  Write-Error "No repos found in $FilePath"
  exit 1
}

function Expand-Path($p) {
  if ($p.StartsWith("~")) {
    return $p -replace "^~", $HOME
  }
  return $p
}

$rootPane = $env:WEZTERM_PANE
if (-not $rootPane) {
  Write-Error "Run this inside WezTerm"
  exit 1
}

$count = $repos.Count
$percent = [math]::Floor(100 / $count)

# ---- FIRST PANE ----
$first = Expand-Path($repos[0])

wezterm cli send-text --pane-id $rootPane "pwsh -NoExit -Command `"Set-Location '$first'; if (Test-Path .git) { git pull }`"`r"

# ---- OTHER PANES ----
for ($i = 1; $i -lt $count; $i++) {
  $dir = Expand-Path($repos[$i])

  wezterm cli split-pane `
    --pane-id $rootPane `
    --bottom `
    --percent $percent `
    -- pwsh -NoExit -Command "Set-Location '$dir'; if (Test-Path .git) { git pull }" | Out-Null
}
