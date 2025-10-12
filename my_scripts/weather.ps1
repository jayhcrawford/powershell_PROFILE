# Define the weather API endpoints
$weatherUrl1 = "https://v2.wttr.in/Los+Angeles?u"
$weatherUrl2 = "https://wttr.in/Los+Angeles?u"

# Fetch weather data
Invoke-RestMethod -Uri $weatherUrl1
Start-Sleep -Seconds 0.5
Invoke-RestMethod -Uri $weatherUrl2
Start-Sleep -Seconds 0.5

# Define the sunrise/sunset API endpoint
$sunriseApiUrl = "https://api.sunrisesunset.io/json?lat=34.039009&lng=-118.267281"

# Query the API and parse the response
$response = Invoke-RestMethod -Uri $sunriseApiUrl
$sunriseTime = $response.results.sunrise
$sunsetTime = $response.results.sunset

# Output sunrise and sunset times
Write-Output "The sunrise is at: $sunriseTime"
Write-Output "The sunset is at: $sunsetTime"