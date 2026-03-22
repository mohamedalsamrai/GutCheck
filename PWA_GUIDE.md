# GutCheck PWA - Offline Support

This document explains how GutCheck works as a Progressive Web App (PWA) with offline capabilities.

## What is a PWA?

A Progressive Web App (PWA) is a web application that:
- Works offline using service workers
- Can be installed on home screen (like a native app)
- Has app-like experience with splash screens and status bar integration
- Syncs data when connection is restored

## Installing GutCheck on iPhone

### Using Safari

1. Open GutCheck in Safari (https://gutcheck.app or your deployment URL)
2. Tap the Share button (↗️)
3. Select "Add to Home Screen"
4. Enter app name and tap "Add"
5. App will appear on home screen and launch like a native app

### Features on iPhone

✅ Offline access - Full app functionality without internet  
✅ Home screen icon - Appears as standalone app  
✅ Status bar integration - Status bar color matches theme  
✅ Full screen - No browser UI (standalone mode)  
✅ Fast loading - Cached app shell loads instantly  

## Offline Capabilities

### What Works Offline

- ✅ Browse meal history
- ✅ View insights and analytics
- ✅ Read wellness entries
- ✅ Browse food pantry
- ✅ Navigate between tabs
- ✅ View all charts and visualizations

### Local Data Storage

**Note:** The web version uses IndexedDB (browser storage) instead of Isar database.

- All data is stored locally in your browser
- Data never leaves your device
- Completely private and offline-first
- Storage limit: ~50MB (varies by browser)

### Syncing

When you're offline:
- New data is saved locally
- When you reconnect, data persists
- No data loss, data remains on your device

## Technical Details

### Service Worker

The service worker (`flutter_service_worker.js`) implements a **network-first** caching strategy:

1. **Online**: Fetch from network, cache if successful, serve cached version if offline
2. **Offline**: Serve from cache, fail gracefully if not cached

This ensures:
- Fresh data when possible
- Offline fallback when needed
- Minimal cache usage

### Caching Strategy

```
Request → Try Network
    ↓ (success → cache & serve)
    ↓ (failure → fallback)
  Cache
    ↓ (found → serve)
    ↓ (not found → offline error)
  Offline
```

### Assets Cached

- App shell (HTML, CSS, JavaScript)
- Runtime assets (images, fonts)
- API responses (meals, wellness entries, etc.)

## Performance

### Initial Load
- **First visit**: ~500KB download (app+dependencies)
- **Cached**: ~100ms load time

### Offline Load
- **Instant**: ~50ms - loads from service worker cache

## Privacy & Security

✅ **100% Private** - No analytics or tracking  
✅ **No Cloud** - All data stays on your device  
✅ **HTTPS Required** - Service workers only work over HTTPS  
✅ **No Third-party APIs** - No external requests or data sharing  

## Limitations on Web

Some features may be limited on web compared to native app:

- Image capture: Uses file picker instead of camera
- Icons: Uses browser-native icons
- Haptic feedback: Limited browser support
- Background sync: Not yet implemented

## Troubleshooting

### App won't load offline
1. Ensure you visited the app while online first (service worker installs then)
2. Check browser cache isn't disabled
3. Hard refresh: Cmd+Shift+R (Mac) or Ctrl+Shift+R (Windows)

### Changes not appearing
- Service worker caches old versions
- Stop app and re-launch
- Or wait ~30 seconds for cache refresh

### Can't install on home screen
- Only works on iOS 15+ with Safari
- Ensure HTTPS connection
- App must load successfully first

### Storage is full
- Browser storage limit is ~50MB
- Clear cached data in browser settings
- Or export data and clear locally

## Future Enhancements

- [ ] Sync to cloud backup when online
- [ ] Background sync of pending changes
- [ ] Biometric unlock on web
- [ ] Share data between devices
- [ ] PWA update notifications

## Build & Deploy

### Local Testing
```bash
flutter build web
cd build/web && python3 -m http.server
# Visit http://localhost:8000
```

### Production Deploy
1. Deploy `build/web` folder to static hosting (Netlify, Vercel, etc.)
2. Ensure HTTPS is enabled
3. Service worker will auto-register
4. Users can install from browser menu

## Resources

- [PWA Basics](https://developers.google.com/web/progressive-web-apps)
- [Service Workers](https://developers.google.com/web/fundamentals/primers/service-workers)
- [Web App Manifest](https://developer.mozilla.org/en-US/docs/Web/Manifest)
- [iOS PWA Support](https://developer.apple.com/news/?id=12pf5hc2)
