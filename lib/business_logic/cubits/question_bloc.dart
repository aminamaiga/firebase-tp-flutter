import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertp2/data/model/question_model.dart';
import 'package:fluttertp2/data/repositories/firebase_realtime_data_service.dart';

class QuestionBloc extends Bloc {
  late FirebaseRealtimeDataService firebaseRealtimeDataService;
  static List<Question> questions = [];

  QuestionBloc() : super(null) {
    firebaseRealtimeDataService = FirebaseRealtimeDataService();
  }

  Future<List<Question>> getQuestions() async {
    await firebaseRealtimeDataService.getQuestion().then((result) async {
      Map<dynamic, dynamic> resp = result.value;
      print(result.value);
      questions = resp.entries
          .map((quest) => Question(
              response: quest.value["response"],
              question: quest.value["question"]))
          .toList();
    }).catchError((onError) {
      print(onError.toString());
    }).whenComplete(() => {});
    return Future.value(questions);
  }
}
