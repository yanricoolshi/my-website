# Read current file
$content = Get-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Raw

# 1. ADD RANDOM STUFF TO SIDEBAR
$pattern1 = '(\s+<li><a href="#" id="discord-link">Discord</a></li>\r\n\s+</ul>\r\n\s+</div>)'
$replacement1 = '                    <li><a href="#" id="discord-link">Discord</a></li>
                </ul>

                <h3>RANDOM STUFF</h3>
                <ul>
                    <li><a href="#" id="cool-videos-btn" onclick="toggleVideoPlayer(); return false;">cool videos</a></li>
                </ul>
            </div>'
$content = $content -replace $pattern1, $replacement1

# 2. ADD VIDEO PLAYER HTML
$playerHTML = '

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

'
$pattern2 = '(\s+<!-- Discord Modal -->)'
$content = $content -replace $pattern2, ($playerHTML + '$1')

# 3. ADD COMPACT VIDEO PLAYER JS
$vid1='Authority Zero - Revolution (Official Video).mp4'
$vid2='Crysis 3 - Skillet Hero - Music Video - HD - Ray Christian Bustamante (360p, h264).mp4'
$vid3='Koto - Jabdah Live Perfromance.mp4'
$vid4='Ondrej Matejka - Secret (video-converter.com).mp4'
$vid5='Ondrej Matejka - Secret.mp4'
$vid6='Quake 4 Music Video - SeptemberSun (144p, h264).mp4'
$vid7='RvB Season 8 Warthog Scene Re-Edit.mp4'
$vid8='the russian.mp4'
$vid9='ytp/the birth they of justise.mp4'

$playerJS = "

        const videoFiles=['$vid1','$vid2','$vid3','$vid4','$vid5','$vid6','$vid7','The Hurt Locker Poveli Buri.mp4','$vid8','$vid9','GODZILLA MUSICAL.mp4','HALO MUSICAL.mp4','PREDATOR MUSICAL.mp4','PROMETHEUS MUSICAL.mp4'];
        let currentVideoIndex=0;
        function initPlaylist(){const p=document.getElementById('video-playlist');if(!p)return;p.innerHTML='';videoFiles.forEach((f,i)=>{const d=document.createElement('div');d.className='playlist-item';if(i===currentVideoIndex)d.classList.add('active');let n=f.split('/').pop().replace('.mp4','');if(n.length>28)n=n.substring(0,25)+'...';d.textContent=(i+1)+'. '+n;d.onclick=()=>loadVideo(i);p.appendChild(d);});}
        function toggleVideoPlayer(){const w=document.getElementById('video-player-window');if(w.style.display==='none'||!w.style.display){w.style.display='flex';initPlaylist();if(!document.getElementById('video-element').src)loadVideo(0);}else{w.style.display='none';document.getElementById('video-element').pause();}}
        function closeVideoPlayer(){document.getElementById('video-element').pause();document.getElementById('video-player-window').style.display='none';}
        function loadVideo(i){if(i>=0&&i<videoFiles.length){currentVideoIndex=i;const s=document.getElementById('video-source');s.src='images/'+encodeURI(videoFiles[i]);const v=document.getElementById('video-element');v.load();v.play().catch(e=>console.log('play prevented'));document.querySelectorAll('.playlist-item').forEach((item,idx)=>{if(idx===i)item.classList.add('active');else item.classList.remove('active');});updatePlayPauseIcon();}}
        function togglePlayPause(){const v=document.getElementById('video-element');if(!v)return;if(v.paused){v.play();}else{v.pause();}updatePlayPauseIcon();}
        function stopVideo(){const v=document.getElementById('video-element');if(!v)return;v.pause();v.currentTime=0;updatePlayPauseIcon();}
        function updatePlayPauseIcon(){const v=document.getElementById('video-element');const b=document.getElementById('play-pause-btn-video');if(!b||!v)return;b.textContent=v.paused?'▶':'⏸';}
        function nextVideo(){currentVideoIndex=(currentVideoIndex+1)%videoFiles.length;loadVideo(currentVideoIndex);}
        function previousVideo(){currentVideoIndex=(currentVideoIndex-1+videoFiles.length)%videoFiles.length;loadVideo(currentVideoIndex);}
        function formatTime(s){if(isNaN(s))return'00:00';const m=Math.floor(s/60);const sec=Math.floor(s%60);return(m<10?'0'+m:m)+':'+(sec<10?'0'+sec:sec);}
        const ve=document.getElementById('video-element');if(ve){ve.addEventListener('timeupdate',()=>{if(!ve.duration)return;const p=(ve.currentTime/ve.duration)*100;const f=document.getElementById('seek-bar-fill');if(f)f.style.width=p+'%';const t=document.getElementById('video-time-display');if(t)t.textContent=formatTime(ve.currentTime)+' / '+formatTime(ve.duration);});ve.addEventListener('ended',nextVideo);ve.addEventListener('play',updatePlayPauseIcon);ve.addEventListener('pause',updatePlayPauseIcon);}
        const sc=document.getElementById('seek-bar-container');if(sc){sc.addEventListener('click',(e)=>{if(!ve||!ve.duration)return;const r=sc.getBoundingClientRect();const x=e.clientX-r.left;const p=x/r.width;ve.currentTime=p*ve.duration;});}
        const vw=document.getElementById('video-player-window');const vh=document.querySelector('.video-player-header');if(vw&&vh){let isDrag=false,cx,cy,ix,iy,xo=0,yo=0;vh.addEventListener('mousedown',(e)=>{if(e.target.classList.contains('video-player-close'))return;ix=e.clientX-xo;iy=e.clientY-yo;if(e.target===vh||vh.contains(e.target)){isDrag=true;vh.style.cursor='grabbing';}});document.addEventListener('mousemove',(e)=>{if(isDrag){e.preventDefault();cx=e.clientX-ix;cy=e.clientY-iy;xo=cx;yo=cy;vw.style.transform='translate('+cx+'px, '+cy+'px)';}});document.addEventListener('mouseup',()=>{ix=cx;iy=cy;isDrag=false;vh.style.cursor='grab';});vh.style.cursor='grab';}

"
$pattern3 = '(\s+</script>\s+<script>\s+if \(''serviceWorker'')'
$content = $content -replace $pattern3, ($playerJS + '$1')

# Write file
Set-Content "C:\Users\akoda\Documents\GitHub\my-website\index.html" -Value $content -NoNewline
Write-Host "Done!" -ForegroundColor Green
