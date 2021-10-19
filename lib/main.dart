import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertp2/business_logic/cubits/question_bloc.dart';
import 'package:fluttertp2/business_logic/cubits/quiz_change_cubit.dart';
import 'package:fluttertp2/pages/add_question_page.dart';
import 'package:fluttertp2/pages/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercice 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => QuizCubic()),
        BlocProvider(create: (_) => QuestionBloc())
      ], child: MyHomePage(title: 'Questions/Reponses')),
      routes: {AddQuestionPage.routeName: (context) => AddQuestionPage()},
    );
  }
}
