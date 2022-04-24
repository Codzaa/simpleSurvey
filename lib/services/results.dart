import 'package:hive_flutter/hive_flutter.dart';
import 'package:survey/models/SubmittedSurvey.dart';
import 'package:survey/models/SurveyModel.dart';
import 'package:survey/services/server.dart';

class ResultsService {
  //

  static double calculateSupportSurvey(List<SubmittedSurvey> _surveys) {
    double cals = 0;
    var numOfSurveys = _surveys.length;
    //
    for (var survey in _surveys) {
      for (var question in survey.questions) {
        if (question.isYes) {
          /// Add
          cals++;
        } else {
          /*
          if (cals > 0) {
            /// Sub
            cals--;
          }
          */
        }
      }
    }
    //
    print("Raw" + cals.toString());
    print("Percent" + (cals / (5 * numOfSurveys)).toString());
    cals = cals / (5 * numOfSurveys);
    return cals;
  }
  //
}
