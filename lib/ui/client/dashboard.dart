import 'package:flutter/material.dart';
import 'package:survey/services/survey.dart';
import 'package:survey/ui/client/takeSurvey.dart';

import '../../models/SurveyModel.dart';

class ClientDashUI extends StatefulWidget {
  ClientDashUI({Key? key}) : super(key: key);

  @override
  State<ClientDashUI> createState() => _ClientDashUIState();
}

class _ClientDashUIState extends State<ClientDashUI> {
  ///
  TextEditingController searchController = TextEditingController();

  ///
  List<SurveyModel> mySurveys = [];

  ///
  bool gotSurveys = false;
  searchSurvey() {
    if (searchController.text == "") {
      return;
    }

    ///
    mySurveys = SurveyService.searchSurvey(searchController.text);

    ///
    if (mySurveys.isNotEmpty) {
      ///
      setState(() {
        gotSurveys = true;
      });

      ///
    }
  }

  takeSurvey(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => TakeSurveyUI(survey: mySurveys[index])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take A Survey!"),
      ),
      body: Column(
        children: [
          Center(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                  labelText: 'Search for Survey by Author'),
            ),
          ),
          gotSurveys
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: mySurveys.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //
                        takeSurvey(index);
                        //
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(mySurveys[index].topic),
                        ),
                      ),
                    );
                  })
              : const Text("Empty")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          searchSurvey();
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
