
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quiz_app_localization/modules/quiz/bindings/quiz_bindings.dart';
import 'package:quiz_app_localization/modules/quiz/views/quiz_score_view.dart';

import '../modules/quiz/views/quiz_view.dart';

part  'app_routes.dart';
class AppPages {
  AppPages._();

  static const INITIAL = Routes.QUIZ;

  static final routes = [

    GetPage(
      name: _Paths.QUIZ,
      page: () => const QuizView(),
      binding: QuizBindings(),

    ),

    GetPage(
      name: _Paths.SCORE,
      page: () => const QuizScoreView(),
      binding: QuizBindings(),

    )
  ];

}

