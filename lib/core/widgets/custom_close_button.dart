import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:datiego/core/widgets/custom_border.dart';

/// یک ویجت دکمه بستن (Close) سفارشی که با کلیک روی آن، صفحه فعلی بسته می‌شود.
///
/// این دکمه از `GestureDetector` برای تشخیص کلیک و `GoRouter` برای بستن صفحه استفاده می‌کند.
/// همچنین دارای یک آیکون `close` و استایل‌های سفارشی مانند رنگ پس‌زمینه، حاشیه و شعاع گوشه‌ها است.
///
/// مثال استفاده:
/// ```dart
/// CustomCloseButton();
/// ```
class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // بستن صفحه فعلی با استفاده از GoRouter
        context.pop();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            height: 48, // ارتفاع دکمه
            width: 48, // عرض دکمه
            padding: const EdgeInsets.all(8), // padding داخلی
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary, // رنگ پس‌زمینه
              borderRadius: BorderRadius.circular(12), // شعاع گوشه‌ها
              border: customBorder(context), // حاشیه سفارشی
            ),
            child: Icon(
              Icons.close, // آیکون بستن
              color: Theme.of(context).iconTheme.color, // رنگ آیکون
              size: 25, // اندازه آیکون
            ),
          ),
        ),
      ),
    );
  }
}
