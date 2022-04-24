import 'package:flutter/material.dart';
import '../../models/QuestionModel.dart';
import '../../services/survey.dart';

class CreateSurveyUI extends StatefulWidget {
  CreateSurveyUI({Key? key}) : super(key: key);

  @override
  State<CreateSurveyUI> createState() => _CreateSurveyUIState();
}

class _CreateSurveyUIState extends State<CreateSurveyUI> {
  List<QuestionModel> myQuestions = [];
  //
  bool anyQs = false;
  //
  TextEditingController questionController = TextEditingController();
  TextEditingController surveyNameController = TextEditingController();
  //
  addQuestion() {
    if (questionController.text != "") {
      myQuestions.add(QuestionModel(
          body: questionController.text, isYes: false, isNo: false));
      setState(() {
        questionController.text = "";
        anyQs = true;
      });
    }
  }

  //
  deleteQuestion() {
    //
    if (myQuestions.isNotEmpty) {
      myQuestions.remove(myQuestions.last);
      setState(() {});
    }
    //
  }

  saveSurvey() {
    //
    if (surveyNameController.text != "") {
      if (myQuestions.length == 5) {
        //
        SurveyService.createSurvey(surveyNameController.text, myQuestions);
        Navigator.pop(context);
      }
    }
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("New Survey(5 Questions)"),
        actions: [
          TextButton(
              onPressed: () {
                //
                saveSurvey();
                //
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ))
        ],
      ),
      body: Column(
        children: [
          Center(
            child: TextField(
              controller: surveyNameController,
              decoration: const InputDecoration(labelText: 'Survey Name'),
            ),
          ),
          Center(
            child: TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
          ),
          anyQs
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: myQuestions.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //Select Item
                      },
                      child: ListTile(
                        title: Text(myQuestions[index].body),
                        subtitle: const Divider(),
                      ),
                    );
                  })
              : Container()
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              heroTag: "Add",
              onPressed: () {
                addQuestion();
              },
              child: const Icon(Icons.add),
            ),
          ),
          Positioned(
            bottom: 120,
            right: 30,
            child: FloatingActionButton(
              heroTag: "Remove",
              onPressed: () {
                deleteQuestion();
              },
              child: const Icon(Icons.remove),
            ),
          )
        ],
      ),
    );
  }
}
