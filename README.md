# Setak Repair Manager Android

نسخه اول اپ اندروید مدیر تعمیرگاه برای افزونه Setak Repair Manager.

## اتصال
این اپ از WordPress REST API استفاده می‌کند و احراز هویت را با **WordPress Application Passwords** انجام می‌دهد. سایت باید HTTPS باشد.

در وردپرس برای حساب مدیر تعمیرگاه:
1. نقش `مدیر تعمیرات ستاک` را به کاربر بدهید.
2. از پروفایل کاربر یک Application Password بسازید.
3. آدرس سایت، نام کاربری و Application Password را داخل اپ وارد کنید.

## API
Base URL:
`/wp-json/setak-repair/v1`

Endpoints اصلی:
- GET `/me`
- GET `/dashboard`
- GET `/options`
- GET `/technicians`
- GET `/customers?phone=...`
- GET/POST `/repairs`
- GET `/repairs/{id}`
- PUT `/repairs/{id}/intake`
- PUT `/repairs/{id}/status`
- PUT `/repairs/{id}/diagnosis`
- PUT `/repairs/{id}/estimate`
- PUT `/repairs/{id}/work`
- PUT `/repairs/{id}/test`
- PUT `/repairs/{id}/delivery`

## ساخت APK
Flutter SDK لازم است. سپس:

```bash
flutter pub get
flutter build apk --release
```

این نسخه عمداً بدون سرور واسط ساخته شده است: اپ مستقیماً با REST API وردپرس حرف می‌زند.
