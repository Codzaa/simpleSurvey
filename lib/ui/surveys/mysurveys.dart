import 'package:flutter/material.dart';
import 'package:survey/models/SurveyModel.dart';
import 'package:survey/ui/surveys/read.dart';
import '../../services/survey.dart';
import 'create.dart';

class MySurveysUI extends StatefulWidget {
  MySurveysUI({Key? key}) : super(key: key);

  @override
  State<MySurveysUI> createState() => _MySurveysUIState();
}

class _MySurveysUIState extends State<MySurveysUI> {
  //
  List<SurveyModel> mySurveys = [];
//
  bool gotSurveys = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncFunctions();
  }

  void asyncFunctions() async {
    ///
    mySurveys = SurveyService.getSurveys();
    if (mySurveys.isNotEmpty) {
      setState(() {
        gotSurveys = true;
      });
    }
  }

  void createSurvey() {
    //
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => CreateSurveyUI()));
    //
  }

  void openSurvey(index) {
    //
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => OpenSurveyUI(survey: mySurveys[index])));
    //
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          gotSurveys
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: mySurveys.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        //
                        openSurvey(index);
                        //
                      },
                      child: ListTile(
                        title: Text(mySurveys[index].topic),
                        subtitle: Text(mySurveys[index].companyName),
                      ),
                    );
                  }))
              : const Center(child: Text("Empty")),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              heroTag: "add",
              onPressed: () {
                createSurvey();
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
