import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';



import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quiz_app_localization/modules/quiz/models/quiz_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../l10n/app_localizations.dart';

class QuizController extends GetxController {
  AppLocalizations get l10n => AppLocalizations.of(Get.context!)!;

   RxInt selectedValue = 0.obs;
   RxInt currentQuiz = 0.obs;
   RxList<Results> quizList = <Results>[].obs;
   RxInt scoreCount = 0.obs;
   var isNextQuestionLoading  = false.obs;
   var isSubmitted = false.obs;
   RxList<int> answerHistory = <int>[].obs;


   @override
  void onInit() async {
    // TODO: implement onInit

     super.onInit();

     String? savedLanguage = await getSavedLanguage();
      await setLocale(savedLanguage ?? "en");
     //getQuizList();
     selectedValue.value = 4;
  }
   Future<void> setLocale(String languageCode) async {

    await Get.updateLocale(Locale(languageCode));
    getQuizList();
  }

void saveSelectedLanguage(String languageCode) async {

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('language', languageCode);
}

Future<String?> getSavedLanguage() async{
  final prefs = await SharedPreferences.getInstance();
  return await  prefs.getString('language') ?? "en";

}
   bool isAnswerCorrect(){

     if(quizList.isNotEmpty){
       if(selectedValue.value < quizList[currentQuiz.value].incorrectAnswers!.length && quizList[currentQuiz.value].incorrectAnswers![selectedValue.value] == quizList[currentQuiz.value].correctAnswer)
        {
          return true;
        }
     }


     return false;
  }

  Future<void> showDialog() async {

      isNextQuestionLoading.value = true;
      isSubmitted.value = true;
       bool isRight = isAnswerCorrect();

       if(isRight){
         scoreCount++;
       }
       answerHistory[currentQuiz.value] = selectedValue.value;

      showBeautifulSnackbar(
        title: isRight
            ? "🎉 Correct Answer"
            : "❌ Wrong Answer",
        message: isRight
            ? "Awesome! Keep it up."
            : "Try the next one.",
        success: isRight,
      );

     await  Future.delayed(Duration(seconds: 3) , () async {
       if(currentQuiz.value < quizList.length - 1)
       {
         // Get.closeAllSnackbars();
         // showInfoSnackbar(
         //   title: "Next Question",
         //   message: "Loading question ${currentQuiz.value + 1}",
         // );
         await Future.delayed(Duration(seconds: 1), (){
           selectedValue.value = 0;
           currentQuiz.value +=1;
           isNextQuestionLoading.value = false;
         });

         isSubmitted.value = false;
       }else{
         Get.closeAllSnackbars();

         Get.rawSnackbar(
           snackPosition: SnackPosition.TOP,
           backgroundColor: const Color(0xFF7C3AED),
           borderRadius: 24,
           margin: const EdgeInsets.all(16),
           duration: const Duration(seconds: 4),
           icon: const Icon(
             Icons.emoji_events_rounded,
             color: Colors.amber,
             size: 34,
           ),
           titleText: const Text(
             "Quiz Completed 🎉",
             style: TextStyle(
               color: Colors.white,
               fontSize: 18,
               fontWeight: FontWeight.bold,
             ),
           ),
           messageText: Text(
             "Final Score: ${scoreCount.value}/${quizList.length}",
             style: const TextStyle(
               color: Colors.white70,
               fontSize: 15,
             ),
           ),
         );
       }

     });

      selectedValue.value = quizList[currentQuiz.value].incorrectAnswers!.length;

    isNextQuestionLoading.value = false;

  }
  void getQuizList(){
     String encoded  = l10n.quiz;


     String jsonString = utf8.decode(base64.decode(encoded));

     QuizResponseModel quizResponseModel = QuizResponseModel.fromJson(json.decode(jsonString));
     if(quizResponseModel.results != null ){

       for(var item in quizResponseModel.results!){

         item.incorrectAnswers?.add(item.correctAnswer!);
       }
     }
     if(quizList.isNotEmpty ){
       quizList.clear();
     }
     quizList.addAll(quizResponseModel.results!) ;
     answerHistory.addAll(quizList.map((item)=> item.incorrectAnswers!.length).toList());



  }



  void showBeautifulSnackbar({
    required String title,
    required String message,
    bool success = true,
    Duration duration = const Duration(seconds: 2),
  }) {
    Get.closeAllSnackbars();

    final Color primaryColor = success
        ? const Color(0xFF22C55E)
        : const Color(0xFFEF4444);

    final IconData icon = success
        ? Icons.check_circle_rounded
        : Icons.cancel_rounded;

    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      borderRadius: 24,
      duration: duration,
      padding: EdgeInsets.zero,
      isDismissible: true,
      messageText: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15,
            sigmaY: 15,
          ),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor,
                  primaryColor.withOpacity(.75),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(.35),
                  blurRadius: 25,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInfoSnackbar({
    required String title,
    required String message,
  }) {
    Get.closeAllSnackbars();

    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF4F46E5),
      borderRadius: 22,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
      icon: const Icon(
        Icons.info_outline_rounded,
        color: Colors.white,
        size: 28,
      ),
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }
}
