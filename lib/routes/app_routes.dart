part of 'app_pages.dart';

abstract class Routes{

  Routes._();
  static const QUIZ  = _Paths.QUIZ;
  static const SCORE  = _Paths.SCORE;
}

abstract class _Paths {
  _Paths._();
  static const QUIZ = '/quiz';
  static const SCORE = '/score';

}