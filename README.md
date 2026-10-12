# Campus Events — Flutter UI

Native Flutter UI based on the supplied updated mockup. Preserves its greeting,
event names, dates, venues, statuses and navigation. Bundled DejaVu serif and
sans fonts approximate the reference typography; original font names were
not provided. Card images are cropped from the reference and work offline.

## Run

With a stable Flutter SDK installed, open this folder and run:

    flutter create --platforms=android,ios,web .
    flutter pub get
    flutter run

This source bundle includes application code, configuration, assets and tests.
The first command generates standard platform runner files locally.
For iOS, use macOS with Xcode.

## Architecture

Feature-based MVVM: immutable CampusEvent → EventRepository interface →
MockEventRepository → EventsViewModel (ChangeNotifier) → HomeScreen and
reusable EventCard. AppTheme centralizes styling. Dependencies are constructor
injected, and the app disposes its view model. No additional state package
is needed for this small UI.

Search filters titles and venues. Home and Events display fixture data.
Check-In and Profile are UI placeholders. Event actions open detail sheets.
Registration sends nothing; the QR icon is labeled as a non-scannable preview.
The mockup's View QR is retained, with the venue scanning flow represented by
Check-In. Organizer statistics and surveys are outside this home-screen scope.

At smaller widths or larger text scales, actions wrap below card information.
The screen scrolls, respects SafeArea and caps content width on larger devices.

## Validation

    dart format lib test
    flutter analyze
    flutter test

Flutter and Dart are unavailable in the creation environment, so these commands,
widget tests and emulator visual checks have not been run. Tests cover search
behavior, narrow-screen rendering, and opening the QR preview.

## Assets

Event artwork: supplied user mockup. Fonts: DejaVu; license included in
assets/fonts/LICENSE.txt.
