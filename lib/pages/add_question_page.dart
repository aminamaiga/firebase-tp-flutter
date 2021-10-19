import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertp2/business_logic/cubits/add_question_qubit.dart';
import 'package:fluttertp2/data/model/question_model.dart';

class AddQuestionPage extends StatelessWidget {
  static const routeName = "AddQuestion";

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Ajouter une question';
    return MaterialApp(
        title: appTitle,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => AddQuestionCubit(
                    Question(question: "test", response: false)))
          ],
          child: Scaffold(
            appBar: AppBar(
              title: Text(appTitle),
            ),
            body: MyCustomForm(),
          ),
        ));
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerQuestion = new TextEditingController();
  TextEditingController controllerRespons = new TextEditingController();
  bool resp = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: BlocBuilder<AddQuestionCubit, Question>(
            builder: (context, question) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.calculate),
                  hintText: 'Entrer la question',
                  labelText: 'Question',
                ),
                controller: controllerQuestion,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return "Le champs est obligatoire";
                  }
                },
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Vraie'),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: resp,
                      onChanged: (bool? value) {
                        setState(() {
                          resp = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Fausse'),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: resp,
                      onChanged: (bool? value) {
                        setState(() {
                          resp = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      child: const Text('Enregister'),
                      onPressed: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          Question question = Question(
                              response: resp,
                              question: controllerQuestion.text);
                          print("add question called");
                          context
                              .read<AddQuestionCubit>()
                              .addQuestion(question);
                        }
                      }),
                  ElevatedButton(
                      onPressed: () {}, child: Text("page de questions"))
                ],
              )),
            ],
          );
        }));
  }
}
