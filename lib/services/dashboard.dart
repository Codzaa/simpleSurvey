import 'package:hive_flutter/hive_flutter.dart';
import 'package:survey/services/auth.dart';

import '../models/AdminModel.dart';
import '../models/SurveyModel.dart';
import 'server.dart';

class DashboardService {
  //

  static List<SurveyModel>? getUserSurveys() {
    //
    var box = Hive.box<SurveyModel>(ServerC.SURVEY_BOX);

    /// Get the List of Surveys
    var result = box.get(AuthService.globalUserObj.name)!;
    //
    print(result);
  }
  //
}
