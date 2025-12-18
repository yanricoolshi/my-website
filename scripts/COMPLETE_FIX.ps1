# COMPLETE WORKING FIX FOR WEBSITE
# This script adds Random Stuff buttons and video player

$file = "index.html"
$content = Get-Content $file -Raw -Encoding UTF8

# Step 1: Add Random Stuff buttons to sidebar
$find1 = @'
                <h3>Contact</h3>
                <ul>
                    <li><a href="#">Email Me</a></li>
                    <li><a href="#" id="discord-link">Discord</a></li>
                </ul>
            </div>
'@

$replace1 = @'
                <h3>Contact</h3>
                <ul>
                    <li><a href="#">Email Me</a></li>
                    <li><a href="#" id="discord-link">Discord</a></li>
                </ul>

                <h3>Random Stuff</h3>
                <ul>
                    <li><a href="#" id="cool-videos-link">cool videos</a></li>
                    <li><a href="#">epic ytp</a></li>
                    <li><a href="#">free game</a></li>
                </ul>
            </div>
'@

$content = $content.Replace($find1, $replace1)

# Step 2: Add video modal HTML (right after Discord modal, before </body>)
$find2 = @'
    </div>

    <script>
'@

$replace2 = @'
    </div>

    <!-- Video Player Modal -->
    <div id="video-modal" class="discord-modal">
        <div class="discord-modal-content" style="max-width: 900px;">
            <div class="discord-modal-close" onclick="closeVideoModal()">X</div>
            <h2 style="color: #c8e6c9; text-align: center; margin: 10px 0;">Cool Videos</h2>
            <video id="video-player" controls style="width: 100%; max-height: 500px; background: #000;">
                <source id="video-source" src="" type="video/mp4">
            </video>
            <div style="margin: 15px 0; text-align: center;" id="video-info">Video 1 of 13</div>
            <div class="slideshow-controls">
                <button onclick="previousVideo()">← Previous</button>
                <button onclick="nextVideo()">Next →</button>
            </div>
        </div>
    </div>

    <script>
'@

$content = $content.Replace($find2, $replace2)

# Step 3: Add video JavaScript (before Make Audio Player Draggable comment)
$find3 = @'
        // Make Audio Player Draggable
'@

$replace3 = @'
        // Video Player
        const videoFiles = ["Authority Zero - Revolution (Official Video).mp4","Crysis 3 - Skillet Hero - Music Video - HD - Ray Christian Bustamante (360p, h264).mp4","Koto - Jabdah Live Perfromance.mp4","Ondrej Matejka - Secret (video-converter.com).mp4","Quake 4 Music Video - SeptemberSun (144p, h264).mp4","RvB Season 8 Warthog Scene Re-Edit.mp4","The Hurt Locker Повелители Бури (Ария - Твой день).mp4","the russian.mp4","ytp/the birth they of justise.mp4","♪ GODZILLA THE MUSICAL - Cartoon Parody Song - LHUGUENY (360p, h264).mp4","♪ HALO THE MUSICAL - Parody Song Animation - LHUGUENY (360p, h264).mp4","♪ PREDATOR THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4","♪ PROMETHEUS THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4"];
        let currentVideoIndex = 0;
        const coolVideosLink = document.getElementById('cool-videos-link');
        const videoModal = document.getElementById('video-modal');
        if (coolVideosLink && videoModal) {
            coolVideosLink.addEventListener('click', function (e) {
                e.preventDefault();
                videoModal.style.display = 'flex';
                loadVideo(0);
            });
        }
        function loadVideo(index) {
            const videoPlayer = document.getElementById('video-player');
            const videoSource = document.getElementById('video-source');
            const videoInfo = document.getElementById('video-info');
            if (videoPlayer && videoSource) {
                currentVideoIndex = index;
                videoSource.src = 'images/' + videoFiles[index];
                videoPlayer.load();
                videoInfo.textContent = 'Video ' + (index + 1) + ' of ' + videoFiles.length;
            }
        }
        function previousVideo() {
            currentVideoIndex = (currentVideoIndex - 1 + videoFiles.length) % videoFiles.length;
            loadVideo(currentVideoIndex);
        }
        function nextVideo() {
            currentVideoIndex = (currentVideoIndex + 1) % videoFiles.length;
            loadVideo(currentVideoIndex);
        }
        function closeVideoModal() {
            const videoModal = document.getElementById('video-modal');
            const videoPlayer = document.getElementById('video-player');
            if (videoModal) {
                videoModal.style.display = 'none';
            }
            if (videoPlayer) {
                videoPlayer.pause();
            }
        }
        window.addEventListener('click', function (e) {
            if (e.target == videoModal) {
                closeVideoModal();
            }
        });

        // Make Audio Player Draggable
'@

$content = $content.Replace($find3, $replace3)

# Save file
$content | Out-File $file -Encoding UTF8 -NoNewline

Write-Host "SUCCESS! Website fixed with Random Stuff buttons and video player!"
Write-Host "- Random Stuff section added to sidebar"
Write-Host "- Video player modal added"
Write-Host "- JavaScript for 13 videos added"
Write-Host ""
Write-Host "Test by opening index.html and clicking 'cool videos'"
