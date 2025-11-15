import 'dart:ui';

import 'package:datiego/confing/theme/app_theme.dart';
import 'package:datiego/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:datiego/core/common/bottom_navigation_item.dart';
import 'package:datiego/core/common/root.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:datiego/core/constants/app_constants.dart';
import 'package:datiego/core/services/url_launcher_service.dart';
import 'package:datiego/core/widgets/custom_border.dart';
import 'package:datiego/core/widgets/custom_box_shadow.dart';

/// ویجت نوار پایینی (Bottom Navigation) برای برنامه.
///
/// این ویجت شامل چندین آیتم ناوبری است که کاربر می‌تواند بین آن‌ها جابه‌جا شود.
/// همچنین شامل لینک‌هایی برای ارسال ایمیل و باز کردن پروفایل‌های GitHub و LinkedIn است.
///
/// ## مثال استفاده:
/// ```dart
/// BottomNavigattion(
///   onTab: (index) {
///     // عملکرد تغییر تب
///   },
///   selextedIndex: 0, // ایندکس تب انتخاب‌شده
/// )
/// ```
///
/// ## پارامترها:
/// - `onTab`: تابعی که هنگام کلیک روی آیتم‌ها فراخوانی می‌شود.
/// - `selextedIndex`: ایندکس تب انتخاب‌شده.
///
/// ## نکات:
/// - از `BottomNavigationItem` برای نمایش آیتم‌ها استفاده می‌شود.
/// - لینک‌های ایمیل، GitHub و LinkedIn با استفاده از `UrlLauncherService` باز می‌شوند.
/// - در حالت دسکتاپ، لینک‌های GitHub و LinkedIn نمایش داده می‌شوند.
class BottomNavigattion extends StatelessWidget {
  final Function(int index) onTab;
  final int selextedIndex;

  const BottomNavigattion({
    super.key,
    required this.onTab,
    required this.selextedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final urlLauncher = GetIt.instance<UrlLauncherService>();

    // ایجاد تم براساس وضعیت
    final themeConfig = MyAppThemeConfig.of(context);
    return Stack(
      children: [
        // BackdropFilter برای مات کردن پس‌زمینه
        Positioned.fill(
          bottom: 22,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(color: Colors.transparent),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 22),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(24),
              boxShadow: customBoxShadow,
              border: customBorder(context),
            ),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 12,
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BottomNavigationItem(
                    label: 'Home',
                    iconFileName: Icons.home_outlined,
                    isActive: selextedIndex == TabItem.home.index,
                    color: themeConfig.peach,
                    onTap: () {
                      onTab(TabItem.home.index);
                    },
                  ),
                  const SizedBox(width: 12),
                  BottomNavigationItem(
                    label: 'Projects',
                    iconFileName: Icons.code,
                    isActive: selextedIndex == TabItem.projects.index,
                    color: themeConfig.purple,
                    onTap: () {
                      onTab(TabItem.projects.index);
                    },
                  ),
                  const SizedBox(width: 12),
                  BottomNavigationItem(
                    label: 'Blog',
                    iconFileName: Icons.article_outlined,
                    isActive: selextedIndex == TabItem.blog.index,
                    color: themeConfig.coral,
                    onTap: () {
                      onTab(TabItem.blog.index);
                    },
                  ),
                  const SizedBox(width: 12),
                  BottomNavigationItem(
                    label: 'About Me',
                    iconFileName: Icons.account_circle_outlined,
                    isActive: selextedIndex == TabItem.about.index,
                    color: themeConfig.blue,
                    onTap: () {
                      onTab(TabItem.about.index);
                    },
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 2,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  BottomNavigationItem(
                    label: 'danialyazdan77@gmail.com',
                    iconFileName: Icons.email_outlined,
                    color: themeConfig.green,
                    isActive: false,
                    isIcon: true,
                    onTap: () async {
                      await urlLauncher.sendEmail(AppConstants.emailUrl);
                    },
                  ),
                  if (Responsive.isDesktop(context))
                    Row(
                      children: [
                        const SizedBox(width: 12),
                        BottomNavigationItem(
                          label: '@DanialYazdanParast',
                          iconFileName: FontAwesomeIcons.github,
                          color: themeConfig.gray,
                          isActive: false,
                          isIcon: true,
                          onTap: () async {
                            await urlLauncher.openUrl(AppConstants.gitHubUrl);
                          },
                        ),
                        const SizedBox(width: 12),
                        BottomNavigationItem(
                          label: '@DanialYazdanParast',
                          iconFileName: FontAwesomeIcons.linkedin,
                          color: themeConfig.skyBlue,
                          isActive: false,
                          isIcon: true,
                          onTap: () async {
                            await urlLauncher.openUrl(AppConstants.linkedinUrl);
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
