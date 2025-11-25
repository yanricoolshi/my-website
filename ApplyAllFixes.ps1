# Apply all fixes in order
.\FinalFix.ps1
.\AddCSS.ps1
.\FixVideoControls.ps1
.\FixFilenames.ps1

# Now add Steam link
$content = Get-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Raw
$content = $content -replace '(<li><a href="#" id="discord-link">Discord</a></li>\s+</ul>)', ('<li><a href="#" id="discord-link">Discord</a></li>' + "`r`n                    <li><a href=`"https://steamcommunity.com/profiles/76561199213647371/`" target=`"_blank`">Steam</a></li>`r`n                </ul>")
Set-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Value $content -NoNewline
Write-Host "Steam link added!" -ForegroundColor Green
