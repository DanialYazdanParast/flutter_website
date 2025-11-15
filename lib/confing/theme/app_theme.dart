import 'package:flutter/material.dart';
import 'package:datiego/core/constants/app_colors.dart';

/// کلاس مدیریت پیکربندی تم‌های برنامه (تاریک و روشن).
///
/// این کلاس رنگ‌ها و تنظیمات تم‌های تاریک و روشن را مدیریت می‌کند و امکان ایجاد `ThemeData` را فراهم می‌کند.
///
/// ## مثال استفاده:
/// ```dart
/// final themeConfig = MyAppThemeConfig.of(context);
/// final themeData = themeConfig.getTheme();
/// ```
///
/// ## پارامترها:
/// - `primaryColor`: رنگ اصلی تم.
/// - `onprimaryColor`: رنگ متن یا عناصر روی `primaryColor`.
/// - `secondaryColor`: رنگ ثانویه تم.
/// - `onsecondaryColor`: رنگ متن یا عناصر روی `secondaryColor`.
/// - `textPrimary`: رنگ متن اصلی.
/// - `textSecondary`: رنگ متن ثانویه.
/// - `borderColor`: رنگ حاشیه‌ها.
/// - `dividerColor`: رنگ جداکننده‌ها.
/// - `brightness`: روشنایی تم (`Brightness.dark` یا `Brightness.light`).
/// - `peach`, `purple`, `coral`, `blue`, `green`, `gray`, `skyBlue`, `pink`: رنگ‌های اضافی.
///
/// ## نکات:
/// - از `MyAppThemeConfig.of(context)` برای تشخیص تم فعلی (تاریک یا روشن) استفاده می‌شود.
/// - `getTheme()` یک `ThemeData` بر اساس تنظیمات رنگ‌ها و تم ایجاد می‌کند.
class MyAppThemeConfig {
  final Color primaryColor;
  final Color onprimaryColor;
  final Color secondaryColor;
  final Color onsecondaryColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color borderColor;
  final Color dividerColor;
  final Brightness brightness;
  final Color peach;
  final Color purple;
  final Color coral;
  final Color blue;
  final Color green;
  final Color gray;
  final Color skyBlue;
  final Color pink;

  /// تشخیص تم فعلی (تاریک یا روشن) بر اساس `context`.
  factory MyAppThemeConfig.of(BuildContext context) {
    final brightness = Theme.of(context).colorScheme.brightness;
    return brightness == Brightness.dark
        ? MyAppThemeConfig.dark()
        : MyAppThemeConfig.light();
  }

  /// سازنده تم تاریک.
  MyAppThemeConfig.dark()
      : primaryColor = DarkThemeColors.primaryColor,
        onprimaryColor = DarkThemeColors.onprimaryColor,
        secondaryColor = DarkThemeColors.secondaryColor,
        onsecondaryColor = DarkThemeColors.onsecondaryColor,
        textPrimary = DarkThemeColors.textPrimary,
        borderColor = DarkThemeColors.borderColor,
        dividerColor = DarkThemeColors.dividerColor,
        brightness = Brightness.dark,
        peach = DarkThemeColors.peach,
        purple = DarkThemeColors.purple,
        coral = DarkThemeColors.coral,
        blue = DarkThemeColors.blue,
        green = DarkThemeColors.green,
        skyBlue = DarkThemeColors.skyBlue,
        pink = DarkThemeColors.pink,
        gray = DarkThemeColors.gray,
        textSecondary = DarkThemeColors.textSecondary;

  /// سازنده تم روشن.
  MyAppThemeConfig.light()
      : primaryColor = LightThemeColors.primaryColor,
        onprimaryColor = LightThemeColors.onprimaryColor,
        secondaryColor = LightThemeColors.secondaryColor,
        onsecondaryColor = LightThemeColors.onsecondaryColor,
        textPrimary = LightThemeColors.textPrimary,
        borderColor = LightThemeColors.borderColor,
        dividerColor = LightThemeColors.dividerColor,
        brightness = Brightness.light,
        peach = LightThemeColors.peach,
        purple = LightThemeColors.purple,
        coral = LightThemeColors.coral,
        blue = LightThemeColors.blue,
        green = LightThemeColors.green,
        skyBlue = LightThemeColors.skyBlue,
        pink = LightThemeColors.pink,
        gray = LightThemeColors.gray,
        textSecondary = LightThemeColors.textSecondary;

  /// ایجاد `ThemeData` بر اساس تنظیمات رنگ‌ها و تم.
  ThemeData getTheme() {
    return ThemeData(
      scaffoldBackgroundColor: primaryColor,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: textSecondary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      iconTheme: IconThemeData(
        color: textPrimary,
      ),
      dividerColor: dividerColor,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: primaryColor,
        secondary: secondaryColor,
        onSecondary: onsecondaryColor,
        primary: primaryColor,
        onPrimary: onprimaryColor,
        onSurface: textPrimary,
        outline: borderColor,
      ),
    );
  }
}
