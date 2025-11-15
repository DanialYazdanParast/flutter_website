import 'package:datiego/core/widgets/build_placeholder.dart';
import 'package:datiego/features/blog/presentation/widgets/blog_button.dart';
import 'package:datiego/features/blog/presentation/widgets/blog_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

/// ویجت شیمر برای نمایش حالت بارگذاری وبلاگ در نسخه موبایل
///
/// این ویجت به‌عنوان یک شیمر برای نمایش حالت بارگذاری اطلاعات وبلاگ طراحی شده است.
/// به‌طور خاص برای صفحات موبایل طراحی شده است. در این ویجت، تمام بخش‌های وبلاگ شامل تصویر،
/// عنوان، زیرعنوان، و دکمه "Read More" به‌صورت شیمر نمایش داده می‌شوند تا تجربه کاربری بهتری
/// برای کاربران در هنگام بارگذاری محتوای وبلاگ فراهم شود.
///
/// ## نکات:
/// - این ویجت از `IntrinsicHeight` برای تنظیم ارتفاع خود استفاده می‌کند.
/// - برای شبیه‌سازی بارگذاری اطلاعات از `Shimmer.fromColors` استفاده شده است.
/// - از `BlogContainer` برای قرار دادن محتوای وبلاگ در یک کادر با گوشه‌های گرد استفاده می‌شود.
/// - در نهایت از انیمیشن‌های `flutter_animate` برای افزودن انیمیشن به نمایش شیمر استفاده می‌شود.
///
/// ## مثال استفاده:
/// ```dart
/// const BlogMobileShimmer()
/// ```
class BlogMobileShimmer extends StatelessWidget {
  const BlogMobileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // دریافت ارتفاع صفحه برای تنظیم اندازه تصویر
    final screenHeight = MediaQuery.of(context).size.height;

    // بررسی وضعیت حالت تیره (Dark Mode)
    final bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;

    return IntrinsicHeight(
        child: BlogContainer(
      child: Shimmer.fromColors(
        // تنظیم رنگ‌های شیمر بر اساس حالت تم (روشن یا تیره)
        baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
        highlightColor: isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
        child: Column(
          children: [
            // بخش تصویر وبلاگ
            Container(
              height: screenHeight * 0.4, // تنظیم ارتفاع تصویر
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black54 : Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(32)),
              ),
            ),
            // بخش جزئیات وبلاگ
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // شیمر برای عنوان وبلاگ

                    buildPlaceholder(
                        width: 150, height: 24, isDarkMode: isDarkMode),

                    const SizedBox(height: 16),
                    // شیمر برای زیرعنوان وبلاگ

                    buildPlaceholder(
                        width: double.infinity,
                        height: 16,
                        isDarkMode: isDarkMode),
                    const SizedBox(height: 5),
                    // شیمر برای اولین خط از متن

                    buildPlaceholder(
                        width: 350, height: 16, isDarkMode: isDarkMode),
                    const SizedBox(height: 5),
                    // شیمر برای دومین خط از متن
                    buildPlaceholder(
                        width: 200, height: 16, isDarkMode: isDarkMode),
                    const SizedBox(height: 10),
                    // دکمه "Read More"
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ButtonWidget(
                        color: isDarkMode ? Colors.black54 : Colors.white,
                        text: "Read More",
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
            .animate()
            .slideY(
                begin: 0.2, // شروع از موقعیت کمی پایین‌تر
                end: 0, // پایان در موقعیت اصلی
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut) // تنظیم انیمیشن به صورت نرم و روان
            .fadeIn()); // افزودن انیمیشن fade
  }
}
