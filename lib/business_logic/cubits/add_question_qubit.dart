import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertp2/data/model/question_model.dart';
import 'package:fluttertp2/data/repositories/firebase_realtime_data_service.dart';

class AddQuestionCubit extends Cubit<Question> {
  late FirebaseRealtimeDataService firebaseRealtimeDataService;

  AddQuestionCubit(Question initialState) : super(initialState) {
    firebaseRealtimeDataService = FirebaseRealtimeDataService();
  }

  addQuestion(Question question) async {
    print("add question called");
    await firebaseRealtimeDataService.addQuestion(question);
    emit(question);
  }
}
