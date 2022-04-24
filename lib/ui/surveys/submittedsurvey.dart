import 'package:flutter/material.dart';
import 'package:survey/models/SubmittedSurvey.dart';
import 'package:survey/ui/surveys/results.dart';

import '../../services/survey.dart';

class MySubmittedSurveyUI extends StatefulWidget {
  MySubmittedSurveyUI({Key? key}) : super(key: key);

  @override
  State<MySubmittedSurveyUI> createState() => _MySubmittedSurveyUIState();
}

class _MySubmittedSurveyUIState extends State<MySubmittedSurveyUI> {
  List<SubmittedSurvey> mySurveys = [];
  //
  bool gotData = false;
  //
  TextEditingController searchController = TextEditingController();

  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
  }

  searchForSurvey() {
    mySurveys = [];
    //
    mySurveys = SurveyService.getSubmittedSurvey(searchController.text);
    if (mySurveys.isNotEmpty) {
      gotData = true;
    } else {
      gotData = false;
    }
    //
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Center(
            child: SafeArea(
              child: TextField(
                controller: searchController,
                decoration:
                    const InputDecoration(labelText: 'Search for Topic'),
              ),
            ),
          ),
          gotData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //show results
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    ResultsUI(surveys: mySurveys)));
                        //
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(mySurveys[index].topic),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('No. of Submssions ${mySurveys.length}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(child: Text("Empty")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (searchController.text != "") {
            searchForSurvey();
            searchController.text = "";
          }
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
