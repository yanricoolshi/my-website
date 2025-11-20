# Yanri's Website 🎨

A retro-styled personal website with 2000s/early 2010s aesthetics featuring art gallery, music collection, and personal interests.

## Features
- 🖼️ **Art Gallery** - 77 image slideshow with auto-advance
- 🎵 **Music Page** - YouTube track links to favorite songs
- 🎮 **Interests** - Personal hobbies and interests
- 🔊 **SoundCloud Integration** - Embedded music player with playback persistence
- ✨ **Glowing Decorative Images** - Fixed-position images with green glow effects
- 🎨 **Windows Longhorn Taskbar Theme** - Retro menu styling

## GitHub Pages Deployment

### Quick Deploy
1. Push all files to GitHub:
```bash
git add .
git commit -m "Update website"
git push origin main
```

2. Enable GitHub Pages:
   - Go to repository **Settings** → **Pages**
   - Source: Select `main` branch
   - Folder: Select `/ (root)`
   - Click **Save**

3. Your site will be live at:
   `https://[your-username].github.io/my-website/`

### What's Already Configured
- ✅ `.nojekyll` file (prevents Jekyll processing)
- ✅ Relative file paths (works on any domain)
- ✅ SEO meta tags (viewport, description)
- ✅ Mobile-responsive design
- ✅ External CSS (optimized caching)
- ✅ No server-side dependencies

## Local Testing
Open `index.html` in your browser:
```bash
start index.html
```

## File Structure
```
my-website/
├── index.html          # Home/About page
├── art.html           # Art gallery with slideshow
├── music.html         # Music collection
├── interests.html     # Personal interests
├── style.css          # Main stylesheet
├── .nojekyll          # GitHub Pages config
└── images/            # All images and assets
```

## Technologies Used
- HTML5 (XHTML 1.0 Strict)
- CSS3 with retro styling
- Vanilla JavaScript
- SoundCloud Widget API
- Google Fonts (MedievalSharp)

## Browser Support
Works on all modern browsers. Designed for desktop viewing but mobile-responsive.

---
**Copyright © 2024 Yanri. All rights reserved.**
