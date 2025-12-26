$htmlFile = "c:\Users\akoda\Documents\GitHub\my-website\index.html"
$content = Get-Content $htmlFile -Raw

# Fix: Ensure images are visible by calling showImage(0) after loading
$oldInit = 'if (isAutoplayRunning && !autoplayInterval) {
                autoplayInterval = setInterval(nextImage, 4000);
                console.log(''Autoplay started'');
            }
        }'

$newInit = 'showImage(0);
            
            if (isAutoplayRunning && !autoplayInterval) {
                autoplayInterval = setInterval(nextImage, 4000);
                console.log(''Autoplay started'');
            }
        }'

if ($content -match [regex]::Escape($oldInit)) {
    $content = $content -replace [regex]::Escape($oldInit), $newInit
    $content | Set-Content $htmlFile -NoNewline
    Write-Host "Fixed gallery display - added showImage(0) call"
} else {
    Write-Host "Pattern not found - gallery might already be fixed or pattern changed"
}
