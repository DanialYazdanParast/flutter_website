import 'package:datiego/core/router/go_router.dart';
import 'package:datiego/core/widgets/image_loding_service.dart';
import 'package:datiego/core/widgets/text_subtitle.dart';
import 'package:datiego/core/widgets/text_title.dart';
import 'package:datiego/features/blog/domain/entities/blog_entities.dart';
import 'package:datiego/features/blog/presentation/widgets/blog_button.dart';
import 'package:datiego/features/blog/presentation/widgets/blog_container.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

/// ویجت دسکتاپ برای نمایش جزئیات وبلاگ
///
/// این ویجت به‌صورت واکنش‌گرا برای صفحه نمایش‌های بزرگ (دسکتاپ) طراحی شده است.
/// اطلاعات وبلاگ شامل عنوان، زیرعنوان و تصویر آن نمایش داده می‌شود. همچنین، دکمه "Read More" برای نمایش جزئیات بیشتر وجود دارد.
/// در هنگام کلیک روی دکمه، کاربر به صفحه جزئیات وبلاگ هدایت می‌شود.
///
/// ## نکات:
/// - این ویجت از `AspectRatio` برای تنظیم ابعاد ویجت استفاده می‌کند.
/// - از `BlogContainer` برای قرار دادن محتوای وبلاگ داخل یک کادر با گوشه‌های گرد استفاده می‌شود.
/// - تصویر وبلاگ با استفاده از `ImageLodingService` بارگذاری می‌شود.
/// - برای نمایش عنوان و زیرعنوان وبلاگ، از ویجت‌های `TextTitle` و `TextSubtitle` استفاده شده است.
/// - دکمه "Read More" پس از کلیک، کاربر را به صفحه جزئیات وبلاگ هدایت می‌کند.
///
/// ## مثال استفاده:
/// ```dart
/// const BlogDesktop(blogColor: Colors.blue, blog: blog)
/// ```
class BlogDesktop extends StatelessWidget {
  /// رنگ اختصاصی برای کادر یا دکمه وبلاگ
  final Color blogColor;

  /// شیء مدل وبلاگ که حاوی اطلاعات وبلاگ است
  final BlogEntities blog;

  const BlogDesktop({
    super.key,
    required this.blogColor,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 2, // تنظیم نسبت ابعاد ویجت
        child: BlogContainer(
          child: Row(
            children: [
              // بخش اول: نمایش تصویر وبلاگ
              Expanded(
                child: ImageLodingService(
                  imageUrl: blog.image, // آدرس تصویر وبلاگ
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(32)),
                ),
              ),
              // بخش دوم: نمایش جزئیات وبلاگ
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
                            // عنوان وبلاگ
                            TextTitle(title: blog.title),
                            const SizedBox(height: 16),
                            // زیرعنوان وبلاگ
                            Expanded(
                              child: TextSubtitle(
                                subtitle: blog.subtitle,
                                maxLines: 100, // محدود کردن تعداد خطوط
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      // دکمه "Read More"
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ButtonWidget(
                          color: blogColor, // رنگ دکمه
                          text: "Read More", // متن دکمه
                          onTap: () {
                            // هدایت به صفحه جزئیات وبلاگ
                            final encodedTitle =
                                Uri.encodeComponent(blog.title);
                            context.go(
                              '${ScreenGoRouter.blog}/$encodedTitle', // مسیری که کاربر به آن هدایت می‌شود
                              extra: blog, // ارسال شیء وبلاگ به صفحه جدید
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
