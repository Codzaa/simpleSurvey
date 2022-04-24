import 'package:flutter/material.dart';
import 'package:survey/models/QuestionModel.dart';
import 'package:survey/models/SurveyModel.dart';
import 'package:survey/services/survey.dart';

class TakeSurveyUI extends StatefulWidget {
  SurveyModel survey;
  TakeSurveyUI({Key? key, required this.survey}) : super(key: key);

  @override
  State<TakeSurveyUI> createState() => _TakeSurveyUIState();
}

class _TakeSurveyUIState extends State<TakeSurveyUI> {
  ///
  List<QuestionModel> questions = [];
  bool loadedQs = false;
  bool isDone = false;

  ///
  @override
  void initState() {
    super.initState();
    questions = widget.survey.questions;
    setState(() {
      loadedQs = true;
    });
  }

  ///
  answer(String answer, int index) {
    //
    switch (answer) {
      case "YES":
        widget.survey.questions[index].isYes = true;
        widget.survey.questions[index].isNo = false;
        break;
      case "NO":
        widget.survey.questions[index].isYes = false;
        widget.survey.questions[index].isNo = true;
        break;
      default:
        break;
    }
    //
    checkIfDone();
    //
    setState(() {});
    //
  }

  checkIfDone() {
    int i = 0;
    for (var item in widget.survey.questions) {
      if (item.isYes == item.isNo) {
        //Not Done
        i++;
      }
    }
    if (i == 0) {
      isDone = true;
    }
  }

  submitSurvey() {
    //
    SurveyService.submitSurvey(widget.survey);
    Navigator.pop(context);
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey.topic),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.survey.questions.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(widget.survey.questions[index].body),
              subtitle: Row(
                children: [
                  const Text("YES"),
                  Checkbox(
                      value: widget.survey.questions[index].isYes,
                      onChanged: (bool? value) {
                        //
                        answer("YES", index);
                      }),
                  const Text("NO"),
                  Checkbox(
                      value: widget.survey.questions[index].isNo,
                      onChanged: (bool? value) {
                        //
                        answer("NO", index);
                      })
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: isDone
          ? FloatingActionButton(
              onPressed: () {
                //
                submitSurvey();
                //
              },
              child: const Icon(Icons.done),
            )
          : Container(),
    );
  }
}
