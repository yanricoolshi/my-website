$htmlFile = "c:\Users\akoda\Documents\GitHub\my-website\index.html"
$content = Get-Content $htmlFile -Raw

# Find the loadImages function's closing and fix it
$oldPattern = 'showImage\(0\);\s+if \(isAutoplayRunning && !autoplayInterval\) \{'
$newPattern = 'setTimeout(() => { showImage(0); }, 100);
            
            if (isAutoplayRunning && !autoplayInterval) {'

if ($content -match $oldPattern) {
    $content = $content -replace $oldPattern, $newPattern
    $content | Set-Content $htmlFile -NoNewline
    Write-Host "Fixed gallery display with setTimeout"
} else {
    Write-Host "Pattern not found, trying alternate fix"
    # Try adding setTimeout around existing showImage call
    $content = $content -replace 'showImage\(0\);', 'setTimeout(() => showImage(0), 100);'
    $content | Set-Content $htmlFile -NoNewline
    Write-Host "Applied setTimeout to showImage call"
}
