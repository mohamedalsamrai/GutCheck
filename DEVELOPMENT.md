# Development Setup

This guide helps set up the development environment for GutCheck.

## Prerequisites

### Required
- **Flutter SDK**: 3.11.0 or later
  - Install: https://flutter.dev/docs/get-started/install
  - Verify: `flutter doctor`

- **Dart**: Comes with Flutter

### Platform-Specific

**macOS (for iOS development)**
- Xcode 14.0 or later
- CocoaPods: `sudo gem install cocoapods`
- Run: `flutter doctor -v` to verify

**Android**
- Android SDK (API level 34+)
- Android Studio recommended
- Android Emulator or physical device
- Run: `flutter doctor -v` to verify

**Linux**
- Build essentials
- CMake 3.10+

**Web**
- Chrome/Firefox for testing
- PWA support in modern browsers

## Initial Setup

1. **Clone and setup**
   ```bash
   git clone https://github.com/FreaxMATE/GutCheck.git
   cd GutCheck
   flutter pub get
   ```

2. **Generate code**
   ```bash
   flutter pub run build_runner build
   ```

3. **Verify setup**
   ```bash
   flutter doctor -v
   flutter analyze
   ```

## Development Commands

**Run development server (with hot reload)**
```bash
flutter run
```

**Run with specific device**
```bash
flutter run -d <device-id>
flutter devices  # List available devices
```

**Code generation**
```bash
# Watch mode (regenerates on file changes)
flutter pub run build_runner watch

# One-time build
flutter pub run build_runner build

# Clean and rebuild
flutter pub run build_runner build --delete-conflicting-outputs
```

**Code quality**
```bash
# Analyze code
flutter analyze

# Format code
dart format lib/ test/ --line-length=88

# Run tests
flutter test
flutter test --coverage
```

## IDE Setup

### VS Code
```bash
code .
```
Install extensions:
- Flutter
- Dart
- Dart Data Class Generator

### Android Studio
```bash
open -a "Android Studio" .
```
Built-in Flutter support.

### IntelliJ IDEA
Excellent Dart/Flutter support via plugins.

## Database Development

### Isar (Native/Mobile)

Generate models after modifying:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Models are in `lib/core/models/`.

### Web Database

Web uses Hive for data persistence. No code generation needed.

## Localization

Add translations in `lib/l10n/`:
- `app_en.arb` (English)
- `app_es.arb` (Spanish)
- etc.

Then rebuild to generate localized strings:
```bash
flutter pub get
flutter pub run build_runner build
```

## Testing

**Unit tests**
```bash
flutter test test/unit/
```

**Widget tests**
```bash
flutter test test/widget/
```

**Coverage**
```bash
flutter test --coverage
# View: open coverage/lcov.html
```

## Debugging

### Debug prints
```dart
debugPrint('message');
```

### Debugger
```bash
flutter run --debug
# Or use IDE debugging
```

### Performance profiling
```bash
flutter run --profile
# Open DevTools: Press 'w'
```

## Build & Deploy

See [README.md](../README.md#building-for-production) for production build instructions.

## Troubleshooting

**Flutter not found**
```bash
# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"
```

**Build cache issues**
```bash
flutter clean
flutter pub get
flutter pub run build_runner build
```

**Device not recognized**
```bash
flutter devices
flutter devices --diagnostics
```

**iOS issues**
```bash
cd ios
pod repo update
pod install
cd ..
flutter run
```

## Contributing

Before submitting a PR:
1. Run: `flutter analyze`
2. Run: `dart format lib/ test/`
3. Run: `flutter test`
4. Check: `flutter pub publish --dry-run`

See [CONTRIBUTING.md](../CONTRIBUTING.md) for more details.
