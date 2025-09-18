function Get-GitStatus { & git status $args }
New-Alias -Name s -Value Get-GitStatus -Force -Option AllScope

function Get-GetSwitch { & git switch $args }
New-Alias -Name gs -Value Get-GetSwitch -Force -Option AllScope

function Clear-Screen { & clear $args }
New-Alias -Name q -Value Clear-Screen

function Get-GitDiff { & git diff $args }
New-Alias -Name gd -Value Get-GitDiff -Force -Option AllScope

function Get-GitCommit { & git commit -m $args }
New-Alias -Name c -Value Get-GitCommit -Force -Option AllScope

function Get-GitAdd { & git add --all $args }
New-Alias -Name ga -Value Get-GitAdd -Force -Option AllScope

function Get-GitTree { & git log --all --graph --oneline --decorate --all $args }
New-Alias -Name t -Value Get-GitTree -Force -Option AllScope

function Get-GitPush { & git push $args }
New-Alias -Name gps -Value Get-GitPush -Force -Option AllScope
function Get-GitPull { & git pull $args }
New-Alias -Name gpl -Value Get-GitPull -Force -Option AllScope
function Get-GitFetch { & git fetch $args }
New-Alias -Name f -Value Get-GitFetch -Force -Option AllScope
function Get-GitCheckout { & git checkout $args }
New-Alias -Name co -Value Get-GitCheckout -Force -Option AllScope
function Get-GitBranch { & git branch $args }
New-Alias -Name b -Value Get-GitBranch -Force -Option AllScope
function Get-GitRemote { & git remote -v $args }
New-Alias -Name r -Value Get-GitRemote -Force -Option AllScope


function Get-GitCheckout { & git checkout $args }
New-Alias -Name gco -Value Get-GitCheckout
function Get-GitBranch { & git branch $args }
New-Alias -Name gb -Value Get-GitBranch
function Get-GitPull { & git pull $args }
New-Alias -Name gll -Value Get-GitPull

function Get-GitPush { & git pull $args }
New-Alias -Name gpp -Value Get-GitPush

function Get-GitCheckoutPreviousBranch { & git checkout - $args }
New-Alias -Name gcop -Value Get-GitCheckoutPreviousBranch

function Open-AddAliases { code $PROFILE }
New-Alias -Name addAliases -Value Open-AddAliases

function Show-Things-I-Forgot {

    Write-Host "F2 - Open previous commands"

}
Set-Alias tif Show-Things-I-Forgot

# Make `tif` an alias for the function
function Write-Daily {
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromRemainingArguments = $true)]
        [string[]]$Text
    )

    # Build numbered lines
    $numberedLines = for ($i = 0; $i -lt $Text.Count; $i++) {
        "$($i + 1). $($Text[$i])"
    }

    # Overwrite the file with the numbered lines
    Set-Content -Path "$HOME\.daily.txt" -Value $numberedLines
}
Set-Alias wdd Write-Daily

function Show-Daily {
    param (
        [string]$Path = "$HOME/.daily.txt"
    )
    if (Test-Path $Path) {
        Get-Content $Path
    }
    else {
        Write-Host "File not found: $Path"
    }
}
Set-Alias sdd Show-Daily

# Alias: stt  →  Set-TaskStrikeThrough
Set-Alias -Name stt -Value Set-TaskStrikeThrough

function Set-TaskStrikeThrough {
    [CmdletBinding()]
    param(
        # One or more line numbers to toggle strike-through on
        [Parameter(Mandatory = $true, Position = 0)]
        [int[]]$Number
    )

    $path = Join-Path $HOME ".daily.txt"
    if (-not (Test-Path $path)) {
        Write-Error "No .daily.txt found at $path"
        return
    }

    # Load lines
    $lines = Get-Content -Path $path

    # ANSI sequences for strike-through on/off
    $ESC = [char]27
    $ON = "$ESC[9m"
    $OFF = "$ESC[0m"

    foreach ($n in $Number) {
        if ($n -le 0 -or $n -gt $lines.Count) {
            Write-Warning "Line $n is out of range (1..$($lines.Count)). Skipping."
            continue
        }

        $line = $lines[$n - 1]

        # Expect format like: "1. buy groceries"
        if ($line -match '^\s*(\d+)\.\s*(.*)$') {
            $prefix = "$($Matches[1]). "
            $body = $Matches[2]

            # Detect existing strike-through (wrapped with ON...OFF)
            $isStruck = $body.StartsWith($ON) -and $body.EndsWith($OFF)

            if ($isStruck) {
                # Remove strike-through (toggle off)
                $clean = $body -replace [regex]::Escape($ON), '' -replace [regex]::Escape($OFF), ''
                $lines[$n - 1] = "$prefix$clean"
            }
            else {
                # Add strike-through
                $lines[$n - 1] = "$prefix$ON$body$OFF"
            }
        }
        else {
            # If the line doesn't match the expected "N. text" pattern, just wrap whole line
            $isStruck = $line.StartsWith($ON) -and $line.EndsWith($OFF)
            $lines[$n - 1] = if ($isStruck) {
                $line -replace [regex]::Escape($ON), '' -replace [regex]::Escape($OFF), ''
            }
            else {
                "$ON$line$OFF"
            }
        }
    }

    # Save back
    Set-Content -Path $path -Value $lines
}
Set-Alias stt Set-TaskStrikeThrough


# Helper function to get the drive letter from USB_DriveName.txt
function Get-USBDrive {
    $profileDir = Split-Path $PROFILE
    $usbFile = Join-Path $profileDir "USB_DriveName.txt"

    if (Test-Path $usbFile) {
        Get-Content $usbFile | Select-Object -First 1
    } else {
        throw "USB_DriveName.txt not found in $profileDir"
    }
}

# Function to start Neovim
function Start-Nvim {
    $drive = Get-USBDrive
    & "$drive\nvim\bin\nvim.exe"
}
Set-Alias envim Start-Nvim

# Function to launch VS Code
function Invoke-VSCode {
    param (
        [string]$Path = (Get-Location)
    )
    $drive = Get-USBDrive
    & "$drive\Microsoft VS Code\Code.exe" $Path
}
Set-Alias ecode Invoke-VSCode


