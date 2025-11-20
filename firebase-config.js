// Firebase Configuration
// INSTRUCTIONS: Replace this with your own Firebase config
// Get this from: https://console.firebase.google.com/
// 1. Create a new project (or use existing)
// 2. Go to Project Settings > General
// 3. Scroll down to "Your apps" and click "Web" (</> icon)
// 4. Copy the firebaseConfig object and replace the one below

const firebaseConfig = {
    apiKey: "YOUR_API_KEY_HERE",
    authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
    databaseURL: "https://YOUR_PROJECT_ID-default-rtdb.firebaseio.com",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_PROJECT_ID.appspot.com",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    appId: "YOUR_APP_ID"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);
