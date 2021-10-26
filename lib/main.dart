import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertp2/business_logic/cubits/question_bloc.dart';
import 'package:fluttertp2/business_logic/cubits/quiz_change_cubit.dart';
import 'package:fluttertp2/business_logic/theme_switch_cubit.dart';
import 'package:fluttertp2/pages/add_question_page.dart';
import 'package:fluttertp2/pages/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => QuizCubic()),
    BlocProvider(create: (_) => QuestionBloc()),
    BlocProvider(create: (_) => ThemeSwitchCubit(false))
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSwitchCubit, bool>(builder: (context, theme) {
      return MaterialApp(
        title: 'Exercice 2',
        theme: theme ? _lightTheme : _darkTheme,
        darkTheme: _darkTheme,
        showSemanticsDebugger: false,
        builder: (context, child) {
          return Scaffold(
            body: child,
            appBar: AppBar(
              title: Text("Questions/Reponses"),
              backgroundColor: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              actions: [
                Switch(
                    value: theme,
                    onChanged: (onChanged) {
                      context.read<ThemeSwitchCubit>().themeChange(onChanged);
                    },
                    activeColor: Theme
                        .of(context)
                        .colorScheme
                        .onSecondary),
              ],
            ),
          );
        },
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          AddQuestionPage.routeName: (context) => AddQuestionPage(),
          MyHomePage.routeName: (context) => MyHomePage()
        },
      );
    });
  }
}

ThemeData _darkTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.amber,
  colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.red),
);

ThemeData _lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.blue),
    brightness: Brightness.light,
    primaryColor: Colors.blue);
