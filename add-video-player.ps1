# This script safely adds the video player functionality to index.html

# Read the entire file
$content = Get-Content -Path "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Raw

# 1. Add the CSS link in the head section
$cssLinkAdd = '    <link href="video-player.css" rel="stylesheet" type="text/css" />'
$content = $content -replace '(    <link href="style.css" rel="stylesheet" type="text/css" />)', "`$1`r`n$cssLinkAdd"

# 2. Add the RANDOM STUFF section to sidebar (after Contact section)
$randomStuffSection = @"

                <h3>RANDOM STUFF</h3>
                <ul>
                    <li><a href="#" id="cool-videos-btn" onclick="toggleVideoPlayer(); return false;">cool videos</a></li>
                </ul>
"@
$content = $content -replace '(                <li><a href="#" id="discord-link">Discord</a></li>\r\n                </ul>\r\n            </div>)', "`$1`r`n$randomStuffSection`r`n            </div>"

# 3. Add the video player window HTML before the Discord Modal
$videoPlayerHTML = @"

    <!-- Video Player Window -->
    <div id="video-player-window" class="video-player-window" style="display: none;">
        <div class="video-player-header">
            <span>Cool Videos Player</span>
            <span class="video-player-close" onclick="closeVideoPlayer()">X</span>
        </div>
        <div class="video-player-content">
            <video id="video-element" controls>
                <source id="video-source" src="" type="video/mp4">
                Your browser does not support the video tag.
            </video>
            <div class="video-info" id="video-info">No video loaded</div>
            <div class="video-controls">
                <button onclick="previousVideo()">← Previous</button>
                <button onclick="nextVideo()">Next →</button>
            </div>
        </div>
    </div>
"@
$content = $content -replace '(    <!-- Discord Modal -->)', "$videoPlayerHTML`r`n`$1"

# 4. Add the video player JavaScript before the closing script tag
$videoJS = @"

        // Video Player Functionality
        const videoFiles = [
            "Authority Zero - Revolution (Official Video).mp4",
            "Crysis 3 - Skillet Hero - Music Video - HD - Ray Christian Bustamante (360p, h264).mp4",
            "Koto - Jabdah Live Perfromance.mp4",
            "Ondrej Matejka - Secret (video-converter.com).mp4",
            "Ondrej Matejka - Secret.mp4",
            "Quake 4 Music Video - SeptemberSun (144p, h264).mp4",
            "RvB Season 8 Warthog Scene Re-Edit.mp4",
            "The Hurt Locker Повелители Бури (Ария - Твой день).mp4",
            "the russian.mp4",
            "ytp/the birth they of justise.mp4",
            "♪ GODZILLA THE MUSICAL - Cartoon Parody Song - LHUGUENY (360p, h264).mp4",
            "♪ HALO THE MUSICAL - Parody Song Animation - LHUGUENY (360p, h264).mp4",
            "♪ PREDATOR THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4",
            "♪ PROMETHEUS THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4"
        ];

        let currentVideoIndex = 0;

        function toggleVideoPlayer() {
            const videoWindow = document.getElementById('video-player-window');
            if (videoWindow.style.display === 'none') {
                videoWindow.style.display = 'block';
                if (currentVideoIndex === 0) {
                    loadVideo(0);
                }
            } else {
                videoWindow.style.display = 'none';
            }
        }

        function closeVideoPlayer() {
            const videoWindow = document.getElementById('video-player-window');
            const videoElement = document.getElementById('video-element');
            videoElement.pause();
            videoWindow.style.display = 'none';
        }

        function loadVideo(index) {
            const videoElement = document.getElementById('video-element');
            const videoSource = document.getElementById('video-source');
            const videoInfo = document.getElementById('video-info');

            if (index >= 0 && index < videoFiles.length) {
                currentVideoIndex = index;
                videoSource.src = 'images/' + videoFiles[index];
                videoElement.load();
                videoInfo.textContent = 'Video ' + (index + 1) + ' of ' + videoFiles.length + ': ' + videoFiles[index];
            }
        }

        function nextVideo() {
            currentVideoIndex = (currentVideoIndex + 1) % videoFiles.length;
            loadVideo(currentVideoIndex);
        }

        function previousVideo() {
            currentVideoIndex = (currentVideoIndex - 1 + videoFiles.length) % videoFiles.length;
            loadVideo(currentVideoIndex);
        }

        // Make Video Player Draggable
        const videoPlayerWindow = document.getElementById('video-player-window');
        const videoPlayerHeader = document.querySelector('.video-player-header');

        if (videoPlayerWindow && videoPlayerHeader) {
            let isDraggingVideo = false;
            let currentVideoX;
            let currentVideoY;
            let initialVideoX;
            let initialVideoY;
            let xVideoOffset = 0;
            let yVideoOffset = 0;

            videoPlayerHeader.addEventListener('mousedown', dragVideoStart);
            document.addEventListener('mousemove', dragVideo);
            document.addEventListener('mouseup', dragVideoEnd);

            function dragVideoStart(e) {
                if (e.target.classList.contains('video-player-close')) return;
                initialVideoX = e.clientX - xVideoOffset;
                initialVideoY = e.clientY - yVideoOffset;

                if (e.target === videoPlayerHeader || videoPlayerHeader.contains(e.target)) {
                    isDraggingVideo = true;
                    videoPlayerHeader.style.cursor = 'grabbing';
                }
            }

            function dragVideo(e) {
                if (isDraggingVideo) {
                    e.preventDefault();

                    currentVideoX = e.clientX - initialVideoX;
                    currentVideoY = e.clientY - initialVideoY;

                    xVideoOffset = currentVideoX;
                    yVideoOffset = currentVideoY;

                    videoPlayerWindow.style.transform = 'translate(' + currentVideoX + 'px, ' + currentVideoY + 'px)';
                }
            }

            function dragVideoEnd(e) {
                initialVideoX = currentVideoX;
                initialVideoY = currentVideoY;
                isDraggingVideo = false;
                videoPlayerHeader.style.cursor = 'grab';
            }

            videoPlayerHeader.style.cursor = 'grab';
        }
"@

# Find the position right before the service worker script and add video JS
$content = $content -replace '(    </script>\r\n\r\n    <script>\r\n        if \(''serviceWorker'')', "$videoJS`r`n`$1"

# Write the modified content back
Set-Content -Path "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Value $content -NoNewline

Write-Host "Video player functionality added successfully!" -ForegroundColor Green
