import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:survey/models/SubmittedSurvey.dart';
import 'package:survey/services/results.dart';

class ResultsUI extends StatefulWidget {
  List<SubmittedSurvey> surveys;
  ResultsUI({Key? key, required this.surveys}) : super(key: key);

  @override
  State<ResultsUI> createState() => _ResultsUIState();
}

class _ResultsUIState extends State<ResultsUI> {
  double supportV = 0;
  double againstV = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncFunctions();
  }

  asyncFunctions() {
    //
    supportV = ResultsService.calculateSupportSurvey(widget.surveys);
    supportV = supportV * 100;
    againstV = 100 - supportV;
    setState(() {});
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${widget.surveys.first.topic} Survey Results"),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text("Number of Submissions"),
              subtitle: Text(widget.surveys.length.toString()),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Total of Questions"),
              subtitle: Text(widget.surveys.first.questions.length.toString()),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("No. of People Supporting The Survey"),
              subtitle: Text("${supportV.toString()} %"),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("No. of People Against The Survey"),
              subtitle: Text("${againstV.toString()} %"),
            ),
          ),
          Expanded(
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 70,
                sections: showingSections(),
                // read about it in the PieChartData section
              ),
              swapAnimationDuration: Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: supportV,
            title: "Support",
            radius: 60,
            titleStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: againstV,
            title: "Against",
            radius: 80,
            titleStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
