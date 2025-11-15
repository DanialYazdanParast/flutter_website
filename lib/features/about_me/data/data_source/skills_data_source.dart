import 'package:datiego/features/about_me/data/models/skill_model.dart';

/// منبع داده برای مهارت‌ها
///
/// این کلاس برای ارائه لیستی از مهارت‌ها استفاده می‌شود.
abstract class SkillsDataSource {
  // متدی که لیستی از مهارت‌ها را برمی‌گرداند.
  List<SkillModel> getSkills();
}

/// پیاده‌سازی منبع داده مهارت‌ها
///
/// این کلاس پیاده‌سازی `SkillsDataSource` است و لیستی از مهارت‌ها را فراهم می‌کند.
class SkillsDataSourceImpl implements SkillsDataSource {
  @override
  List<SkillModel> getSkills() {
    // لیستی از مهارت‌ها با رنگ‌ها و متون مربوطه
    return [
      SkillModel(text: "Flutter", colorCode: 0xFF90CAF9), // آبی
      SkillModel(text: "Dart (OOP)", colorCode: 0xFFA7FFEB), // سبز آبی
      SkillModel(text: "SOLID Principles", colorCode: 0xFFCE93D8), // بنفش
      SkillModel(
          text: "Architecture (MVVM, MVC, Clean)",
          colorCode: 0xFFEF9A9A), // قرمز
      SkillModel(
          text: "State Management (Provider, Bloc, GetX)",
          colorCode: 0xFFA5D6A7), // سبز
      SkillModel(
          text: "RESTful API / WebSocket / Postman",
          colorCode:  0xFF80CBC4), // سبز
      SkillModel(text: "Material and Custom Components", colorCode: 0xFFF48FB1),
      SkillModel(
          text: "Flutter Web / PWA",
          colorCode: 0xFFB39DDB), // بنفش کم‌رنگ // صورتی
      SkillModel(text: "Responsive Design", colorCode: 0xFFFFCC80), // نارنجی
      SkillModel(
          text: "Android / iOS / Desktop Deployment",
          colorCode: 0xFF80DEEA), // فیروزه‌ای
      SkillModel(
          text: "Packages (Dio, Hive, GetIt, etc.)",
          colorCode: 0xFFFFF59D), // زرد
      SkillModel(
          text: "Documentation", colorCode: 0xFFB0BEC5), // خاکستری مایل به آبی
      SkillModel(text: "GIT / Gitflow", colorCode: 0xFFE0E0E0), // خاکستری
    ];
  }
}
