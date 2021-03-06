import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var finalScore = 0;
var questionNumber = 0;
var quiz = new AnimalQuiz();
var fireQuiz;
var numberOfQuestions = 0;

class AnimalQuiz {
  var images = ["alligator", "cat", "dog", "owl"];
}

class Quiz1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Quiz1State();
  }
}

class Quiz1State extends State<Quiz1> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: StreamBuilder(
                stream: Firestore.instance.collection('questions').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return const Text('Loading...');
                  else {
                    fireQuiz = snapshot.data.documents[questionNumber];
                    numberOfQuestions = snapshot.data.documents.length;
                    return new Container(
                      margin: const EdgeInsets.all(10.0),
                      alignment: Alignment.topCenter,
                      child: new Column(
                        children: <Widget>[
                          new Padding(padding: EdgeInsets.all(20.0)),

                          new Container(
                            alignment: Alignment.centerRight,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "Question ${questionNumber +
                                      1} of $numberOfQuestions",
                                  style: new TextStyle(fontSize: 22.0),
                                ),
                                new Text(
                                  "Score: $finalScore",
                                  style: new TextStyle(fontSize: 22.0),
                                )
                              ],
                            ),
                          ),

                          //image
                          new Padding(padding: EdgeInsets.all(10.0)),

                          new Image.asset(
                            "images/${quiz.images[questionNumber]}.jpg",
                          ),

                          new Padding(padding: EdgeInsets.all(10.0)),

                          new Text(
                            fireQuiz['questions'],
                            //quiz.questions[questionNumber],
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),

                          new Padding(padding: EdgeInsets.all(10.0)),

                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //button 1
                              new MaterialButton(
                                minWidth: 120.0,
                                color: Colors.blueGrey,
                                onPressed: () {
                                  if (fireQuiz['choices'][0] ==
                                      fireQuiz['correctAnswers']) {
                                    debugPrint("Correct");
                                    finalScore++;
                                  } else {
                                    debugPrint("Wrong");
                                  }
                                  updateQuestion();
                                },
                                child: new Text(
                                  fireQuiz['choices'][0],
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ),

                              //button 2
                              new MaterialButton(
                                minWidth: 120.0,
                                color: Colors.blueGrey,
                                onPressed: () {
                                  if (fireQuiz['choices'][1] ==
                                      fireQuiz['correctAnswers']) {
                                    debugPrint("Correct");
                                    finalScore++;
                                  } else {
                                    debugPrint("Wrong");
                                  }
                                  updateQuestion();
                                },
                                child: new Text(
                                  fireQuiz['choices'][1],
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),

                          new Padding(padding: EdgeInsets.all(10.0)),

                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //button 3
                              new MaterialButton(
                                minWidth: 120.0,
                                color: Colors.blueGrey,
                                onPressed: () {
                                  if (fireQuiz['choices'][2] ==
                                      fireQuiz['correctAnswers']) {
                                    debugPrint("Correct");
                                    finalScore++;
                                  } else {
                                    debugPrint("Wrong");
                                  }
                                  updateQuestion();
                                },
                                child: new Text(
                                  fireQuiz['choices'][2],
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ),

                              //button 4
                              new MaterialButton(
                                minWidth: 120.0,
                                color: Colors.blueGrey,
                                onPressed: () {
                                  if (fireQuiz['choices'][3] ==
                                      fireQuiz['correctAnswers']) {
                                    debugPrint("Correct");
                                    finalScore++;
                                  } else {
                                    debugPrint("Wrong");
                                  }
                                  updateQuestion();
                                },
                                child: new Text(
                                  fireQuiz['choices'][3],
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),

                          new Padding(padding: EdgeInsets.all(15.0)),

                          new Container(
                              alignment: Alignment.bottomCenter,
                              child: new MaterialButton(
                                  minWidth: 240.0,
                                  height: 30.0,
                                  color: Colors.red,
                                  onPressed: resetQuiz,
                                  child: new Text(
                                    "Quit",
                                    style: new TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  ))),
                        ],
                      ),
                    );
                  }
                })));
  }

  void resetQuiz() {
    setState(() {
      Navigator.pop(context);
      finalScore = 0;
      questionNumber = 0;
    });
  }

  void updateQuestion() {
    setState(() {
      debugPrint("questionNumber: $questionNumber");
      debugPrint("numberOfQuestions: $numberOfQuestions");
      if (questionNumber == numberOfQuestions - 1) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Summary(
                      score: finalScore,
                    )));
      } else {
        questionNumber++;
      }
    });
  }
}

class Summary extends StatelessWidget {
  final int score;

  Summary({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: new Container(
          alignment: Alignment.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Final Score: $score",
                style: new TextStyle(fontSize: 35.0),
              ),
              new Padding(padding: EdgeInsets.all(30.0)),
              new MaterialButton(
                color: Colors.red,
                onPressed: () {
                  questionNumber = 0;
                  finalScore = 0;
                  Navigator.pop(context);
                },
                child: new Text(
                  "Reset Quiz",
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
