import 'dart:ui';
import 'package:datiego/confing/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datiego/core/constants/app_constants.dart';
import 'package:datiego/core/widgets/custom_border.dart';
import 'package:datiego/core/widgets/custom_box_shadow.dart';
import 'package:datiego/features/home/presentation/bloc/home_bloc.dart';

/// بخش معرفی در صفحه اصلی.
///
/// این کلاس یک ویجت است که بخش معرفی را نمایش می‌دهد. این بخش شامل اطلاعات مقدماتی درباره کاربر (مانند نام، حرفه و لینک دانلود رزومه) است.
/// از انیمیشن‌ها و طراحی واکنش‌گرا برای بهبود تجربه کاربری استفاده شده است.
///
/// ## پارامترها:
/// - [height]: ارتفاع بخش معرفی.
/// - [width]: عرض بخش معرفی.
/// - [fontSize]: اندازه فونت متن.
/// - [sizeimage]: اندازه تصویر (در صورت وجود).
///
/// ## قابلیت‌های کلیدی:
/// - استفاده از `BackdropFilter` برای ایجاد افکت مات (Blur) در پس‌زمینه.
/// - استفاده از `MouseRegion` برای تشخیص حرکت ماوس و به‌روزرسانی حالت BLoC.
/// - نمایش سه ردیف متن با استفاده از `_buildIntroRow` که شامل متن معمولی و بخش‌های برجسته (Highlight) است.
/// - اضافه کردن انیمیشن‌های ظهور و حرکت برای جذابیت بصری.
class IntroSection extends StatelessWidget {
  /// سازنده کلاس [IntroSection]
  ///
  /// - [height]: ارتفاع بخش معرفی.
  /// - [width]: عرض بخش معرفی.
  /// - [fontSize]: اندازه فونت متن.
  /// - [sizeimage]: اندازه تصویر (در صورت وجود).
  const IntroSection({
    super.key,
    required this.height,
    required this.width,
    required this.fontSize,
    required this.sizeimage,
  });

  final double height;
  final double width;
  final double fontSize;
  final double sizeimage;

  @override
  Widget build(BuildContext context) {
    // دریافت تنظیمات تم از `MyAppThemeConfig`.
    final themeConfig = MyAppThemeConfig.of(context);

    return MouseRegion(
          onEnter:
              (_) => context.read<HomeBloc>().add(
                const SetMouseRegionEvent(true),
              ), // فعال‌سازی حالت ماوس.
          onExit:
              (_) => context.read<HomeBloc>().add(
                const SetMouseRegionEvent(false),
              ), // غیرفعال‌سازی حالت ماوس.
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24), // گردی گوشه‌ها.
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ), // افکت مات (Blur).
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.onPrimary, // رنگ پس‌زمینه.
                  borderRadius: BorderRadius.circular(24), // گردی گوشه‌ها.
                  boxShadow: customBoxShadow, // سایه‌های سفارشی.
                  border: customBorder(context), // حاشیه‌های سفارشی.
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10), // فاصله داخلی.
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround, // هم‌ترازی عمودی.
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // هم‌ترازی افقی.
                    children: [
                      _buildIntroRow(
                        'Hi, I\'m',
                        // متن معمولی.
                        'datiego',
                        // بخش برجسته.
                        themeConfig.purple,
                        // رنگ بخش برجسته.
                        context,
                        true,
                        // نمایش تصویر.
                        fontSize,
                        sizeimage,
                      ),
                      _buildIntroRow(
                        'I\'m a',
                        // متن معمولی.
                        'Flutter Developer',
                        // بخش برجسته.
                        themeConfig.blue,
                        // رنگ بخش برجسته.
                        context,
                        false,
                        // عدم نمایش تصویر.
                        fontSize,
                        sizeimage,
                      ),
                      InkWell(
                        onTap: () {
                          // رویداد دانلود رزومه.
                          context.read<HomeBloc>().add(
                            DownloadFileEvent(
                              url: AppConstants.urlCv,
                              fileName: "Danial-YazdanParast_Flutter.pdf",
                            ),
                          );
                        },
                        child: _buildIntroRow(
                          'my cv',
                          // متن معمولی.
                          'Download ',
                          // بخش برجسته.
                          themeConfig.green,
                          // رنگ بخش برجسته.
                          context,
                          false,
                          // عدم نمایش تصویر.
                          fontSize,
                          sizeimage,
                          isIcon: true
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
        .animate() // اضافه کردن انیمیشن.
        .fadeIn(duration: 1000.ms, curve: Curves.easeIn) // انیمیشن ظهور تدریجی.
        .moveY(
          begin: 50,
          end: 0,
          duration: 800.ms,
          curve: Curves.easeOut,
        ); // انیمیشن حرکت عمودی.
  }

  /// سازنده ردیف‌های متنی برای بخش معرفی.
  ///
  /// این تابع یک ردیف متنی شامل متن معمولی و بخش برجسته (Highlight) می‌سازد.
  ///
  /// ## پارامترها:
  /// - [label]: متن معمولی.
  /// - [highlight]: بخش برجسته.
  /// - [color]: رنگ بخش برجسته.
  /// - [context]: مرجع ساختار UI.
  /// - [image]: نمایش تصویر در کنار بخش برجسته.
  /// - [fontSize]: اندازه فونت.
  /// - [sizeimage]: اندازه تصویر (در صورت وجود).
  Widget _buildIntroRow(
    String label,
    String highlight,
    Color color,
    BuildContext context,
    bool image,
    double fontSize,
    double sizeimage, {
    bool isIcon = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // هم‌ترازی افقی در مرکز.
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 10), // فاصله بین متن معمولی و بخش برجسته.
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ), // فاصله داخلی.
          decoration: BoxDecoration(
            color: color, // رنگ پس‌زمینه بخش برجسته.
            borderRadius: BorderRadius.circular(12), // گردی گوشه‌ها.
          ),
          child: Row(
            children: [
              Row(
                children: [
                  Text(
                    highlight,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w400,
                      height: 1.1, // فاصله خطی.
                    ),
                  ),
                  isIcon
                      ? Icon(
                        CupertinoIcons.arrow_up_right,
                        color: Theme.of(context).colorScheme.onSurface,
                      )
                      : const SizedBox.shrink(),
                ],
              ),
              if (image) // نمایش تصویر در صورت فعال بودن.
                Image.asset(
                  'assets/co.png',
                  height: sizeimage,
                  fit: BoxFit.cover, // تنظیم اندازه تصویر.
                ),
            ],
          ),
        ),
      ],
    );
  }
}
