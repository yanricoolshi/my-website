# Complete fix - restore and add everything correctly
$path = "C:\Users\akoda\Documents\GitHub\my-website\index.html"
$content = Get-Content -Path $path -Raw

# 1. Add RANDOM STUFF section to sidebar
$pattern1 = '(<li><a href="#" id="discord-link">Discord</a></li>\r?\n\s+</ul>)'
$replacement1 = '<li><a href="#" id="discord-link">Discord</a></li>' + "`r`n                    <li><a href=`"https://steamcommunity.com/profiles/76561199213647371/`" target=`"_blank`">Steam</a></li>`r`n                </ul>`r`n`r`n                <h3>RANDOM STUFF</h3>`r`n                <ul>`r`n                    <li><a href=`"#`" id=`"cool-videos-btn`" onclick=`"toggleVideoPlayer(); return false;`">cool videos</a></li>`r`n                </ul>"
$content = $content -replace $pattern1, $replacement1

# 2. Add video player CSS before </head>
$cssBlock = @'
<style>
.video-player-window{position:fixed;top:50%;left:50%;transform:translate(-50%,-50%);z-index:10001;width:750px;background-color:#c0c0c0;border:2px solid #fff;border-right-color:#808080;border-bottom-color:#808080;padding:2px;box-shadow:4px 4px 10px rgba(0,0,0,0.5);font-family:'Tahoma',sans-serif;display:flex;flex-direction:column}
.video-player-header{background:linear-gradient(to right,#000080,#1084d0);color:white;padding:4px 8px;font-weight:bold;font-size:13px;display:flex;justify-content:space-between;align-items:center;margin-bottom:2px;cursor:grab}
.video-player-close{width:16px;height:16px;background-color:#c0c0c0;border:1px solid #fff;border-right-color:#808080;border-bottom-color:#808080;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:10px;font-weight:bold;color:black}
.video-player-close:active{border:1px solid #808080;border-right-color:#fff;border-bottom-color:#fff}
.video-player-body{display:flex;gap:4px;padding:4px}
.video-main-area{flex:1;display:flex;flex-direction:column}
#video-element{width:100%;height:300px;background-color:#000;border:2px solid #808080;border-right-color:#fff;border-bottom-color:#fff;margin-bottom:4px}
.video-playlist{width:220px;background-color:#fff;border:2px solid #808080;border-right-color:#fff;border-bottom-color:#fff;overflow-y:auto;height:380px;font-size:11px}
.playlist-item{padding:4px;cursor:pointer;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;border-bottom:1px dotted #ccc}
.playlist-item:hover{background-color:#e0e0e0}
.playlist-item.active{background-color:#000080;color:white}
.video-controls-area{margin-top:4px;border:1px solid #fff;border-right-color:#808080;border-bottom-color:#808080;padding:4px;background-color:#c0c0c0}
.seek-bar-container{height:15px;background-color:#000;margin-bottom:4px;position:relative;cursor:pointer;border:1px solid #808080;border-right-color:#fff;border-bottom-color:#fff}
.seek-bar-fill{height:100%;background-color:#00ff00;width:0%}
.control-buttons{display:flex;align-items:center;gap:4px}
.retro-btn{width:24px;height:24px;background-color:#c0c0c0;border:1px solid #fff;border-right-color:#808080;border-bottom-color:#808080;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:10px}
.retro-btn:active{border:1px solid #808080;border-right-color:#fff;border-bottom-color:#fff;transform:translate(1px,1px)}
.time-display{font-family:'Courier New',monospace;font-size:11px;margin-left:auto;background:#000;color:#00ff00;padding:2px 4px;border:1px solid #808080;border-right-color:#fff;border-bottom-color:#fff}
</style>

'@
$content = $content -replace '(</head>)', "$cssBlock`$1"

# 3. Add video player HTML before Discord Modal
$playerHTML = @'

    <!-- Video Player Window (Enhanced) -->
    <div id="video-player-window" class="video-player-window" style="display: none;">
        <div class="video-player-header">
            <span>Cool Videos Player 98</span>
            <span class="video-player-close" onclick="closeVideoPlayer()">X</span>
        </div>
        <div class="video-player-body">
            <div class="video-main-area">
                <video id="video-element" controls>
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

# 4. Add video player JS before service worker
$playerJS = @'

        const videoFiles=['Authority Zero - Revolution (Official Video).mp4','Crysis 3 - Skillet Hero - Music Video - HD - Ray Christian Bustamante (360p, h264).mp4','Koto - Jabdah Live Perfromance.mp4','Ondrej Matejka - Secret (video-converter.com).mp4','Ondrej Matejka - Secret.mp4','Quake 4 Music Video - SeptemberSun (144p, h264).mp4','RvB Season 8 Warthog Scene Re-Edit.mp4','The Hurt Locker Повелители Бури (Ария - Твой день).mp4','the russian.mp4','ytp/the birth they of justise.mp4','♪ GODZILLA THE MUSICAL - Cartoon Parody Song - LHUGUENY (360p, h264).mp4','♪ HALO THE MUSICAL - Parody Song Animation - LHUGUENY (360p, h264).mp4','♪ PREDATOR THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4','♪ PROMETHEUS THE MUSICAL - Animated Parody - LHUGUENY (360p, h264).mp4'];
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

'@
$content = $content -replace '(\s+</script>\s+<script>\s+if \(''serviceWorker'')', "$playerJS`$1"

Set-Content -Path $path -Value $content -NoNewline
Write-Host "Site fixed! All features added successfully." -ForegroundColor Green
