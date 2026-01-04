$weatherUrl = "https://wttr.in/Los+Angeles?u"

Write-Host ""
Write-Host "=== Weather ==="
Write-Host (Invoke-RestMethod $weatherUrl)

$sunriseApiUrl = "https://api.sunrisesunset.io/json?lat=34.039009&lng=-118.267281"
$response = Invoke-RestMethod $sunriseApiUrl

Write-Host ""
Write-Host "=== Sun ==="
Write-Host "Sunrise: $($response.results.sunrise)"
Write-Host "Sunset : $($response.results.sunset)"
