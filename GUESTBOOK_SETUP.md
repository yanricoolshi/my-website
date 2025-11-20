# JSONbin Guestbook Setup Instructions

Follow these simple steps to enable the shared guestbook:

## Step 1: Create a JSONbin Account (FREE & EASY!)

1. Go to [JSONbin.io](https://jsonbin.io/)
2. Click "Sign Up" (top right)
3. Create a free account with your email
4. Verify your email

## Step 2: Create a New Bin

1. After logging in, click "Create Bin" button
2. Name it: `guestbook` (or whatever you like)
3. Replace the default JSON with this:
```json
{
  "entries": []
}
```
4. Click "Create"

## Step 3: Get Your API Key

1. Click on your profile icon (top right)
2. Select "API Keys"
3. Copy your **Master Key** (starts with `$2a$10$...`)
4. Keep this safe - you'll need it in the next step

## Step 4: Get Your Bin ID

1. Go back to your bins list
2. Click on the "guestbook" bin you just created
3. Look at the URL in your browser
4. The Bin ID is the long string after `/b/` 
   - Example: `https://jsonbin.io/app/bins/6540abc123def456`
   - Bin ID = `6540abc123def456`

## Step 5: Update guestbook-config.js

1. Open `guestbook-config.js` in your website folder
2. Replace `YOUR_API_KEY_HERE` with your Master Key from Step 3
3. Replace `YOUR_BIN_ID` with your Bin ID from Step 4

Example:
```javascript
const JSONBIN_API_KEY = '$2a$10$AbC123XyZ...';
const GUESTBOOK_BIN_URL = 'https://api.jsonbin.io/v3/b/6540abc123def456';
```

4. Save the file

## Step 6: Deploy to GitHub

```bash
git add .
git commit -m "Add JSONbin guestbook"
git push
```

Wait a minute for GitHub Pages to update, then visit your guestbook!

## How It Works

- **JSONbin.io** stores your guestbook messages as JSON data
- **Free tier**: 10,000 requests/month (more than enough!)
- **Real-time**: Messages update automatically every 30 seconds
- **No backend needed**: Works perfectly with static GitHub Pages

## Features

✅ All visitors see the same messages  
✅ Messages persist forever  
✅ Automatic updates every 30 seconds  
✅ Simple and lightweight  
✅ No complex setup

## Security Note

- Your API key is visible in the source code (this is normal for static sites)
- JSONbin.io allows read/write access with the Master Key
- For better security, you can upgrade to a paid plan  and use access keys
- Consider moderating messages if you get spam

## Troubleshooting

**"Error loading messages"**
- Check that your API key is correct
- Verify your Bin ID is correct
- Make sure the bin contains `{"entries": []}`

**Messages not saving**
- Check browser console for errors
- Verify API key has write permissions
- Make sure you didn't exceed free tier limits (10k requests/month)

**Need help?**
- Check [JSONbin.io documentation](https://jsonbin.io/api-reference)
