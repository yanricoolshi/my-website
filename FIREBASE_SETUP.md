# Firebase Guestbook Setup Instructions

Follow these steps to enable the shared guestbook on your website:

## Step 1: Create a Firebase Project (FREE)

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or "Create a project"
3. Enter project name (e.g., "yanri-website")
4. Disable Google Analytics (not needed)
5. Click "Create project"

## Step 2: Set Up Realtime Database

1. In your Firebase project, click "Realtime Database" in the left menu
2. Click "Create Database"
3. Choose a location (close to you or your visitors)
4. **IMPORTANT**: Select "Start in test mode" (for now)
5. Click "Enable"

## Step 3: Configure Security Rules

1. In Realtime Database, click the "Rules" tab
2. Replace the rules with this:

```json
{
  "rules": {
    "guestbook": {
      ".read": true,
      ".write": true,
      "$entry": {
        ".validate": "newData.hasChildren(['name', 'message', 'timestamp']) && newData.child('name').isString() && newData.child('name').val().length <= 50 && newData.child('message').isString() && newData.child('message').val().length <= 500"
      }
    }
  }
}
```

3. Click "Publish"

## Step 4: Get Your Firebase Config

1. Click the gear icon ⚙️ next to "Project Overview"
2. Select "Project settings"
3. Scroll down to "Your apps"
4. Click the web icon `</>` (if no app exists, create one)
5. Register app with a nickname (e.g., "guestbook")
6. Copy the `firebaseConfig` object

## Step 5: Update firebase-config.js

1. Open `firebase-config.js` in your website folder
2. Replace `YOUR_API_KEY_HERE` and other placeholders with your actual values from step 4
3. Save the file

Example:
```javascript
const firebaseConfig = {
    apiKey: "AIzaSyAbc123...",
    authDomain: "yanri-website.firebaseapp.com",
    databaseURL: "https://yanri-website-default-rtdb.firebaseio.com",
    projectId: "yanri-website",
    storageBucket: "yanri-website.appspot.com",
    messagingSenderId: "123456789",
    appId: "1:123456789:web:abc123..."
};
```

## Step 6: Deploy to GitHub Pages

1. Commit and push all files to GitHub:
```bash
git add .
git commit -m "Add Firebase guestbook"
git push
```

2. Wait a minute for GitHub Pages to update
3. Visit your guestbook page - messages are now shared!

## Notes

- **Free tier**: Firebase Realtime Database is free for up to 1GB storage and 10GB/month downloads
- **Security**: Test mode allows anyone to read/write. For production, you can add authentication
- **Spam protection**: Consider adding rate limiting or moderation if you get spam

## Troubleshooting

- If you see "Loading messages..." forever, check your browser console for errors
- Make sure your database URL ends with `.firebaseio.com`
- Verify security rules are published
- Check that firebase-config.js has no syntax errors
