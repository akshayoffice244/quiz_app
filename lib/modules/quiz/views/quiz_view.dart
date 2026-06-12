import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quiz_app_localization/core/widgets/custom_text.dart';
import 'package:quiz_app_localization/modules/quiz/controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {

    final unescape = HtmlUnescape();

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Quiz Master",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: Get.locale?.languageCode ?? "en",
                isDense: true,

                borderRadius: BorderRadius.circular(14),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.blue,
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                items: const [
                  DropdownMenuItem(
                    value: "en",
                    child: Row(
                      children: [
                        Text("🇺🇸"),
                        SizedBox(width: 8),
                        Text("English"),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: "hi",
                    child: Row(
                      children: [
                        Text("🇮🇳"),
                        SizedBox(width: 8),
                        Text("हिंदी"),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    controller.saveSelectedLanguage(value);
                    controller.setLocale(value);
                  }
                },
              ),
            ),
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4F46E5),
              Color(0xff7C3AED),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Obx(() {
            if (controller.quizList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            final quiz =
            controller.quizList[controller.currentQuiz.value];

            return Container(
              padding: const EdgeInsets.only(top: 5,bottom: 5, left: 20, right: 20),
              child:  Column(
                  children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(child: ListView(


                                children: [
                                  Column(
                                    children: [
                                      /// Progress
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(.15),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.quiz,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  "Question ${controller.currentQuiz.value + 1}/${controller.quizList.length}",
                                                  style: const TextStyle(
                                                    color: Colors.white,

                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            LinearProgressIndicator(
                                              value: (controller.currentQuiz.value + 1) /
                                                  controller.quizList.length,
                                              borderRadius: BorderRadius.circular(20),
                                              minHeight: 8,
                                              backgroundColor: Colors.white24,
                                              color: Colors.amber,
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 15),

                                      /// Question Card
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(24),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(28),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(.1),
                                              blurRadius: 20,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.deepPurple.shade50,
                                                borderRadius:
                                                BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                "Question ${controller.currentQuiz.value + 1}",
                                                style: TextStyle(
                                                  color: Colors.deepPurple.shade700,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 20),

                                            Text(
                                              unescape.convert(quiz.question ?? ""),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                height: 1.4,
                                              ),
                                            ),

                                            const SizedBox(height: 30),

                                            ...quiz.incorrectAnswers!
                                                .asMap()
                                                .entries
                                                .map(
                                                  (entry) {
                                                final index = entry.key;
                                                final answer = entry.value;

                                                return Obx(
                                                      () => Container(
                                                    margin: const EdgeInsets.only(
                                                      bottom: 14,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(16),
                                                      border: Border.all(
                                                        color: controller
                                                            .selectedValue
                                                            .value ==
                                                            index
                                                            ? Colors.deepPurple
                                                            : Colors.grey.shade300,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: RadioListTile<int>(
                                                      value: index,
                                                      groupValue: controller
                                                          .selectedValue.value,
                                                      enabled: !controller.isSubmitted.value,
                                                      activeColor:
                                                      Colors.deepPurple,
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                      ),
                                                      title: Text(
                                                        answer,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        controller.selectedValue
                                                            .value = value!;
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      /// Submit Button


                                      Row(
                                        spacing: 8,
                                        children: [

                                          Expanded(
                                            child: Container(

                                              height: 48,
                                              child:IconButton(
                                                icon: const Icon(Icons.arrow_back),

                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.amber,
                                                  foregroundColor: Colors.black,
                                                  elevation: 8,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(18),
                                                  ),
                                                ),
                                                onPressed: () {


                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              
                                              height: 48,
                                              child: ElevatedButton.icon(

                                                label:  Text(
                                                  controller.currentQuiz.value == controller.quizList.length - 1 && controller.isSubmitted.value ?  "View Score" : "Submit",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.amber,
                                                  foregroundColor: Colors.black,
                                                  elevation: 8,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(18),
                                                  ),
                                                ),
                                                onPressed: () {
                                            
                                                  if(!controller.isSubmitted.value ||controller.quizList.length - 2 >
                                                      controller.currentQuiz.value    ){
                                            
                                            
                                                    if (!controller
                                                        .isNextQuestionLoading.value) {

                                                      if(controller.selectedValue.value > controller.quizList[controller.currentQuiz.value].incorrectAnswers!.length - 1){
                                                        Get.closeAllSnackbars();
                                                        controller.showInfoSnackbar(
                                                          title: "Please select an answer!",
                                                          message: "",
                                                        );
                                                      }else{
                                                        controller.showDialog();
                                                      }

                                                    }else {
                                                      Get.closeAllSnackbars();
                                                      controller.showInfoSnackbar(
                                                        title: "Please wait!",
                                                        message: "Loading question ${controller.currentQuiz.value + 2}",
                                                      );
                                                    }
                                                  } else if (controller.quizList.length - 1 ==
                                                      controller.currentQuiz.value) {
                                                    Get.toNamed("/score");
                                            
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(

                                              height: 48,
                                              child:IconButton(
                                                icon: const Icon(Icons.arrow_forward),

                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.amber,
                                                  foregroundColor: Colors.black,
                                                  elevation: 8,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(18),
                                                  ),
                                                ),
                                                onPressed: () {


                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      )


                                    ],
                                  )
                                ],
                              ))
                            ],
                          ),
                        )

                  ],
                ),

            );
          }),
        ),
      ),
    );
  }
}