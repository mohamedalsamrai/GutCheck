# Release Process

Guide for maintainers to release new versions of GutCheck.

## Release Checklist

### Pre-Release (1-2 days before)
- [ ] Create a release branch: `git checkout -b release/v1.x.x`
- [ ] Review all PRs and issues for this release
- [ ] Update version in `pubspec.yaml`
- [ ] Update `CHANGELOG.md` with all changes
- [ ] Test all platforms locally:
  ```bash
  flutter clean
  flutter test
  flutter build apk --release
  flutter build ios --release
  flutter build web --release
  ```
- [ ] Create PR and get it reviewed
- [ ] Merge to `main` branch

### Release
1. **Tag the release**
   ```bash
   git tag -a v1.x.x -m "Release version 1.x.x"
   git push origin v1.x.x
   ```

2. **Create GitHub Release**
   - Go to [Releases](https://github.com/FreaxMATE/GutCheck/releases)
   - Click "Draft a new release"
   - Tag: `v1.x.x`
   - Title: `GutCheck v1.x.x`
   - Description: Copy from `CHANGELOG.md`
   - Attach build artifacts (APK, AAB, etc.)

3. **Publish Android**
   ```bash
   flutter build appbundle --release
   # Upload to Google Play Console
   ```

4. **Publish iOS**
   - In Xcode: Product > Archive
   - Upload to App Store via Transporter

5. **Deploy Web**
   ```bash
   flutter build web --release
   # Deploy to hosting (Netlify, Firebase, etc.)
   ```

### Post-Release
- [ ] Verify release is available on all platforms
- [ ] Update release notes with platform-specific instructions
- [ ] Post announcement in community channels
- [ ] Close related issues/milestones
- [ ] Create next version milestone

## Version Numbering

Follow Semantic Versioning (MAJOR.MINOR.PATCH):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes

Example: `1.2.3` = Release 1, Minor version 2, Patch 3

## Platform Release Notes

### iOS
- Requires TestFlight beta > 10,000 installs before App Store submission
- App Review typically takes 24 hours
- Review Guidelines: https://developer.apple.com/app-store/review/guidelines/

### Android
- Google Play typically reviews in minutes
- Monitor crash reports in Firebase Crashlytics
- Release to staged rollout (5% → 25% → 100%)

### Web
- No review process
- Immediate deployment
- Use service worker cache busting

## Rollback Procedure

If critical issue found after release:

1. **Pause rollout** (on mobile platforms)
2. **Fix issue** and increment patch version
3. **Re-release** with fix
4. **Tag as emergency**: `v1.x.x-emergency`

## Distribution

- **iOS**: App Store
- **Android**: Google Play Store
- **Web**: https://gutcheck.app (or your domain)
- **Linux**: Snap Store (optional)
- **macOS**: Mac App Store (optional)

## Tools & Services

- **Beta Testing**: TestFlight (iOS), Google Play Beta (Android)
- **Crash Reporting**: Firebase Crashlytics
- **Analytics**: Firebase Analytics
- **Hosting**: Netlify, Firebase Hosting, Vercel

## Release Templates

See [CHANGELOG.md](CHANGELOG.md) and [GitHub Release template](.github/pull_request_template.md) for formats.

## Questions?

Ask in team discussion or reach out to release lead.
