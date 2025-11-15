import 'package:datiego/core/widgets/custom_scrollbar.dart';
import 'package:datiego/core/widgets/description_widget.dart';
import 'package:datiego/core/widgets/text_title.dart';
import 'package:datiego/features/blog/domain/entities/blog_entities.dart';
import 'package:datiego/core/widgets/custom_close_button.dart';
import 'package:datiego/core/widgets/image_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// صفحه جزئیات مطلب بلاگ
/// این کلاس یک صفحه فلاتر است که جزئیات یک مطلب بلاگ را نمایش می‌دهد.
/// شامل تصویر، عنوان، و توضیحات مطلب است و از انیمیشن‌ها و طراحی واکنش‌گرا برای بهبود تجربه کاربری استفاده می‌کند.
class BlogDetailScreen extends StatefulWidget {
  /// سازنده کلاس [BlogDetailScreen]
  ///
  /// - [blog]: داده‌های مربوط به مطلب بلاگ که شامل تصویر، عنوان و توضیحات است.
  const BlogDetailScreen({super.key, required this.blog});

  final BlogEntities blog;

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  /// حاشیه افقی پیش‌فرض برای المان‌های صفحه.
  double horizontalPadding = 20.0;

  /// کنترل‌کننده اسکرول برای مدیریت حرکت در صفحه.
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    /// آزادسازی منابع مرتبط با کنترل‌کننده اسکرول.
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// دریافت عرض صفحه برای تنظیم حاشیه‌ها به صورت واکنش‌گرا.
    final screenWidth = MediaQuery.of(context).size.width;

    /// تنظیم حاشیه افقی بر اساس عرض صفحه:
    /// - اگر عرض صفحه بیشتر از 1200 پیکسل باشد، حاشیه 18% عرض صفحه خواهد بود.
    /// - در غیر این صورت، حاشیه پیش‌فرض (20 پیکسل) استفاده می‌شود.
    final horizontalPadding = screenWidth > 1200 ? screenWidth * 0.18 : 20.0;

    return Scaffold(
      body: CustomScrollbar(
        controller: scrollController,
        child: Stack(
          alignment:
              Alignment.topCenter, // هم‌ترازی المان‌ها در مرکز بالای صفحه.
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: TweenAnimationBuilder<EdgeInsets>(
                    duration:
                        const Duration(milliseconds: 500), // مدت زمان انیمیشن.
                    tween: Tween<EdgeInsets>(
                      end: EdgeInsets.only(
                        top: 88,
                        left: horizontalPadding, // حاشیه افقی پایان.
                        right: horizontalPadding,
                        bottom: 120,
                      ),
                    ),
                    builder: (context, padding, child) {
                      return Padding(
                        padding: padding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // هم‌ترازی المان‌ها از سمت چپ.
                          children: [
                            ImageDetail(
                                imageUrl:
                                    widget.blog.image), // نمایش تصویر مطلب.
                            const SizedBox(
                                height: 16), // فاصله عمودی بین تصویر و عنوان.
                            TextTitle(
                                title: widget.blog.title), // نمایش عنوان مطلب.
                            const SizedBox(
                                height: 24), // فاصله عمودی بین عنوان و توضیحات.
                            DescriptionWidget(
                                description: widget
                                    .blog.description), // نمایش توضیحات مطلب.
                          ],
                        )
                            .animate() // اضافه کردن انیمیشن به المان‌ها.
                            .slideY(
                                begin: 0.2,
                                end: 0,
                                curve: Curves.easeOut) // انیمیشن حرکت عمودی.
                            .fadeIn(), // انیمیشن ظهور تدریجی.
                      );
                    },
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 20,
              child: CustomCloseButton(), // دکمه بستن در بالای صفحه.
            ),
          ],
        ),
      ),
    );
  }
}
