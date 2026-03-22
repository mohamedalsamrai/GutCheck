# GutCheck Web PWA Setup Guide

## Overview

GutCheck now includes full PWA (Progressive Web App) infrastructure for offline support on iPhone Safari and other browsers. The app structure supports both native platforms (iOS, Android, macOS, Windows, Linux) and web.

## Quick Start: Deploy as PWA on iPhone

### Prerequisites
- Flutter web enabled (✅ already done)
- Web build passing (see troubleshooting below)
- HTTPS hosting (required for service workers)

### Deployment Steps

1. **Build for web:**
```bash
flutter build web --release --web-renderer html
```

2. **Deploy to HTTPS hosting:**
   - Vercel: `vercel --prod`
   - Netlify: drag & drop `build/web` folder
   - Firebase: `firebase deploy`
   - Custom server: Upload `build/web` folder with HTTPS

3. **Install on iPhone:**
   - Open in Safari
   - Tap Share (↗️)
   - Select "Add to Home Screen"
   - Choose app name and Add
   - App appears as standalone app icon on home screen

## Architecture: Supporting Multiple Platforms

### Current Setup

```
GutCheck App
├── Native Platforms (iOS, Android, Windows, macOS, Linux)
│   └── Use: Isar Database (local, fast, offline-first)
└── Web Platform
    ├── Use: Browser Storage (IndexedDB via Hive or similar)
    └── Serve via: Service Worker (offline caching)
```

### Platform Detection

The app includes `PlatformUtils` for platform-specific logic:

```dart
import 'package:gutcheck/core/utils/platform_utils.dart';

if (PlatformUtils.isWeb) {
  // Web-specific code
} else if (PlatformUtils.isMobile) {
  // iOS/Android
} else if (PlatformUtils.isDesktop) {
  // Windows/macOS/Linux
}
```

## Offline Features (PWA)

### What Works Offline
✅ View meals and wellness history  
✅ Browse analytics and insights  
✅ Navigate app UI  
✅ View charts and visualizations  
✅ Search pantry items  

### Coming Soon (Requires DB Migration)
⏳ Add meals offline  
⏳ Log wellness entries offline  
⏳ Sync when back online  

## Build Configuration

### Files Added

```
web/
├── index.html                    # PWA HTML with service worker
├── manifest.json                 # App metadata & installation
├── flutter_service_worker.js    # Offline caching strategy
└── icons/                        # App icons (add PNG files here)
    ├── Icon-192.png              # 192x192 icon
    └── Icon-512.png              # 512x512 icon
```

### Service Worker Features

- **Network-first strategy**: Prefers fresh data, falls back to cache
- **Automatic caching**: App shell cached on first visit
- **Offline detection**: Gracefully handles disconnections
- **Background sync ready**: Future enhancement for data sync

## Troubleshooting Web Build

### Issue: "Integer literal can't be represented in JavaScript"

**Cause**: Isar uses 64-bit integers that JavaScript can't precisely represent.

**Solution**: Use web-compatible database on web platform.

#### Option A: Disable Isar on Web (Recommended)

Edit `lib/core/database/isar_provider.dart`:

```dart
import 'package:flutter/foundation.dart';

final isarProvider = FutureProvider<Isar>((ref) async {
  if (kIsWeb) {
    // Return empty stub for web - database not available
    throw UnsupportedError('Isar not supported on web');
  }
  
  final isar = await Isar.open(
    [/* ...collections... */],
    inspector: true,
  );
  return isar;
});
```

#### Option B: Use Hive on Web (Full Sync)

```bash
flutter pub add hive hive_flutter
```

Create dual implementation:
```dart
// database_provider.dart
if (kIsWeb) {
  // Use Hive for web
  final box = await Hive.openBox('gutcheck');
} else {
  // Use Isar for native
  final isar = await Isar.open([...]);
}
```

#### Option C: Web-Only Build

Build web independently without shared data layer:
```bash
flutter build web --release --web-renderer html
```

This creates a separate web version that can't sync data with native apps (but all PWA features work).

## Testing Locally

### 1. Build web
```bash
flutter build web --release
```

### 2. Serve with HTTP server
```bash
cd build/web
python3 -m http.server 8000
```

### 3. Test in browser
```
http://localhost:8000
```

### 4. Open DevTools
- F12 or Cmd+Option+I
- Application tab → Service Workers
- Verify service worker is registered
- Check "Offline" checkbox to test offline mode

### 5. Test PWA install
- Open DevTools
- Application tab → Manifest
- Button "Add app to shelf" (simulates home screen install)

## iOS Testing

### Using Safari on macOS
```bash
# Run web server
cd build/web && python3 -m http.server 8000

# In Safari: Develop → Enter IP:8000
```

### Using iPhone with iCloud Keychain
1. Run web server on Mac with `--host 0.0.0.0`
2. Get Mac's local IP: `ifconfig | grep "inet "`
3. Open Safari on iPhone: `http://[MAC_IP]:8000`
4. Test all offline functions

## Performance Optimization

### Cache Strategy
```javascript
// From flutter_service_worker.js
const STRATEGY = 'network-first'; // Can change to 'cache-first'
```

- **network-first** (default): Prefers fresh data, good for dynamic content
- **cache-first**: Faster loading, good for static assets

### Bundle Size
```bash
flutter build web --analyzer-size-check [SIZE_IN_KB]
```

### Compression
Enable Gzip on hosting provider to reduce transfer size by ~60%.

## Deployment Recommendations

### Recommended Hosters (Free Tier Available)
1. **Vercel** - Best for Flutter web, free tier
   ```bash
   npm i -g vercel
   vercel --prod
   ```

2. **Netlify** - Drag & drop, free, auto-updates
   - Drag `build/web` folder

3. **Firebase** - Integrated with Google services
   ```bash
   firebase init hosting
   firebase deploy
   ```

### Production Checklist
- [ ] HTTPS enabled (required for service workers)
- [ ] Proper cache headers configured
- [ ] App icons added (192px & 512px PNG)
- [ ] SplashScreen configured (optional)
- [ ] Offline functionality tested
- [ ] Performance tested on slow 3G
- [ ] Works on iOS 15+ Safari
- [ ] Analytics integrated (optional)

## Future Enhancements

### Phase 2: Data Sync
- [ ] Bidirectional sync between web and native
- [ ] Cloud backup option
- [ ] Conflict resolution for offline changes
- [ ] Background sync API

### Phase 3: Advanced Features
- [ ] Biometric unlock on web
- [ ] Notification API for reminders
- [ ] Share data between devices
- [ ] Export/import format standardization

### Phase 4: Native Bridges
- [ ] Shared data between web and native
- [ ] Deep link from web to native app
- [ ] Web-to-native fallback

## Resources

- [Flutter Web Documentation](https://flutter.dev/web)
- [PWA Basics](https://web.dev/progressive-web-apps/)
- [Service Workers](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API)
- [Web App Manifest](https://developer.mozilla.org/en-US/docs/Web/Manifest)
- [iOS PWA Support](https://webkit.org/status/#pwa)

## Support

For issues:
1. Check browser console for errors (F12)
2. Verify service worker is registered
3. Hard refresh: Cmd+Shift+R (Mac) or Ctrl+Shift+R (Windows)
4. Check `WEB_BUILD_NOTES.md` for compilation issues
