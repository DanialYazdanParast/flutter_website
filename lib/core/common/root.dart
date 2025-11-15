import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:datiego/core/common/bottom_navigattion.dart';
import 'package:datiego/core/router/go_router.dart';

/// **تعریف تب‌های اپلیکیشن**
/// این تب‌ها شامل خانه، پروژه‌ها، وبلاگ و درباره ما هستند.
enum TabItem { home, projects, blog, about }

/// **تعریف مسیرهای مرتبط با هر تب**
const Map<TabItem, String> tabRoutes = {
  TabItem.home: ScreenGoRouter.home,
  TabItem.projects: ScreenGoRouter.projects,
  TabItem.blog: ScreenGoRouter.blog,
  TabItem.about: ScreenGoRouter.aboutRoute,
};

/// **کلاس RootScreen**
/// این کلاس صفحه‌ی اصلی برنامه را مدیریت می‌کند و شامل `BottomNavigation` برای جابه‌جایی بین تب‌ها است.
class RootScreen extends StatefulWidget {
  /// `child` محتوای صفحه‌ای است که در حال حاضر نمایش داده می‌شود.
  final Widget child;

  const RootScreen({super.key, required this.child});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  /// **تب انتخاب شده فعلی**
  /// مقدار پیش‌فرض آن `home` است.
  TabItem _selectedTab = TabItem.home;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSelectedTab();
  }

  /// **به‌روزرسانی تب انتخاب شده بر اساس مسیر فعلی**
  void _updateSelectedTab() {
    final GoRouterState state = GoRouterState.of(context);
    final String location = state.uri.toString();

    setState(() {
      if (location == tabRoutes[TabItem.home]) {
        _selectedTab = TabItem.home;
      } else if (location.startsWith(tabRoutes[TabItem.projects]!)) {
        _selectedTab = TabItem.projects;
      } else if (location.startsWith(tabRoutes[TabItem.blog]!)) {
        _selectedTab = TabItem.blog;
      } else if (location.startsWith(tabRoutes[TabItem.about]!)) {
        _selectedTab = TabItem.about;
      }
    });
  }

  /// **انتخاب تب جدید و تغییر مسیر اپلیکیشن**
  void _onTabSelected(TabItem tabItem) {
    context.go(tabRoutes[tabItem]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          /// **نمایش محتوای صفحه فعلی**
          Positioned.fill(
            child: widget.child,
          ),

          /// **نمایش `BottomNavigation` در پایین صفحه**
          Positioned(
            bottom: 0,
            child: BottomNavigattion(
              selextedIndex: _selectedTab.index,
              onTab: (index) {
                _onTabSelected(TabItem.values[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
