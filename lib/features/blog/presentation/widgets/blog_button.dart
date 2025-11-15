import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// دکمه‌ای با قابلیت تغییر رنگ و حالت‌های مختلف مانند hover و pressed.
///
/// این دکمه شامل یک متن و آیکن است که می‌تواند رنگ پس‌زمینه خود را
/// به‌صورت داینامیک تغییر دهد و با وضعیت‌های مختلف مانند `hovered`
/// و `pressed` واکنش نشان دهد. این ویژگی‌ها به دکمه امکان می‌دهند که
/// به‌خوبی با نیازهای مختلف رابط کاربری (UI) هماهنگ شود.
///
/// ## پارامترها:
/// - `text`: متن نمایش داده شده روی دکمه.
/// - `color`: رنگ پس‌زمینه دکمه در حالت‌های مختلف.
/// - `onTap`: تابعی که هنگام کلیک بر روی دکمه اجرا می‌شود.
///
/// ## مثال استفاده:
/// ```dart
/// BlogButton(
///   text: "Click Me",
///   color: Colors.blue,
///   onTap: () {
///     // عملکرد در هنگام کلیک
///   },
/// )
/// ```
class ButtonWidget extends StatelessWidget {
  /// متن نمایش داده شده روی دکمه
  final String text;

  final bool isIcon;

  /// رنگ پس‌زمینه دکمه
  final Color color;

  /// تابعی که در هنگام کلیک روی دکمه اجرا می‌شود
  final VoidCallback onTap;

  /// سازنده دکمه با نیاز به پارامترهای `text`, `color`, و `onTap`
  const ButtonWidget({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    this.isIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextButton.icon(
        icon:
            isIcon
                ? Icon(
                  CupertinoIcons.arrow_up_right,
                  color: Theme.of(context).colorScheme.onSurface,
                )
                : null,
        style: TextButton.styleFrom(
          // تنظیم شکل دکمه (گوشه‌های گرد)
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // تنظیم اندازه حداقل دکمه
          minimumSize: const Size(130, 53),
          // تنظیم رنگ پس‌زمینه پیش‌فرض
          backgroundColor: const Color(0xFFEEEEEE),
          // تنظیم حاشیه دکمه
          side: const BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
        ).copyWith(
          // تنظیم رنگ پس‌زمینه بر اساس وضعیت دکمه
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            // تغییر رنگ در هنگام hover
            if (states.contains(WidgetState.hovered)) {
              return color;
            }
            // تغییر رنگ در هنگام فشرده شدن (pressed)
            else if (states.contains(WidgetState.pressed)) {
              return color.withOpacity(0.8); // کاهش کمی از شدت رنگ
            }
            // رنگ پیش‌فرض دکمه زمانی که هیچ حالتی فعال نیست
            return Theme.of(context).colorScheme.onSecondary;
          }),
        ),
        label: Text(
          text,
          // استایل متن
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        // زمانی که دکمه فشرده می‌شود
        onPressed: onTap,
      ),
    );
  }
}
