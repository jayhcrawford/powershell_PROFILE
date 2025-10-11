# My PowerShell Profile
Write-Host "Loading profile..."

# Dot-source the script containing custom functions
# . "C:\Users\jayha\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

if ($IsMacOS) {
  Write-Host "PowerShell is running on macOS."
  . "/Users/jaycrawford/.config/powershell/Microsoft.PowerShell_profile.ps1"
}
elseif ($IsLinux) {
  Write-Host "PowerShell is running on Linux. Configure your PowerShell profile"
}
elseif ($IsWindows) {
  . "C:\Users\jayha\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
}
else {
  Write-Host "PowerShell is running on an unknown operating system."
}
