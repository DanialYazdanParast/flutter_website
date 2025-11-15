import 'package:datiego/core/di/service_locator.dart';
import 'package:datiego/core/utils/responsive.dart';
import 'package:datiego/core/widgets/custom_scrollbar.dart';
import 'package:datiego/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:datiego/features/blog/presentation/widgets/blog_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحه‌ی "وبلاگ" که به صورت واکنش‌گرا برای دستگاه‌های موبایل و دسکتاپ طراحی شده است.
///
/// این صفحه از `BlogBloc` برای مدیریت وضعیت و دریافت داده‌های وبلاگ استفاده می‌کند.
/// همچنین از `CustomScrollbar` و `CustomScrollView` برای نمایش اسکرول‌بار و محتوای وبلاگ استفاده شده است.
///
/// ## مثال استفاده:
/// ```dart
/// const BlogScreen()
/// ```
///
/// ## نکات:
/// - از `BlocProvider` برای ارائه `BlogBloc` به درخت ویجت‌ها استفاده می‌شود.
/// - `BlogBloc` با رویداد `GetBlogEvent` مقداردهی می‌شود تا داده‌های وبلاگ را دریافت کند.
/// - `Scrollbar` فقط در حالت دسکتاپ نمایش داده می‌شود.
/// - `BlogContent` برای نمایش محتوای وبلاگ بر اساس وضعیت `BlogState` استفاده می‌شود.
/// - پدینگ افقی به صورت واکنش‌گرا تنظیم می‌شود (۵٪ عرض صفحه برای موبایل و ۱۳٪ برای دسکتاپ).
class BlogScreen extends StatefulWidget {
   const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // آزادسازی کنترلر اسکرول
    super.dispose();
  }

  /// محاسبه پدینگ افقی بر اساس نوع دستگاه
  EdgeInsets get _horizontalPadding {
    final screenWidth = MediaQuery.of(context).size.width;
    return EdgeInsets.symmetric(
      horizontal: Responsive.isMobile(context)
          ? screenWidth * 0.05 // ۵٪ عرض صفحه برای موبایل
          : screenWidth * 0.13, // ۱۳٪ عرض صفحه برای دسکتاپ
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        // ایجاد و ارائه `BlogBloc` به درخت ویجت‌ها
        create: (context) => BlogBloc(getIt.get())..add(GetBlogEvent()),
        child: CustomScrollbar(
          controller: _scrollController,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverPadding(
                  padding: EdgeInsets.only(top: 30)), // فاصله بالایی
              SliverPadding(
                padding: _horizontalPadding, // پدینگ افقی واکنش‌گرا
                sliver: BlocBuilder<BlogBloc, BlogState>(
                  builder: (context, state) {
                    return BlogContent(
                      state: state, // نمایش محتوای وبلاگ بر اساس وضعیت
                    );
                  },
                ),
              ),
              const SliverPadding(
                  padding: EdgeInsets.only(top: 120)), // فاصله پایینی
            ],
          ),
        ),
      ),
    );
  }
}
