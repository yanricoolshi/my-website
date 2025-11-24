# This script fixes the sidebar layout and embeds the video player CSS/JS

# Read the file
$path = "C:\Users\akoda\Documents\GitHub\my-website\index.html"
$content = Get-Content -Path $path -Raw

# 1. FIX SIDEBAR LAYOUT
# The previous script accidentally placed RANDOM STUFF after the sidebar closed.
# We look for the closing div followed by the new section and remove the closing div.
$content = $content -replace '            </div>\s+<h3>RANDOM STUFF</h3>', "
                <h3>RANDOM STUFF</h3>"

# 2. EMBED CSS
# Read the CSS file
$cssContent = Get-Content -Path "C:\Users\akoda\Documents\GitHub\my-website\video-player.css" -Raw
# Wrap in style tags
$styleBlock = @"
    <style>
$cssContent
    </style>
"@
# Remove the link tag and insert the style block
$content = $content -replace '    <link href="video-player.css" rel="stylesheet" type="text/css" />', $styleBlock

# 3. UPDATE JS FOR ROBUSTNESS (encodeURI)
# We update the loadVideo function to encode the filename
$content = $content -replace "videoSource.src = 'images/' \+ videoFiles\[index\];", "videoSource.src = 'images/' + encodeURI(videoFiles[index]);"

# 4. REMOVE EXTRA CLOSING DIV IF NEEDED
# If we removed the first </div>, the one after RANDOM STUFF is now the correct closing div for the sidebar.
# So we don't need to remove the second one.
# Structure was: </div> [Random Stuff] </div>
# Becomes: [Random Stuff] </div>
# This is correct.

# Write back to file
Set-Content -Path $path -Value $content -NoNewline

Write-Host "Fixed sidebar layout and embedded video player assets." -ForegroundColor Green
