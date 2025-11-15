import 'package:datiego/features/blog/data/data_source/blog_data_source_remote.dart';
import 'package:datiego/features/blog/data/repository/blog_repository_impl.dart';
import 'package:datiego/features/blog/domain/repository/blog_repository.dart';
import 'package:datiego/features/blog/domain/use_cases/get_blog_usecase.dart';
import 'package:datiego/features/home/domain/use_cases/download_file_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:datiego/core/services/url_launcher_service.dart';
import 'package:datiego/core/constants/app_constants.dart';
import 'package:datiego/features/about_me/data/data_source/skills_data_source.dart';
import 'package:datiego/features/about_me/data/repository/skills_repository_impl.dart';
import 'package:datiego/features/about_me/domain/repository/skills_repository.dart';
import 'package:datiego/features/home/data/repository/file_downloader_repository_impl.dart';
import 'package:datiego/features/home/domain/repository/file_downloader_repository.dart';
import 'package:datiego/features/shared/data/data_source/remote/projects_remote_data_source.dart';
import 'package:datiego/features/shared/data/repository/projects_repository_impl.dart';
import 'package:datiego/features/shared/domain/repository/projects_repository.dart';
import 'package:datiego/features/shared/domain/use_cases/get_projects_usecase.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// 📍 نمونه Singleton از GetIt
final getIt = GetIt.instance;

/// 📦 مقداردهی اولیه وابستگی‌ها
void init()  {
  /// 🛠️ تنظیم Dio با pretty_dio_logger
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
    ),
  );

  /// 🔥 اضافه کردن PrettyDioLogger برای نمایش در DevTools
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: false,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      filter: (options, args) {
        // می‌توانید فیلتر کنید کدام requestها لاگ شوند
        return true;
      },
    ),
  );

  /// ثبت Dio در GetIt
  getIt.registerSingleton<Dio>(dio);

  /// 📊 ثبت ProjectsRemoteDataSource
  getIt.registerSingleton<ProjectsRemoteDataSource>(
      ProjectsRemoteDataSourceImpl(getIt.get()));

  /// 🗂️ ثبت ProjectsRepository
  getIt.registerSingleton<ProjectsRepository>(
      ProjectsRepositoryImpl(getIt.get()));

  /// 🔍 ثبت GetProjectsUsecase
  getIt.registerSingleton<GetProjectsUsecase>(GetProjectsUsecase(getIt.get()));

  /// 📥 ثبت FileDownloaderRepository
  getIt.registerSingleton<FileDownloaderRepository>(
      FileDownloaderRepositoryImpl());

  /// ⬇️ ثبت DownloadFileUseCase
  getIt.registerSingleton<DownloadFileUseCase>(
      DownloadFileUseCase(getIt.get()));

  /// 🌐 ثبت UrlLauncherService
  getIt.registerSingleton<UrlLauncherService>(UrlLauncherService());

  /// 🛠️ ثبت SkillsDataSource
  getIt.registerSingleton<SkillsDataSource>(SkillsDataSourceImpl());

  /// 📚 ثبت SkillsRepository
  getIt.registerSingleton<SkillsRepository>(SkillsRepositoryImpl(getIt.get()));

  /// 📝 ثبت BlogDataSourceRemote
  getIt.registerSingleton<BlogDataSourceRemote>(
      BlogDataSourceRemoteImpl(getIt.get()));

  /// 📖 ثبت BlogRepository
  getIt.registerSingleton<BlogRepository>(BlogRepositoryImpl(getIt.get()));

  /// 🔎 ثبت GetBlogUsecase
  getIt.registerSingleton<GetBlogUsecase>(GetBlogUsecase(getIt.get()));
}