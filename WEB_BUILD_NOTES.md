# Flutter Web Build Configuration for GutCheck

## Issue: Isar and Web Compilation

Isar database doesn't fully support Flutter Web due to JavaScript integer limitations with Isar's large ID format. The generated `.g.dart` files contain 64-bit integers that can't be exactly represented in JavaScript.

## Solution Options

### Option 1: Use Hive for Web (Recommended - Easiest)
Hive is web-compatible and provides similar functionality to Isar:
```bash
flutter pub add hive_flutter
```

Then create platform-specific database implementations:
- iOS/Android/Desktop: Use Isar  
- Web: Use Hive

### Option 2: Use IndexedDB Wrapper for Web
Create a lightweight wrapper around browser IndexedDB that mimics Isar API.

### Option 3: Simplified Web Version
Use in-memory SQLite or LocalStorage for web version, focusing on read-only or limited edit capabilities.

## Current Implementation

For now, the PWA infrastructure is in place:
- ✅ Service worker for offline support
- ✅ Web manifest for installation
- ✅ PWA caching strategy
- ⏳ Database abstraction needed

The app will load and display UI offline, but data persistence is limited until database layer is abstracted.

## Quick Workaround

Build with Hive instead of Isar on web:

```bash
flutter pub add hive
# Add platform-conditional imports in your data layer
# Use Hive on web, Isar on native
```

**See ISAR_WEB_MIGRATION.md for detailed migration steps.**
