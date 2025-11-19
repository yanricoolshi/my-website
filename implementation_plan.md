# Implementation Plan - Yanri's Website (Visual Overhaul & Banner)

I will update the website to match the "Anri" mockup style (transparent green theme) and implement the user's specific requests: using `yanribanner.png` as the header and renaming "About" to "About Me...".

## User Review Required

> [!NOTE]
> **Header**: The text header will be replaced by the `yanribanner.png` image.
> **Visual Style**: The site will move to a **semi-transparent green** theme to match the mockup, allowing the water background to show through.
> **Navigation**: "About" will be renamed to "About Me...".

## Proposed Changes

### Assets
- **Copy**: `D:\antipoop\yanribanner.png` -> `images/yanribanner.png`

### HTML Updates

#### [MODIFY] [index.html](file:///C:/Users/akoda/.gemini/antigravity/brain/b3dc8f9a-8701-45a6-9bc0-a049d36ab941/index.html), [art.html](file:///C:/Users/akoda/.gemini/antigravity/brain/b3dc8f9a-8701-45a6-9bc0-a049d36ab941/art.html), [music.html](file:///C:/Users/akoda/.gemini/antigravity/brain/b3dc8f9a-8701-45a6-9bc0-a049d36ab941/music.html)
- **Header**: Replace `<h1>` text with `<img>` tag for the banner.
- **Navigation**: Change "About" link text to "About Me...".

### CSS Styling

#### [MODIFY] [style.css](file:///C:/Users/akoda/.gemini/antigravity/brain/b3dc8f9a-8701-45a6-9bc0-a049d36ab941/style.css)
- **`#container`**: Remove solid background/border. Make it transparent.
- **`#content-wrapper`**: Apply a **linear gradient** (Green/Transparent) background to match the mockup.
- **`#header`**: Adjust height to fit the banner. Remove background color.
- **`#menu`**: Update background to match the green theme (using `orengesho` or a green tint).
- **`#sidebar`**: Ensure text is readable against the new background.
- **Text Colors**: Update to **Dark Green** or **White** for better contrast.

## Verification Plan

### Manual Verification
- Open `index.html`.
- Verify the **Banner** is displayed at the top.
- Verify "About Me..." is in the menu.
- Check that the **Water GIF** is visible through the semi-transparent content areas.
- Compare the overall look with the "Anri" mockup.
