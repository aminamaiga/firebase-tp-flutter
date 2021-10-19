class Question {
  bool response;
  String question;

  Question({required this.response, required this.question});

  factory Question.fromJson(Map<dynamic, dynamic> json) {
    return Question(response: json['response'], question: json['question']);
  }

  Map<String, dynamic> toJson() {
    return {"response": this.response, "question": this.question};
  }
}
