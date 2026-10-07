# ساخت APK اپ مدیریت تعمیرگاه ستاک

این پروژه برای ساخت APK با GitHub Actions آماده شده است. روی کامپیوتر کاربر نیازی به نصب Flutter یا Android Studio نیست.

## روش ساده

1. این پروژه را در یک Repository خصوصی GitHub قرار دهید.
2. شاخه `main` را Push کنید.
3. GitHub Actions به صورت خودکار APK را می‌سازد.
4. از بخش Actions، اجرای `Build Setak Repair Manager APK` را باز کنید.
5. در بخش Artifacts فایل `setak-repair-manager-apk` را دانلود کنید.

## نکته امنیتی

نام کاربری و Application Password وردپرس را داخل کد یا Repository قرار ندهید. اطلاعات ورود فقط داخل خود اپ وارد و در فضای امن دستگاه ذخیره می‌شود.

## نیازمندی سمت وردپرس

اپ برای کار با REST API افزونه Setak Repair API طراحی شده و سایت باید HTTPS داشته باشد.
