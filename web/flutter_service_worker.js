// Service Worker for GutCheck PWA
// Provides offline support and caching strategies

const CACHE_NAME = 'gutcheck-v1';
const RUNTIME_CACHE = 'gutcheck-runtime-v1';
const STRATEGY = 'network-first'; // network-first or cache-first

// Assets to cache on install
const PRECACHE_ASSETS = [
  '/',
  '/index.html',
  '/main.dart.js',
  '/styles.css',
  '/flutter.js',
  '/flutter_bootstrap.js',
];

// Install event: cache essential assets
self.addEventListener('install', (event) => {
  console.log('Service Worker installing...');
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('Caching app shell');
      return cache.addAll(PRECACHE_ASSETS);
    }).catch(err => {
      console.warn('Failed to cache app shell:', err);
      // Continue even if some assets fail to cache
    })
  );
  self.skipWaiting();
});

// Activate event: clean up old caches
self.addEventListener('activate', (event) => {
  console.log('Service Worker activating...');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME && cacheName !== RUNTIME_CACHE) {
            console.log('Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  self.clients.claim();
});

// Fetch event: implement caching strategy
self.addEventListener('fetch', (event) => {
  const { request } = event;
  
  // Skip non-GET requests
  if (request.method !== 'GET') {
    return;
  }

  // Skip external requests (API calls to different origins)
  if (!request.url.startsWith(self.location.origin)) {
    return;
  }

  // Network-first strategy: try network, fall back to cache
  if (STRATEGY === 'network-first') {
    event.respondWith(
      fetch(request)
        .then((response) => {
          // Cache successful responses for future offline use
          if (response.ok) {
            const cache_copy = response.clone();
            caches.open(RUNTIME_CACHE).then((cache) => {
              cache.put(request, cache_copy);
            });
          }
          return response;
        })
        .catch(() => {
          // Network failed, try cache
          return caches.match(request).then((cached) => {
            if (cached) {
              console.log('Serving from cache:', request.url);
              return cached;
            }
            // If not in cache and offline, return offline page or app shell
            console.warn('Offline and no cache for:', request.url);
            throw new Error('offline');
          });
        })
    );
  }
  // Cache-first strategy: try cache, fall back to network
  else if (STRATEGY === 'cache-first') {
    event.respondWith(
      caches.match(request).then((cached) => {
        if (cached) {
          // Update cache in background
          fetch(request).then((response) => {
            if (response.ok) {
              caches.open(RUNTIME_CACHE).then((cache) => {
                cache.put(request, response.clone());
              });
            }
          }).catch(() => {
            // Network failed, that's OK - we have cached version
          });
          return cached;
        }
        // Not in cache, fetch from network
        return fetch(request)
          .then((response) => {
            if (response.ok && request.method === 'GET') {
              const cache_copy = response.clone();
              caches.open(RUNTIME_CACHE).then((cache) => {
                cache.put(request, cache_copy);
              });
            }
            return response;
          })
          .catch(() => {
            console.warn('Network and cache both failed:', request.url);
            throw new Error('offline');
          });
      })
    );
  }
});

// Background sync for offline data submission (future enhancement)
self.addEventListener('sync', (event) => {
  if (event.tag === 'sync-data') {
    event.waitUntil(
      // This would sync any pending data to the server when back online
      Promise.resolve()
    );
  }
});

// Message from client
self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});

console.log('Service Worker loaded');
