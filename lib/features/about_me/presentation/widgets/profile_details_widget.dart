import 'package:flutter/material.dart';
import 'package:datiego/features/about_me/presentation/widgets/little_bit_about_me.dart';
import 'package:datiego/features/about_me/presentation/widgets/skills.dart';
import 'package:datiego/features/about_me/presentation/widgets/social_media.dart';

import 'experience.dart';

/// ویجت جزئیات پروفایل
///
/// این ویجت شامل جزئیاتی از پروفایل کاربر است، مانند اطلاعات کوتاه درباره کاربر، مهارت‌ها، و لینک‌های رسانه‌های اجتماعی.
/// این ویجت از چند بخش تشکیل شده است:
/// - `LittleBitAboutMe` برای نمایش اطلاعات کوتاه درباره کاربر
/// - `Skills` برای نمایش مهارت‌ها
/// - `SocialMedia` برای نمایش لینک‌های رسانه‌های اجتماعی کاربر
///
/// ## مثال استفاده:
/// ```dart
/// const ProfileDetailsWidget()
/// ```
///
/// ## نکات:
/// - این ویجت شامل چند بخش مختلف است که برای به نمایش گذاشتن جزئیات پروفایل کاربر استفاده می‌شود.
class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LittleBitAboutMe(), // نمایش اطلاعات کوتاهی درباره کاربر
        const SizedBox(height: 24), // فاصله بین بخش‌ها
        const Experience(),
        const SizedBox(height: 24), // فاصله بین بخش‌ها
        Skills(), // نمایش مهارت‌ها
        const SizedBox(height: 24), // فاصله بین بخش‌ها
        const SocialMedia(), // نمایش لینک‌های رسانه‌های اجتماعی
      ],
    );
  }
}
