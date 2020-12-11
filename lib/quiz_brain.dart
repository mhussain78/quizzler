import 'package:quizzler/Question.dart';

class QuizBrain {
  var _questionNumber = 0;

  List<Question> _questions = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  String getCurrentQuestionText() {
    return getQuestionTextByIndex(_questionNumber);
  }

  String getQuestionTextByIndex(int index) {
    return _questions[index].text;
  }

  bool getQuestionAnswerByIndex(int index) {
    return _questions[index].answer;
  }

  int getQuestionsSize() {
    return _questions.length;
  }

  Question getQuestionByIndex(int index) {
    return _questions[index];
  }

  int getCurrentQuestionNumber() {
    return _questionNumber;
  }

  void incrementQuestionsNumber() {
    if (hasNextQuestion()) {
      _questionNumber++;
    }
  }

  bool hasNextQuestion() {
    return _questionNumber < _questions.length;
  }

  void reset() {
    _questionNumber = 0;
  }
}
