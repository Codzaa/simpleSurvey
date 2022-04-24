import 'package:flutter/material.dart';
import 'package:survey/services/survey.dart';
import '../../models/SurveyModel.dart';

class OpenSurveyUI extends StatefulWidget {
  SurveyModel survey;
  OpenSurveyUI({Key? key, required this.survey}) : super(key: key);

  @override
  State<OpenSurveyUI> createState() => _OpenSurveyUIState();
}

class _OpenSurveyUIState extends State<OpenSurveyUI> {
  //
  TextEditingController surveyNameController = TextEditingController();
  //
  bool haveQs = false;
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.survey.questions.isNotEmpty) {
      setState(() {
        haveQs = true;
      });
    }
  }

  updateSurvey() {}

  deleteSurvey() {
    SurveyService.deleteSurvey(widget.survey);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey.topic),
        actions: [
          TextButton.icon(
              onPressed: () {
                deleteSurvey();
              },
              icon: const Icon(Icons.delete),
              label: const Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          haveQs
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.survey.questions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.survey.questions[index].body),
                    );
                  })
              : Container()
        ],
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          //
        },
        child: const Icon(Icons.save),
      ),
      */
    );
  }
}
