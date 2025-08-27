function Get-GitStatus { & git status $args }
New-Alias -Name s -Value Get-GitStatus -Force -Option AllScope

function Clear-Screen { & clear $args }
New-Alias -Name q -Value Clear-Screen

function Get-GitDiff { & git diff $args }
New-Alias -Name gd -Value Get-GitDiff

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

function Print-Things-I-Forgot {

        echo "F2 - Open previous commands"

}

# Make `tif` an alias for the function
Set-Alias -Name tif -Value Print-Things-I-Forgot
