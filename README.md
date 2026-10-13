# Orange ส้ม — Flutter UI Workshop

Student: Rajesh Kumar Upadhayay  
Student ID: 6819110001

Six screens implemented with Flutter widgets and the supplied image assets.
Initial screen: E01PageUI. Reference viewport: iPhone 15 Pro Max (430 × 932 logical pixels).

## Run

```sh
flutter pub get
flutter run -d chrome
```

## Screens and navigation

- E01: Berry Juice welcome → Explore Now → E02
- E02: Login → Create Account → E03; Forgot Password → E04
- E03: Registration form → back to login
- E04: Email form → Send code → E05
- E05: Four-digit OTP demo → Verify → E06
- E06: Matching password form → Submit → E02

All six screen files are in `lib/views/`, with their required E01PageUI–E06PageUI class names.
Shared widgets are in `lib/widgets/`. Images are in `assets/images/`.

This assignment is a UI demonstration: it does not authenticate users, send email or OTP messages,
create accounts, or change real passwords. Social buttons show a demo notice.
The implementation uses the supplied screenshots because automated Figma access was unavailable.
