Import-Module AudioDeviceCmdlets

$samsungName    = 'SAMSUNG (NVIDIA High Definition Audio)'
$headphonesName = 'Headphones (Realtek USB Audio)'

$devices = @(
    Get-AudioDevice -List |
        Where-Object { $_.Type -eq 'Playback' }
)

$samsung = @(
    $devices | Where-Object { $_.Name -eq $samsungName }
)

$headphones = @(
    $devices | Where-Object { $_.Name -eq $headphonesName }
)

if ($samsung.Count -ne 1) {
    throw "Could not uniquely find: $samsungName"
}

if ($headphones.Count -ne 1) {
    throw "Could not uniquely find: $headphonesName"
}

$currentDevice = Get-AudioDevice -Playback

if ($currentDevice.ID -eq $samsung[0].ID) {
    $targetDevice = $headphones[0]
}
else {
    $targetDevice = $samsung[0]
}

Set-AudioDevice -ID $targetDevice.ID -DefaultOnly | Out-Null

Write-Host "Audio output switched to: $($targetDevice.Name)"
