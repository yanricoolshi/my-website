# Script to add video player to working index.html
$sourceFile = "c:\Users\akoda\Documents\GitHub\my-website\index_working_from_live.html"
$destFile = "c:\Users\akoda\Documents\GitHub\my-website\index.html"

# Read the working version
$content = Get-Content $sourceFile -Raw

# Add the "Random Stuff" section to sidebar (after Contact section, before closing </div>)
$sidebarAddition = @"

                <h3>Random Stuff</h3>
                <ul>
                    <li><a href="#" id="cool-videos-link">cool videos</a></li>
                    <li><a href="#">epic ytp</a></li>
                    <li><a href="#">free game</a></li>
                </ul>
"@

# Insert Random Stuff section before the sidebar's closing </div> (around line 157)
$content = $content -replace '(\s+</ul>\s+</div>\s+<!-- Main Content Area)', "$sidebarAddition`$1"

# Add video player modal HTML before closing </body>
$videoPlayerHTML = @"

    <!-- Video Player Modal -->
    <!-- Video Player Window (Retro Style) -->
    <div id="video-modal" class="retro-video-player">
        <div class="video-title-bar" id="video-title-bar">
            <div class="video-title-bar-text">
                <img src="images/icon.jpg" style="height:16px;width:16px;border:1px solid white;">
                <span>Cool Videos Player</span>
            </div>
            <div class="video-window-controls">
                <div class="video-win-btn" onclick="minimizeVideo()">_</div>
                <div class="video-win-btn" onclick="closeVideoModal()">X</div>
            </div>
        </div>

        <div class="video-content-area">
            <video id="video-player" style="width:100%;max-height:400px;background:#000;display:block;">
                <source id="video-source" src="" type="video/mp4">
            </video>
        </div>

        <div class="video-controls-area">
            <div class="retro-btn" onclick="previousVideo()">|&lt; Prev</div>
            <div class="retro-btn" onclick="toggleVideoPlay()">Play/Pause</div>
            <div class="retro-btn" onclick="nextVideo()">Next &gt;|</div>
        </div>

        <div class="video-status-bar" id="video-info">Ready</div>
    </div>

"@

$content = $content -replace '(\s*</body>)', "$videoPlayerHTML`$1"

# Add video player JavaScript before the closing </script> tag (before serviceWorker script)
$videoPlayerJS = @"

        // Video Player Logic (Retro Window)
        const vF = ["Authority Zero - Revolution (Official Video).mp4", "Crysis 3 - Skillet Hero - Music Video - HD - Ray Christian Bustamante (360p, h264).mp4", "Koto - Jabdah Live Perfromance.mp4", "Ondrej Matejka - Secret (video-converter.com).mp4", "Quake 4 Music Video - SeptemberSun (144p, h264).mp4", "RvB Season 8 Warthog Scene Re-Edit.mp4", "The Hurt Locker Повелители Бури (Ария - Твой день).mp4", "the russian.mp4", "ytp/the birth they of justise.mp4", "♪ GODZILLA THE MUSICAL - Cartoon Parody Song - LHUGUENY (360p, h264).mp4", "♪ HALO THE MUSICAL - Parody Song Animation - LHUGUENY (360p, h264).mp4", "♪ PREDATOR THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4", "♪ PROMETHEUS THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4"];
        let vI = 0;
        let vL, vM, vP;

        function loadVideo(i) {
            const inf = document.getElementById("video-info");
            if (vP) {
                vI = i;
                vP.src = "images/" + vF[i];
                vP.load();
                vP.play().catch(e => console.log("Autoplay prevented:", e));
                inf.textContent = "Playing: " + vF[i] + " (" + (i + 1) + "/" + vF.length + ")";
            }
        }

        function previousVideo() {
            vI = (vI - 1 + vF.length) % vF.length;
            loadVideo(vI);
        }

        function nextVideo() {
            vI = (vI + 1) % vF.length;
            loadVideo(vI);
        }

        function toggleVideoPlay() {
            if (vP.paused) vP.play();
            else vP.pause();
        }

        function closeVideoModal() {
            if (vM) {
                vM.style.display = "none";
            }
            if (vP) {
                vP.pause();
            }
        }

        function minimizeVideo() {
            closeVideoModal();
        }

        document.addEventListener('DOMContentLoaded', function () {
            // Video Player Init
            vL = document.getElementById("cool-videos-link");
            vM = document.getElementById("video-modal");
            vP = document.getElementById("video-player");

            if (vL && vM) {
                vL.addEventListener("click", e => {
                    e.preventDefault();
                    vM.style.display = "block";
                    loadVideo(0);
                });
            }

            // Drag Logic for Video Player
            const videoTitleBar = document.getElementById("video-title-bar");
            if (vM && videoTitleBar) {
                let isDraggingVideo = false;
                let videoX, videoY, initialVideoX, initialVideoY, xOffsetVideo = 0, yOffsetVideo = 0;

                videoTitleBar.addEventListener("mousedown", dragStartVideo);
                document.addEventListener("mousemove", dragVideo);
                document.addEventListener("mouseup", dragEndVideo);

                function dragStartVideo(e) {
                    initialVideoX = e.clientX - xOffsetVideo;
                    initialVideoY = e.clientY - yOffsetVideo;

                    if (e.target === videoTitleBar || videoTitleBar.contains(e.target)) {
                        if (e.target.classList.contains("video-win-btn")) return;
                        isDraggingVideo = true;
                        videoTitleBar.style.cursor = "grabbing";
                    }
                }

                function dragVideo(e) {
                    if (isDraggingVideo) {
                        e.preventDefault();
                        videoX = e.clientX - initialVideoX;
                        videoY = e.clientY - initialVideoY;
                        xOffsetVideo = videoX;
                        yOffsetVideo = videoY;
                        vM.style.transform = "translate(calc(-50% + " + videoX + "px), calc(-50% + " + videoY + "px))";
                    }
                }

                function dragEndVideo(e) {
                    initialVideoX = videoX;
                    initialVideoY = videoY;
                    isDraggingVideo = false;
                    videoTitleBar.style.cursor = "default";
                }
            }
        });
"@

# Insert video player JavaScript before the closing </script> tag (before serviceWorker script)
$content = $content -replace '(\s*</script>\s*<script>\s*if \(''serviceWorker'')', "$videoPlayerJS`$1"

# Save to index.html
$content | Set-Content $destFile -Encoding UTF8 -NoNewline

Write-Host "SUCCESS: Video player added to index.html"
Write-Host "The working version has been restored with video player functionality added"
