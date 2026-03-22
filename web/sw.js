'use strict';

const CACHE_NAME = 'gutcheck-v1';

// Critical shell assets to precache on install
const SHELL_ASSETS = [
  '/',
  '/index.html',
  '/flutter_bootstrap.js',
  '/flutter.js',
  '/main.dart.js',
  '/manifest.json',
  '/favicon.svg',
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) =>
      Promise.allSettled(
        SHELL_ASSETS.map((url) =>
          fetch(url).then((res) => { if (res.ok) cache.put(url, res); }).catch(() => {})
        )
      )
    )
  );
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(keys.filter((k) => k !== CACHE_NAME).map((k) => caches.delete(k)))
    )
  );
  self.clients.claim();
});

self.addEventListener('fetch', (event) => {
  const { request } = event;
  if (request.method !== 'GET') return;
  const url = new URL(request.url);
  if (url.origin !== self.location.origin) return;

  event.respondWith(
    caches.open(CACHE_NAME).then((cache) =>
      cache.match(request).then((cached) => {
        if (cached) {
          // Serve from cache immediately; revalidate in background
          fetch(request).then((res) => { if (res.ok) cache.put(request, res); }).catch(() => {});
          return cached;
        }
        // Not cached yet — fetch from network and store for offline use
        return fetch(request).then((res) => {
          if (res.ok) cache.put(request, res.clone());
          return res;
        });
      })
    )
  );
});
