$file = "c:\Users\akoda\Documents\GitHub\my-website\index.html"
$content = Get-Content $file -Raw

# Fix the broken interests section by inserting missing HTML
$broken = @"
                    <img src="images/capsule_616x353.jpg" alt="Game capsule"
                        style="max-width: 300px; display: block; margin: 15px 0;" />
                    <li>Old Call of Duty (CoD 1 through Black Ops 2 era)</li>
"@

$fixed = @"
                    <img src="images/capsule_616x353.jpg" alt="Game capsule"
                        style="max-width: 300px; display: block; margin: 15px 0;" />
                    <p>Here's a comprehensive list of things I'm into:</p>

                    <h3>FPS & Action Games</h3>
                    <div class="interest-list">
                        <ul>
                            <li>Halo</li>
                            <li>Crysis</li>
                            <li>S.T.A.L.K.E.R.</li>
                            <li>Fallout</li>
                            <li>Metal Gear (kojima is a hero in this site)</li>
                            <li>SWAT series (especially SWAT 4)</li>
                            <li>Old Call of Duty (CoD 1 through Black Ops 2 era)</li>
"@

$content = $content -replace [regex]::Escape($broken), $fixed

#Remove guestbook iframe
$content = $content -replace '(?s)<div class="guestbook-container".*?</div>\s*</div>\s*(?=</div>\s*</div>\s*<div id="footer")', '<p>Sign my guestbook: <a href="https://yanri.atabook.org/" target="_blank">yanri.atabook.org</a></p>'+"`r`n            </div>`r`n"

$content | Set-Content $file -NoNewline
Write-Host "Fixed HTML structure"
