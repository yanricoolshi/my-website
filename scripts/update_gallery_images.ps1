$htmlFile = "c:\Users\akoda\Documents\GitHub\my-website\index.html"
$content = Get-Content $htmlFile -Raw

# Get all image files from artgallury folder
$files = Get-ChildItem "c:\Users\akoda\Documents\GitHub\my-website\images\artgallury" -Name

# Create JavaScript array string
$fileList = $files | ForEach-Object {
    # Escape quotes and backslashes in filename
    $escaped = $_ -replace '\\', '\\' -replace '"', '\"'
    "`"$escaped`""
}
$arrayContent = $fileList -join ", "

Write-Host "Found $($files.Count) image files"

# Find and replace the imageFiles array
$pattern = '(?s)const imageFiles = \[.*?\];'
$replacement = "const imageFiles = [$arrayContent];"

if ($content -match $pattern) {
    $content = $content -replace $pattern, $replacement
    $content | Set-Content $htmlFile -NoNewline
    Write-Host "Updated imageFiles array with all $($files.Count) files from artgallury folder"
} else {
    Write-Host "ERROR: Could not find imageFiles array in HTML file"
}
