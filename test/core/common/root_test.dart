import 'package:datiego/core/di/service_locator.dart';
import 'package:datiego/features/projects/presentation/widgets/project_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datiego/core/router/go_router.dart';
import 'package:datiego/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:datiego/features/shared/domain/entities/projects_entities.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';

// Mock برای GoRouter
class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('ProjectCard Widget Test', () {
    late GoRouter mockRouter;

    setUp(() {
      mockRouter = MockGoRouter();
    });

    testWidgets('GestureDetector onTap navigates to project detail page',
        (WidgetTester tester) async {
      // ایجاد داده‌های تستی
      const project = ProjectsEntities(
        title: 'Test Project',
        image: 'https://example.com/image.jpg',
        subtitle: 'This is a test project.',
        tag: [],
      );

      // رندر ویجت ProjectCard
      await tester.pumpWidget(
        MaterialApp.router(
          routerDelegate: mockRouter.routerDelegate,
          routeInformationParser: mockRouter.routeInformationParser,
          routeInformationProvider: mockRouter.routeInformationProvider,
        ),
      );

      // اضافه کردن ویجت ProjectCard به درخت ویجت‌ها
      await tester.pumpWidget(
        BlocProvider<ProjectsBloc>(
          create: (_) => ProjectsBloc(getIt.get()),
          child: Builder(
            builder: (context) {
              return const ProjectCard(
                index: 0,
                project: project,
              );
            },
          ),
        ),
      );

      // شبیه‌سازی کلیک روی GestureDetector
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      // تأیید فراخوانی context.go
      verify(mockRouter.go('${ScreenGoRouter.projects}/Test Project',
              extra: project))
          .called(1);
    });
  });
}
