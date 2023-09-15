// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'perguntas.dart';

void main() {
  runApp(const Quiz());
}

class Quiz extends StatelessWidget {
  const Quiz({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  @override
  void initState() {
    super.initState();
    fetchTrueOrFalseQuestions().then((data) {
      setState(() {
        questions = data;
      });
    });
  }

  void nextQuestion(bool userAnswer) {
    final Question currentQuestion = questions[currentQuestionIndex];
    setState(() {
      if (userAnswer == currentQuestion.correctAnswer) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        currentQuestionIndex = 0;
        correctAnswers = 0;
        incorrectAnswers = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions.isNotEmpty
                    ? questions[currentQuestionIndex].question
                    : 'Carregando...',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                nextQuestion(true);
              },
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                nextQuestion(false);
              },
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
              Text(
                correctAnswers.toString(),
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(width: 20.0),
              const Icon(
                Icons.close,
                color: Colors.red,
              ),
              Text(
                incorrectAnswers.toString(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
