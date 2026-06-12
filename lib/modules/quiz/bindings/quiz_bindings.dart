

import 'package:get/get.dart';
import 'package:quiz_app_localization/modules/quiz/controllers/quiz_controller.dart';

class QuizBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<QuizController>(()=> QuizController());
  }
}