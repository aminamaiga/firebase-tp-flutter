import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertp2/business_logic/blocs/reponse_type_bloc.dart';
import 'package:fluttertp2/business_logic/cubits/add_question_qubit.dart';
import 'package:fluttertp2/data/model/question_model.dart';
import 'package:fluttertp2/pages/my_home_page.dart';

class AddQuestionPage extends StatelessWidget {
  static const routeName = "AddQuestion";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MultiBlocProvider(
            providers: [
          BlocProvider(
              create: (_) => AddQuestionCubit(
                  Question(question: "test", response: false))),
          BlocProvider(create: (_) => ResponseTypeBloc(false)),
        ],
            child: Scaffold(
              body: MyCustomForm(),
            )));
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

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: BlocBuilder<AddQuestionCubit, Question>(
            builder: (context, question) {
          return BlocBuilder<ResponseTypeBloc, bool>(builder: (context, resp) {
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
                          context.read<ResponseTypeBloc>().add(TrueEvent());
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Fausse'),
                      leading: Radio<bool>(
                        value: false,
                        groupValue: resp,
                        onChanged: (bool? value) {
                          context.read<ResponseTypeBloc>().add(FalseEvent());
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
                        onPressed: () {
                          Navigator.pushNamed(context, MyHomePage.routeName);
                        },
                        child: Text("page de questions"))
                  ],
                )),
              ],
            );
          });
        }));
  }
}
