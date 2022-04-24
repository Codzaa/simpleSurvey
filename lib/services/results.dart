import 'package:hive_flutter/hive_flutter.dart';
import 'package:survey/models/SubmittedSurvey.dart';
import 'package:survey/models/SurveyModel.dart';
import 'package:survey/services/server.dart';

class ResultsService {
  //

  static double calculateSupportSurvey(SubmittedSurvey _survey) {
    double cals = 0;
    //
    var box = Hive.box(ServerC.SUBMITTED_BOX_ALL);
    //
    var results = box.get(_survey.ownerId);
    //
    List<SubmittedSurvey> subSs = results.cast<SubmittedSurvey>();
    for (var survey in subSs) {
      for (var question in survey.questions) {
        if (question.isYes) {
          /// Add
          cals++;
        } else {
          if (cals != 0) {
            /// Sub
            cals--;
          }
        }
      }
    }
    //
    print("Raw" + cals.toString());
    print("Percent" + (cals / 5).toString());
    cals = cals / 5;
    return cals;
  }
  //
}
