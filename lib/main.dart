import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

  var quizBrain = QuizBrain();

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (quizBrain.hasNextQuestion()) {
      buildPlayWidgets(children);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  void buildPlayWidgets(List<Widget> children) {
    children.add(Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            quizBrain.getCurrentQuestionText(),
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
    children.add(Row(children: scoreKeeper));
  }

  void addIcon(bool answer) {
    var icon = quizBrain.getQuestionAnswerByIndex(scoreKeeper.length) == answer
        ? Icon(Icons.check, color: Colors.green)
        : Icon(Icons.close, color: Colors.red);
    setState(() {
      scoreKeeper.add(icon);
    });
    quizBrain.incrementQuestionsNumber();
    if (!quizBrain.hasNextQuestion()) {
      var wonOrLost = hasWon() ? 'won :-)' : 'lost :-(';
      Alert(
        context: context,
        type: hasWon() ? AlertType.success : AlertType.error,
        title: 'Game over.',
        desc: 'You have $wonOrLost',
        buttons: [
          DialogButton(
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show().whenComplete(() => setState(() {
            restart();
          }));
    }
  }

  void restart() {
    quizBrain.reset();
    scoreKeeper.clear();
  }

  bool hasWon() {
    int rightAnswers = 0;
    for (var i = 0; i < scoreKeeper.length; i++) {
      if (scoreKeeper[i].icon == Icons.check) {
        rightAnswers++;
      }
    }

    return rightAnswers > (scoreKeeper.length / 2.0);
  }
}
