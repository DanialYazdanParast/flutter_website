import 'package:datiego/core/widgets/build_placeholder.dart';
import 'package:datiego/features/blog/presentation/widgets/blog_button.dart';
import 'package:datiego/features/blog/presentation/widgets/blog_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

/// ویجت شایمر دسکتاپ برای نمایش بارگذاری محتوا با افکت شایمر
///
/// این ویجت به‌صورت واکنش‌گرا برای دسکتاپ طراحی شده است و هنگام بارگذاری وبلاگ،
/// از افکت شایمر برای نمایش پیش‌نمایش محتوای وبلاگ استفاده می‌کند.
/// از رنگ‌های متفاوت برای حالت‌های روشن و تاریک پشتیبانی می‌کند.
///
/// ## نکات:
/// - این ویجت از `Shimmer.fromColors` برای ایجاد افکت شایمر استفاده می‌کند.
/// - در حالت‌های مختلف تم (تاریک و روشن) از رنگ‌های متفاوت برای شایمر و پس‌زمینه استفاده می‌شود.
/// - از `AspectRatio` برای حفظ تناسب ویجت و از `Row` و `Column` برای چیدمان استفاده شده است.
/// - از `BlogButton` برای شبیه‌سازی دکمه "Read More" در وضعیت بارگذاری استفاده شده است.
///
/// ## مثال استفاده:
/// ```dart
/// const BlogDesktopShimmer()
/// ```
///
/// ## ساختار:
/// - `AspectRatio`: برای تنظیم نسبت ابعاد و حفظ فرم مناسب استفاده می‌شود.
/// - `Shimmer.fromColors`: برای ایجاد افکت شایمر با رنگ‌های پایه و هایلایت تعریف شده است.
/// - `BlogContainer`: به‌عنوان کادر برای محتوا استفاده می‌شود.
/// - `BlogButton`: دکمه‌ای با عنوان "Read More" در پایین صفحه.
class BlogDesktopShimmer extends StatelessWidget {
  const BlogDesktopShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // بررسی حالت تم تاریک یا روشن
    final bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;

    return AspectRatio(
        aspectRatio: 2, // تنظیم نسبت ابعاد
        child: BlogContainer(
          child: Shimmer.fromColors(
            // رنگ‌های شایمر برای حالت‌های مختلف تم
            baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            highlightColor: isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
            child: Row(
              children: [
                // بخش اول که یک کادر بزرگ است
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.black54 : Colors.white,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(32)), // گوشه‌های گرد
                    ),
                  ),
                ),
                // بخش دوم که شامل اطلاعات وبلاگ است
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // شایمر برای عنوان وبلاگ

                              buildPlaceholder(
                                  width: 150,
                                  height: 24,
                                  isDarkMode: isDarkMode), // عنوان.
                              const SizedBox(height: 16),
                              // شایمر برای قسمت توضیحات

                              buildPlaceholder(
                                  width: double.infinity,
                                  height: 16,
                                  isDarkMode: isDarkMode),
                              const SizedBox(height: 5),
                              // شایمر برای قسمت توضیحات بیشتر

                              buildPlaceholder(
                                  width: 350,
                                  height: 16,
                                  isDarkMode: isDarkMode),

                              const SizedBox(height: 5),
                              buildPlaceholder(
                                  width: 200,
                                  height: 16,
                                  isDarkMode: isDarkMode),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        // دکمه "Read More" که به‌صورت شایمر نمایش داده می‌شود
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ButtonWidget(
                            color: isDarkMode ? Colors.black54 : Colors.white,
                            text: "Read More",
                            onTap: () {}, // عملکرد دکمه به طور موقت خالی است
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
                begin: 0.2, // شروع انیمیشن از پایین
                end: 0, // پایان در موقعیت معمولی
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut) // انیمیشن با حرکت نرم
            .fadeIn()); // انیمیشن فید این
  }
}
