import 'dart:ui';

import 'package:datiego/confing/theme/app_theme.dart';
import 'package:datiego/core/router/go_router.dart';
import 'package:datiego/core/utils/responsive.dart';
import 'package:datiego/core/widgets/custom_border.dart';
import 'package:datiego/core/widgets/custom_box_shadow.dart';
import 'package:datiego/features/blog/presentation/widgets/blog_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بررسی حالت تاریک یا روشن بودن تم.
    final bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                isDarkMode
                    ? [
                      const Color(0x4a3E3B4F), // بنفش تیره نرم
                      const Color(0x4a4A4A6A), // آبی تیره نرم
                      const Color(0x4a3D5A6C), // فیروزه‌ای تیره نرم
                    ]
                    : [
                      const Color(0xFFFFD6E8), // صورتی روشن
                      const Color(0xFFE3E8FF), // آبی روشن
                      const Color(0xFFCFF0D6), // سبز روشن
                    ],
          ),
        ),
        child: Align(
          alignment: AlignmentDirectional.center,
          // ویجت Responsive وظیفه انتخاب بین نسخه‌های مختلف کارت را دارد
          // و انیمیشن *بعد* از انتخاب، روی ویجت نهایی اعمال می‌شود.
          child: const Responsive(
                desktop: _ErrorCard(
                  width: 435,
                  height: 235,
                  titleFontSize: 36,
                  messageFontSize: 28,
                  buttonHeight: 45,
                ),
                mobile: _ErrorCard(
                  width: 290,
                  height: 178,
                  titleFontSize: 26,
                  messageFontSize: 18,
                  buttonHeight: 40,
                ),
              )
              .animate() // انیمیشن *یک بار* روی ویجت خروجی اعمال می‌شود
              .fadeIn(duration: 1000.ms, curve: Curves.easeIn)
              .moveY(
                begin: 50,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOut,
              ),
        ),
      ),
    );
  }
}

/// [_ErrorCard] یک ویجت خصوصی و переиспользуемый است که برای نمایش محتوای کارت خطا طراحی شده.
/// این ویجت پارامترهای مربوط به اندازه و فونت را دریافت می‌کند تا از تکرار کد جلوگیری شود.
class _ErrorCard extends StatelessWidget {
  const _ErrorCard({
    required this.width,
    required this.height,
    required this.titleFontSize,
    required this.messageFontSize,
    required this.buttonHeight,
  });

  final double width;
  final double height;
  final double titleFontSize;
  final double messageFontSize;
  final double buttonHeight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(24),
            // فرض شده customBoxShadow و customBorder متغیرهای سراسری یا استاتیک هستند
            boxShadow: customBoxShadow,
            border: customBorder(context),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // عنوان "404 Error"
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  // فرض شده MyAppThemeConfig در دسترس است
                  color: MyAppThemeConfig.of(context).coral,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '404 Error',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: titleFontSize, // استفاده از پارامتر ورودی
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // متن اصلی خطا
              Text(
                'Oops. Looks like you\'re in the wrong end of the neighborhood!',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: messageFontSize, // استفاده از پارامتر ورودی
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // دکمه "Back Home"
              SizedBox(
                height: buttonHeight, // استفاده از پارامتر ورودی
                child: ButtonWidget(
                  color: MyAppThemeConfig.of(context).green,
                  text: 'Back Home',
                  // فرض شده ScreenGoRouter در دسترس است
                  onTap: () => context.go(ScreenGoRouter.home),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
