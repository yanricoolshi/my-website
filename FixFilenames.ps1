# Fix video file names to match actual files
$content = Get-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Raw

# Find and replace the videoFiles array with the correct filenames
$oldArray = "const videoFiles=\['Authority Zero - Revolution \(Official Video\)\.mp4','Crysis 3 - Skillet Hero - Music Video - HD - Ray Christian Bustamante \(360p, h264\)\.mp4','Koto - Jabdah Live Perfromance\.mp4','Ondrej Matejka - Secret \(video-converter\.com\)\.mp4','Ondrej Matejka - Secret\.mp4','Quake 4 Music Video - SeptemberSun \(144p, h264\)\.mp4','RvB Season 8 Warthog Scene Re-Edit\.mp4','The Hurt Locker Poveli Buri\.mp4','the russian\.mp4','ytp/the birth they of justise\.mp4','GODZILLA MUSICAL\.mp4','HALO MUSICAL\.mp4','PREDATOR MUSICAL\.mp4','PROMETHEUS MUSICAL\.mp4'\]"

$newArray = "const videoFiles=['Authority Zero - Revolution (Official Video).mp4','Crysis 3 - Skillet Hero - Music Video - HD - Ray Christian Bustamante (360p, h264).mp4','Koto - Jabdah Live Perfromance.mp4','Ondrej Matejka - Secret (video-converter.com).mp4','Ondrej Matejka - Secret.mp4','Quake 4 Music Video - SeptemberSun (144p, h264).mp4','RvB Season 8 Warthog Scene Re-Edit.mp4','The Hurt Locker Повелители Бури (Ария - Твой день).mp4','the russian.mp4','ytp/the birth they of justise.mp4','♪ GODZILLA THE MUSICAL - Cartoon Parody Song - LHUGUENY (360p, h264).mp4','♪ HALO THE MUSICAL - Parody Song Animation - LHUGUENY (360p, h264).mp4','♪ PREDATOR THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4','♪ PROMETHEUS THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4']"

$content = $content -replace [regex]::Escape($oldArray), $newArray

Set-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Value $content -NoNewline
Write-Host "Fixed video filenames!" -ForegroundColor Green
