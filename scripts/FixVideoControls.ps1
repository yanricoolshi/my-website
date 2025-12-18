# Fix video playback by adding controls attribute
$content = Get-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Raw
$content = $content -replace '<video id="video-element" onclick="togglePlayPause\(\)">', '<video id="video-element" controls>'
Set-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Value $content -NoNewline
Write-Host "Video controls added!" -ForegroundColor Green
