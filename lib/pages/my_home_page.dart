import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertp2/business_logic/cubits/question_bloc.dart';
import 'package:fluttertp2/business_logic/cubits/quiz_change_cubit.dart';
import 'package:fluttertp2/data/model/question_model.dart';
import 'package:fluttertp2/pages/add_question_page.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = "MyHomePage";

  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Question> questions = [];
  QuestionBloc q = QuestionBloc();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: q.getQuestions(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            questions = snapshot.data!;
            return Container(
                color: Colors.blueGrey,
                child: BlocBuilder<QuizCubic, int>(builder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: 300,
                          child: Image.asset('assets/france.PNG')),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          questions.isNotEmpty
                              ? questions.elementAt(index).question
                              : "",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<QuizCubic>()
                                    .checkResponse(true, questions);
                              },
                              child: Text("Vrai"),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueGrey)),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<QuizCubic>()
                                      .checkResponse(false, questions);
                                },
                                child: Text("Faux"),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blueGrey))),
                            ElevatedButton(
                                onPressed: () {
                                  context.read<QuizCubic>().nextQuestion();
                                },
                                child: Icon(Icons.arrow_forward),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blueGrey))),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AddQuestionPage.routeName);
                              },
                              child: Text("Nouvelle question"),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }));
          } // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
