import 'package:datiego/core/router/go_router.dart';
import 'package:datiego/core/widgets/image_loding_service.dart';
import 'package:datiego/core/widgets/text_subtitle.dart';
import 'package:datiego/core/widgets/text_title.dart';
import 'package:datiego/features/blog/domain/entities/blog_entities.dart';
import 'package:datiego/features/blog/presentation/widgets/blog_button.dart';
import 'package:datiego/features/blog/presentation/widgets/blog_container.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

/// ویجت برای نمایش محتوای وبلاگ در نسخه موبایل
///
/// این ویجت برای نمایش محتوای وبلاگ در اندازه موبایل طراحی شده است. اطلاعاتی مانند تصویر وبلاگ،
/// عنوان، زیرعنوان و دکمه "Read More" را به‌صورت مناسب برای صفحات موبایل نمایش می‌دهد.
///
/// - این ویجت از `IntrinsicHeight` برای تنظیم خودکار ارتفاع استفاده می‌کند.
/// - تصویر وبلاگ به‌صورت داینامیک بارگذاری می‌شود.
/// - عنوان و زیرعنوان به‌صورت متنی نمایش داده می‌شوند.
/// - از `BlogButton` برای افزودن دکمه "Read More" استفاده شده است که کاربر را به صفحه وبلاگ می‌برد.
///
/// ## نکات:
/// - این ویجت طراحی شده است تا برای اندازه‌های صفحه‌نمایش موبایل بهینه باشد.
/// - از `ImageLodingService` برای بارگذاری تصویر استفاده می‌شود که تصویر را با گوشه‌های گرد نمایش می‌دهد.
/// - از `TextTitle` برای نمایش عنوان وبلاگ و از `TextSubtitle` برای نمایش زیرعنوان استفاده می‌شود.
///
/// ## مثال استفاده:
/// ```dart
/// const BlogMobile(blogColor: Colors.blue, blog: myBlog)
/// ```
class BlogMobile extends StatelessWidget {
  final Color blogColor; // رنگ مورد استفاده برای دکمه "Read More"

  final BlogEntities blog; // اطلاعات وبلاگ شامل عنوان، زیرعنوان و تصویر

  const BlogMobile({
    super.key,
    required this.blogColor,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    // دریافت ارتفاع صفحه برای تنظیم اندازه تصویر
    final screenHeight = MediaQuery.of(context).size.height;

    return IntrinsicHeight(
      child: BlogContainer(
        child: Column(
          children: [
            // بخش تصویر وبلاگ
            SizedBox(
              height: screenHeight * 0.4, // تنظیم ارتفاع تصویر
              width: double.infinity,
              child: ImageLodingService(
                imageUrl: blog.image, // آدرس تصویر وبلاگ
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32)), // گوشه‌های گرد
              ),
            ),
            // بخش جزئیات وبلاگ
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // نمایش عنوان وبلاگ
                    TextTitle(title: blog.title),
                    const SizedBox(height: 16),
                    // نمایش زیرعنوان وبلاگ
                    Expanded(
                      child: TextSubtitle(
                        subtitle: blog.subtitle, // نمایش زیرعنوان
                        maxLines: 8, // تعداد حداکثر خطوط برای نمایش زیرعنوان
                      ),
                    ),
                    const SizedBox(height: 10),
                    // دکمه "Read More"
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ButtonWidget(
                        color: blogColor, // رنگ دکمه
                        text: "Read More", // متن دکمه
                        onTap: () {
                          // کد برای هدایت کاربر به صفحه وبلاگ
                          final encodedTitle = Uri.encodeComponent(blog.title);
                          context.go(
                            '${ScreenGoRouter.blog}/$encodedTitle', // مسیر صفحه وبلاگ
                            extra: blog, // ارسال اطلاعات وبلاگ به صفحه جدید
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
      ),
    );
  }
}
