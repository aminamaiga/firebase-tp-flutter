import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertp2/data/model/question_model.dart';

class FirebaseRealtimeDataService {
  late DatabaseReference _db;

  FirebaseRealtimeDataService() {
    _db = FirebaseDatabase.instance.reference();
  }

//  the methods
  Future<DataSnapshot> getQuestion() async {
    return await _db.child('questions').once();
  }

  addQuestion(Question question) async {
    return await _db
        .child('questions')
        .push()
        .set(question.toJson())
        .then((result) async {
      print("La question a été bien enregistrée");
    }).catchError((onError) {
      print(onError.toString());
    }).whenComplete(() => {});
  }
}
