# Add explicit MP4 codec support
$content = Get-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Raw

# Update the source tag to include codec information
$content = $content -replace '<source id="video-source" src="" type="video/mp4">', '<source id="video-source" src="" type="video/mp4; codecs=&quot;avc1.42E01E, mp4a.40.2&quot;">'

Set-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Value $content -NoNewline
Write-Host "MP4 codec support added!" -ForegroundColor Green
