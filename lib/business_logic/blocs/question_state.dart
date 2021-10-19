
import 'package:fluttertp2/data/model/question_model.dart';

class QuestionState {
  // remplacer avec le cubit
  List<Question>? questions;

  QuestionState(this.questions);

  getQuestions() => questions;
}
