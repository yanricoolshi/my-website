$file = "c:\Users\akoda\Documents\GitHub\my-website\index.html"
$content = Get-Content $file -Raw

# Remove verbose AI-style comments but keep functional ones
$content = $content -replace '\s*<!-- Corner Symbols -->\r?\n', ''
$content = $content -replace '\s*<!-- Custom Audio Player \(Draggable\) -->\r?\n', ''
$content = $content -replace '\s*<!-- Mozzart Window - Bottom Left -->\r?\n', ''
$content = $content -replace '\s*<!-- Pugo Badge Window - Bottom Right with Multiple Badges -->\r?\n', ''
$content = $content -replace '\s*<!-- Stamps Window - Next to Pugo Badge Window -->\r?\n', ''
$content = $content -replace '\s*<!-- Forpooper Image - Right Side -->\r?\n', ''
$content = $content -replace '\s*<!-- Header Banner -->\r?\n', ''
$content = $content -replace '\s*<!-- Horizontal Menu -->\r?\n', ''
$content = $content -replace '\s*<!-- Content Wrapper \(Sidebar \+ Main\) -->\r?\n', ''
$content = $content -replace '\s*<!-- Sidebar \(Left\) -->\r?\n', ''
$content = $content -replace '\s*<!-- Main Content Area \(Right\) -->\r?\n', ''
$content = $content -replace '\s*<!-- HOME SECTION -->\r?\n', ''
$content = $content -replace '\s*<!-- Button with poop images - interactive -->\r?\n', ''
$content = $content -replace '\s*<!-- Audio for button -->\r?\n', ''
$content = $content -replace '\s*<!-- Welcome/Intro Box -->\r?\n', ''
$content = $content -replace '\s*<!-- Gaming & Media -->\r?\n', ''
$content = $content -replace '\s*<!-- Social & Contact -->\r?\n', ''
$content = $content -replace '\s*<!-- Other Interests -->\r?\n', ''
$content = $content -replace '\s*<!-- Q&A Section -->\r?\n', ''
$content = $content -replace '\s*<!-- ART SECTION -->\r?\n', ''
$content = $content -replace '\s*<!-- Full-width Slideshow Section -->\r?\n', ''
$content = $content -replace '\s*<!-- MUSIC SECTION -->\r?\n', ''
$content = $content -replace '\s*<!-- INTERESTS SECTION -->\r?\n', ''
$content = $content -replace '\s*<!-- GUESTBOOK SECTION -->\r?\n', ''
$content = $content -replace '\s*<!-- Footer -->\r?\n', ''
$content = $content -replace '\s*<!-- Video Player Window \(Enhanced\) -->\r?\n', ''
$content = $content -replace '\s*<!-- Discord Modal -->\r?\n', ''
$content = $content -replace '<p><!-- TEXT PLACEHOLDER: Updates go here --></p>\r?\n', ''

# Remove verbose script comments
$content = $content -replace '        // --- ART GALLERY LOGIC \(must be defined first\) ---\r?\n', ''

$content | Set-Content $file -NoNewline
Write-Host "Removed verbose comments"
