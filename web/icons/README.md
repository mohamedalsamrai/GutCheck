# PWA Icons Setup

The following icon files are required for proper PWA functionality on iPhone and other devices:

## Required Icon Files

1. **Icon-192.png** (192x192 pixels)
   - Used for app installation on Android and as fallback
   - Should include safe area for maskable variant

2. **Icon-512.png** (512x512 pixels)
   - High-resolution icon for app stores and displays
   - Used as app icon on home screen when installed

3. **Icon-maskable-192.png** (192x192 pixels)
   - Maskable variant with safe zone padding
   - Used for adaptive icons on devices with notches/cutouts
   - Recommended: keep main content in center 80x80 area

4. **Icon-maskable-512.png** (512x512 pixels)
   - Maskable variant at full resolution
   - Keep main content in center area with padding

## How to Generate Icons

### Option 1: Using Flutter icon generator (Recommended)
```bash
flutter pub add flutter_launcher_icons
# Edit pubspec.yaml and configure flutter_launcher_icons
flutter pub run flutter_launcher_icons:main
```

### Option 2: Online Icon Generator
Use tools like:
- https://www.favicon-generator.org/
- https://www.pwa-asset-generator.com/
- https://appicon.co/

### Option 3: Manual Creation with ImageMagick
```bash
convert original-icon.png -resize 192x192 Icon-192.png
convert original-icon.png -resize 512x512 Icon-512.png
```

## Current Setup

Placeholder SVG has been created. Replace with actual PNG files before deploying to production.

For now, the app will work, but the icon won't display properly until PNG files are added.
