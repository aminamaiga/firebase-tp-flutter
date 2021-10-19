import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertp2/data/model/question_model.dart';

class QuizCubic extends Cubit<int> {
  int questionIndex = 0;
  bool? responseStatus;

  QuizCubic() : super(0);

  nextQuestion() {
    if (questionIndex < 3) {
      ++questionIndex;
    } else {
      questionIndex = 0;
    }
    emit(questionIndex);
  }

  checkResponse(bool response, List<Question> questions) {
    if (questions.isNotEmpty) {
      if (response == questions.elementAt(questionIndex).response) {
        responseStatus = true;
        nextQuestion();
      } else {
        responseStatus = false;
      }
    }
  }
}
