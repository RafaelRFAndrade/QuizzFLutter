import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Question>> fetchTrueOrFalseQuestions() async {
  final response = await http.get(Uri.parse(
      'https://opentdb.com/api.php?amount=10&type=boolean&language=pt'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> results = data['results'];
    return results.map((json) => Question.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load questions');
  }
}

class Question {
  final String question;
  final bool correctAnswer;

  Question({required this.question, required this.correctAnswer});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      correctAnswer: json['correct_answer'] == 'True',
    );
  }
}
