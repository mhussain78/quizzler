import 'package:flutter/material.dart';
import 'package:quizzler/Question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
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
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  var questionNumber = 0;

  List<Question> questions = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true)
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (questionNumber < questions.length) {
      children.add(Expanded(
        flex: 5,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              questions[questionNumber].content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
      children.add(Expanded(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: FlatButton(
            textColor: Colors.white,
            color: Colors.green,
            child: Text(
              'True',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              addIcon(true);
            },
          ),
        ),
      ));
      children.add(Expanded(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: FlatButton(
            color: Colors.red,
            child: Text(
              'False',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              addIcon(false);
            },
          ),
        ),
      ));
    } else {
      children.add(Expanded(
        flex: 5,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              'Game is over',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
    }

    children.add(Row(children: scoreKeeper));

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  void addIcon(bool answer) {
    var question = questions[scoreKeeper.length];
    var icon = question.answer == answer
        ? Icon(Icons.check, color: Colors.green)
        : Icon(Icons.close, color: Colors.red);
    setState(() {
      scoreKeeper.add(icon);
    });
    questionNumber++;
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/