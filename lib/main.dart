import 'package:datiego/confing/theme/app_theme.dart';
import 'package:datiego/core/di/service_locator.dart';
import 'package:datiego/core/router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main()  {
  // 🎯 این خط حیاتی است
  WidgetsFlutterBinding.ensureInitialized();

  // ⚙️ مقداردهی اولیه وابستگی‌ها
   init();

  // تنظیمات URL (برای وب)
  setUrlStrategy(PathUrlStrategy());

  // 🚀 اجرای برنامه
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ScreenGoRouter.router,
      title: 'datiego',
      theme: MyAppThemeConfig.light().getTheme(),
      darkTheme: MyAppThemeConfig.dark().getTheme(),
      themeMode: ThemeMode.system,
    );
  }
}