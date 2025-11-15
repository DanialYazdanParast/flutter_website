
import 'package:datiego/features/blog/domain/entities/blog_entities.dart';
import 'package:datiego/features/error/error_screen.dart';
import 'package:datiego/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:datiego/core/common/root.dart';
import 'package:datiego/features/shared/domain/entities/projects_entities.dart';
import 'package:flutter/material.dart';
// Deferred imports با نام‌های منحصربه‌فرد برای جلوگیری از shadowing با const ها
import 'package:datiego/features/about_me/presentation/screens/about_me_screen.dart'
    deferred as lazyAbout;
import 'package:datiego/features/blog/presentation/screens/blog_screen.dart'
    deferred as lazyBlog;
import 'package:datiego/features/blog_detail/presentation/screens/blog_detail_screen.dart'
    deferred as lazyBlogDetail;
import 'package:datiego/features/project_detail/presentation/screens/project_detail_screen.dart'
    deferred as lazyProjectDetail;
import 'package:datiego/features/projects/presentation/screens/projects_screen.dart'
    deferred as lazyProjects;

/// **📌 ScreenGoRouter - مدیریت مسیرهای ناوبری در برنامه**
///
/// این کلاس تمامی مسیرهای برنامه را مدیریت می‌کند و از `GoRouter` برای ناوبری بین صفحات استفاده می‌کند.

/// **🔗 کلاس مدیریت مسیرها در برنامه**
class ScreenGoRouter {
  /// **🏠 مسیر صفحه اصلی**
  static const home = '/';

  /// **📂 مسیر صفحه پروژه‌ها**
  static const projects = '/projects';

  /// **📑 مسیر جزئیات پروژه (با عنوان پروژه به عنوان پارامتر)**
  static const detailProjects = ':title';

  /// **📝 مسیر صفحه وبلاگ**
  static const blog = '/blog';

  /// **ℹ️ مسیر صفحه درباره من**
  static const aboutRoute =
      '/about'; // تغییر نام به aboutRoute برای جلوگیری از تداخل احتمالی

  /// **📖 مسیر جزئیات وبلاگ (با عنوان مقاله به عنوان پارامتر)**
  static const detailBlog = ':title';

  /// **🚀 تعریف `GoRouter` برای مدیریت مسیرهای برنامه**
  static GoRouter router = GoRouter(
    initialLocation: ScreenGoRouter.home, // مسیر پیش‌فرض: صفحه اصلی
    errorBuilder: (context, state) {
      // **صفحه خطای 404** - برای آدرس‌های اشتباه (به عنوان Widget برمی‌گردونه)
      return const ErrorScreen();
    },
    routes: [
      /// **🛠️ `ShellRoute` - صفحه پایه‌ای با `BottomNavigation`**
      ShellRoute(
        builder: (context, state, child) {
          return RootScreen(
            child: child,
          ); // `RootScreen` شامل `BottomNavigation`
        },
        routes: [
          /// **🏠 مسیر صفحه اصلی**
          GoRoute(
            path: ScreenGoRouter.home,
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: HomeScreen());
            },
          ),

          /// **📂 مسیر صفحه پروژه‌ها**
          GoRoute(
            path: ScreenGoRouter.projects,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: _LazyBuilder(
                  loadFuture: lazyProjects.loadLibrary(),
                  builder: (context) => lazyProjects.ProjectsScreen(),
                ),
              );
            },
            routes: [
              /// **📑 مسیر جزئیات پروژه**
              GoRoute(
                path: ScreenGoRouter.detailProjects,
                pageBuilder: (context, state) {
                  final project =
                      state.extra
                          as ProjectsEntities?; // دریافت داده `project` از `extra`
                  return NoTransitionPage(
                    child: _LazyBuilderWithData<ProjectsEntities>(
                      loadFuture: lazyProjectDetail.loadLibrary(),
                      data: project,
                      builder:
                          (context, projectData) =>
                              lazyProjectDetail.ProjectDetailScreen(
                                project: projectData!,
                              ),
                    ),
                  );
                },
              ),
            ],
          ),

          /// **📝 مسیر صفحه وبلاگ**
          GoRoute(
            path: ScreenGoRouter.blog,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: _LazyBuilder(
                  loadFuture: lazyBlog.loadLibrary(),
                  builder: (context) => lazyBlog.BlogScreen(),
                ),
              );
            },
            routes: [
              /// **📖 مسیر جزئیات مقاله در وبلاگ**
              GoRoute(
                path: ScreenGoRouter.detailBlog,
                pageBuilder: (context, state) {
                  final blogEntity = state.extra as BlogEntities?;
                  return NoTransitionPage(
                    child: _LazyBuilderWithData<BlogEntities>(
                      loadFuture: lazyBlogDetail.loadLibrary(),
                      data: blogEntity,
                      builder:
                          (context, blogData) =>
                              lazyBlogDetail.BlogDetailScreen(blog: blogData!),
                    ),
                  );
                },
              ),
            ],
          ),

          /// **ℹ️ مسیر صفحه درباره من**
          GoRoute(
            path: ScreenGoRouter.aboutRoute,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: _LazyBuilder(
                  loadFuture: lazyAbout.loadLibrary(),
                  builder: (context) => lazyAbout.AboutMeScreen(),
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}

/// **ویجت کمکی برای Lazy Loading با داده اضافی (مثل project یا blog)**
class _LazyBuilderWithData<T> extends StatelessWidget {
  final Future<dynamic> loadFuture;
  final T? data;
  final Widget Function(BuildContext, T?) builder;

  const _LazyBuilderWithData({
    required this.loadFuture,
    required this.data,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: loadFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('خطا در بارگذاری: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () => context.go(ScreenGoRouter.home),
                    // بازگشت به home در صورت خطا
                    child: const Text('تلاش مجدد'),
                  ),
                ],
              ),
            ),
          );
        }
        return builder(context, data);
      },
    );
  }
}



/// **ویجت کمکی برای Lazy Loading بدون داده اضافی**
class _LazyBuilder extends StatelessWidget {
  final Future<dynamic> loadFuture;
  final Widget Function(BuildContext) builder;

  const _LazyBuilder({required this.loadFuture, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: loadFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('خطا در بارگذاری: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () => context.go(ScreenGoRouter.home),
                    // بازگشت به home در صورت خطا
                    child: const Text('تلاش مجدد'),
                  ),
                ],
              ),
            ),
          );
        }
        return builder(context);
      },
    );
  }
}