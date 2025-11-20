// Service Worker for Yanri's Website - Cache Management
const CACHE_NAME = 'yanri-website-v1';

// Files to cache
const urlsToCache = [
  '/',
  '/index.html',
  '/art.html',
  '/music.html',
  '/interests.html',
  '/style.css',
  '/images/yanribanner.png',
  '/images/watergif.gif',
  '/images/mysimbol.gif',
  '/images/icon.jpg',
  '/images/mozzart.jpg',
  '/images/forpooper.png',
  '/images/g9en3ts7nw781.png',
  '/images/poop1.png',
  '/images/poop2.png',
  '/images/poop3.png',
  '/images/waarrrr.ogg',
  '/images/update-screenshot.jpg',
  '/images/capsule_616x353.jpg',
  '/images/Jasmin China Girl [xe4APfSQRYQ].ogg',
  '/images/aero-form.png',
  '/images/windows_longhorn_taskbar_texture_by_scott_o_matic_df5ucbm-375w-2x.png'
];

// Install event - cache assets
self.addEventListener('install', function(event) {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(function(cache) {
        console.log('Opened cache');
        return cache.addAll(urlsToCache);
      })
  );
});

// Fetch event - serve from cache, fallback to network
self.addEventListener('fetch', function(event) {
  event.respondWith(
    caches.match(event.request)
      .then(function(response) {
        // Cache hit - return response
        if (response) {
          return response;
        }
        
        // Clone the request
        const fetchRequest = event.request.clone();
        
        return fetch(fetchRequest).then(
          function(response) {
            // Check if valid response
            if(!response || response.status !== 200 || response.type !== 'basic') {
              return response;
            }
            
            // Clone the response
            const responseToCache = response.clone();
            
            caches.open(CACHE_NAME)
              .then(function(cache) {
                cache.put(event.request, responseToCache);
              });
            
            return response;
          }
        );
      })
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', function(event) {
  const cacheWhitelist = [CACHE_NAME];
  
  event.waitUntil(
    caches.keys().then(function(cacheNames) {
      return Promise.all(
        cacheNames.map(function(cacheName) {
          if (cacheWhitelist.indexOf(cacheName) === -1) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
