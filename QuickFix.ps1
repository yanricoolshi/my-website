# Read current file
$content = Get-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Raw

# 1. ADD RANDOM STUFF TO SIDEBAR - Insert after Discord link, before closing div
$sidebarPattern = '(\s+<li><a href="#" id="discord-link">Discord</a></li>\r\n\s+</ul>\r\n\s+</div>)'
$sidebarReplacement = @'
                    <li><a href="#" id="discord-link">Discord</a></li>
                </ul>

                <h3>RANDOM STUFF</h3>
                <ul>
                    <li><a href="#" id="cool-videos-btn" onclick="toggleVideoPlayer(); return false;">cool videos</a></li>
                </ul>
            </div>
'@
$content = $content -replace $sidebarPattern, $sidebarReplacement

# 2. ADD VIDEO PLAYER HTML - Insert before Discord Modal
$playerHTML = @'

    <!-- Video Player Window (Enhanced) -->
    <div id="video-player-window" class="video-player-window" style="display: none;">
        <div class="video-player-header">
            <span>Cool Videos Player 98</span>
            <span class="video-player-close" onclick="closeVideoPlayer()">X</span>
        </div>
        <div class="video-player-body">
            <div class="video-main-area">
                <video id="video-element" onclick="togglePlayPause()">
                    <source id="video-source" src="" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
                <div class="video-controls-area">
                    <div class="seek-bar-container" id="seek-bar-container">
                        <div class="seek-bar-fill" id="seek-bar-fill"></div>
                    </div>
                    <div class="control-buttons">
                        <button class="retro-btn" onclick="previousVideo()" title="Previous">|&lt;</button>
                        <button class="retro-btn" onclick="togglePlayPause()" id="play-pause-btn-video" title="Play/Pause">▶</button>
                        <button class="retro-btn" onclick="stopVideo()" title="Stop">■</button>
                        <button class="retro-btn" onclick="nextVideo()" title="Next">&gt;|</button>
                        <div class="time-display" id="video-time-display">00:00 / 00:00</div>
                    </div>
                </div>
            </div>
            <div class="video-playlist" id="video-playlist"></div>
        </div>
    </div>

'@
$content = $content -replace '(\s+<!-- Discord Modal -->)', "$playerHTML`$1"

# 3. ADD VIDEO PLAYER JS - Insert before service worker script
$playerJS = @'

        // Video Player Enhanced
        const videoFiles = ["Authority Zero - Revolution (Official Video).mp4","Crysis 3 - Skillet Hero - Music Video - HD - Ray Christian Bustamante (360p, h264).mp4","Koto - Jabdah Live Perfromance.mp4","Ondrej Matejka - Secret (video-converter.com).mp4","Ondrej Matejka - Secret.mp4","Quake 4 Music Video - SeptemberSun (144p, h264).mp4","RvB Season 8 Warthog Scene Re-Edit.mp4","The Hurt Locker Повелители Бури (Ария - Твой день).mp4","the russian.mp4","ytp/the birth they of justise.mp4","♪ GODZILLA THE MUSICAL - Cartoon Parody Song - LHUGUENY (360p, h264).mp4","♪ HALO THE MUSICAL - Parody Song Animation - LHUGUENY (360p, h264).mp4","♪ PREDATOR THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4","♪ PROMETHEUS THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4"];
        let currentVideoIndex=0;
        function initPlaylist(){const playlist=document.getElementById("video-playlist");if(!playlist)return;playlist.innerHTML="";videoFiles.forEach((file,index)=>{const item=document.createElement("div");item.className="playlist-item";if(index===currentVideoIndex)item.classList.add("active");let displayName=file.split("/").pop().replace(".mp4","");if(displayName.length>28)displayName=displayName.substring(0,25)+"...";item.textContent=(index+1)+". "+displayName;item.onclick=()=>loadVideo(index);playlist.appendChild(item)});}
        function toggleVideoPlayer(){const videoWindow=document.getElementById("video-player-window");if(videoWindow.style.display==="none"||!videoWindow.style.display){videoWindow.style.display="flex";initPlaylist();if(!document.getElementById("video-element").src)loadVideo(0);}else{videoWindow.style.display="none";document.getElementById("video-element").pause();}}
        function closeVideoPlayer(){document.getElementById("video-element").pause();document.getElementById("video-player-window").style.display="none";}
        function loadVideo(index){if(index>=0&&index<videoFiles.length){currentVideoIndex=index;const videoSource=document.getElementById("video-source");videoSource.src="images/"+encodeURI(videoFiles[index]);document.getElementById("video-element").load();document.getElementById("video-element").play().catch(e=>console.log("Auto-play prevented"));document.querySelectorAll(".playlist-item").forEach((item,i)=>{if(i===index)item.classList.add("active");else item.classList.remove("active");});updatePlayPauseIcon();}}
        function togglePlayPause(){const videoElement=document.getElementById("video-element");if(!videoElement)return;if(videoElement.paused){videoElement.play();}else{videoElement.pause();}updatePlayPauseIcon();}
        function stopVideo(){const videoElement=document.getElementById("video-element");if(!videoElement)return;videoElement.pause();videoElement.currentTime=0;updatePlayPauseIcon();}
        function updatePlayPauseIcon(){const videoElement=document.getElementById("video-element");const playPauseBtnVideo=document.getElementById("play-pause-btn-video");if(!playPauseBtnVideo||!videoElement)return;if(videoElement.paused){playPauseBtnVideo.textContent="▶";}else{playPauseBtnVideo.textContent="⏸";}}
        function nextVideo(){currentVideoIndex=(currentVideoIndex+1)%videoFiles.length;loadVideo(currentVideoIndex);}
        function previousVideo(){currentVideoIndex=(currentVideoIndex-1+videoFiles.length)%videoFiles.length;loadVideo(currentVideoIndex);}
        function formatTime(seconds){if(isNaN(seconds))return"00:00";const m=Math.floor(seconds/60);const s=Math.floor(seconds%60);return(m<10?"0"+m:m)+":"+(s<10?"0"+s:s);}
        if(document.getElementById("video-element")){document.getElementById("video-element").addEventListener("timeupdate",()=>{const videoElement=document.getElementById("video-element");if(!videoElement.duration)return;const percent=(videoElement.currentTime/videoElement.duration)*100;const seekBarFill=document.getElementById("seek-bar-fill");if(seekBarFill)seekBarFill.style.width=percent+"%";const timeDisplay=document.getElementById("video-time-display");if(timeDisplay){timeDisplay.textContent=formatTime(videoElement.currentTime)+" / "+formatTime(videoElement.duration);}});document.getElementById("video-element").addEventListener("ended",nextVideo);document.getElementById("video-element").addEventListener("play",updatePlayPauseIcon);document.getElementById("video-element").addEventListener("pause",updatePlayPauseIcon);}
        if(document.getElementById("seek-bar-container")){document.getElementById("seek-bar-container").addEventListener("click",(e)=>{const videoElement=document.getElementById("video-element");if(!videoElement||!videoElement.duration)return;const rect=document.getElementById("seek-bar-container").getBoundingClientRect();const x=e.clientX-rect.left;const width=rect.width;const percent=x/width;videoElement.currentTime=percent*videoElement.duration;});}
        const videoPlayerWindow=document.getElementById("video-player-window");const videoPlayerHeader=document.querySelector(".video-player-header");if(videoPlayerWindow&&videoPlayerHeader){let isDraggingVideo=false,currentVideoX,currentVideoY,initialVideoX,initialVideoY,xVideoOffset=0,yVideoOffset=0;videoPlayerHeader.addEventListener("mousedown",(e)=>{if(e.target.classList.contains("video-player-close"))return;initialVideoX=e.clientX-xVideoOffset;initialVideoY=e.clientY-yVideoOffset;if(e.target===videoPlayerHeader||videoPlayerHeader.contains(e.target)){isDraggingVideo=true;videoPlayerHeader.style.cursor="grabbing";}});document.addEventListener("mousemove",(e)=>{if(isDraggingVideo){e.preventDefault();currentVideoX=e.clientX-initialVideoX;currentVideoY=e.clientY-initialVideoY;xVideoOffset=currentVideoX;yVideoOffset=currentVideoY;videoPlayerWindow.style.transform="translate("+currentVideoX+"px, "+currentVideoY+"px)";}});document.addEventListener("mouseup",(e)=>{initialVideoX=currentVideoX;initialVideoY=currentVideoY;isDraggingVideo=false;videoPlayerHeader.style.cursor="grab";});videoPlayerHeader.style.cursor="grab";}

'@
$content = $content -replace '(\s+</script>\s+<script>\s+if \(''serviceWorker'')', "$playerJS`$1"

# Write file
Set-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Value $content -NoNewline
Write-Host "✓ Fixed!" -ForegroundColor Green
