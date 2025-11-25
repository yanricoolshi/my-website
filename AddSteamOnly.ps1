# Simple Steam link addition
$lines = Get-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html"
$newLines = @()

for($i=0; $i -lt $lines.Count; $i++){
    $newLines += $lines[$i]
    # After Discord link line, add Steam
    if($lines[$i] -match 'discord-link.*Discord.*</li>'){
        $newLines += '                    <li><a href="https://steamcommunity.com/profiles/76561199213647371/" target="_blank">Steam</a></li>'
    }
}

$newLines | Set-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html"
Write-Host "Steam link added successfully!" -ForegroundColor Green
