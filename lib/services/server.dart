import 'package:hive_flutter/hive_flutter.dart';
import '../models/AdminModel.dart';
import '../models/QuestionModel.dart';
import '../models/SubmittedSurvey.dart';
import '../models/SurveyModel.dart';

class ServerC {
  // ignore: constant_identifier_names
  static const String ADMIN_BOX = "ADMIN_BOX";

  ///
  // ignore: constant_identifier_names
  static const String SURVEY_BOX = "SURVEY_BOX";

  /// All Surveys
  static const String SURVEY_BOX_ALL = "SURVEY_BOX_ALL";

  ///
  // ignore: constant_identifier_names
  static const String SUBMITTED_BOX = "SUBMITTED_BOX";

  ///
  static const String SUBMITTED_BOX_ALL = "SUBMITTED_BOX_ALL";

  /// Function for initializing the Database/
  static init() async {
    //
    await Hive.initFlutter();
    //
  }

  /// Register Custom Adapters
  static void registerAdpters() {
    ///
    Hive.registerAdapter(AdminUserAdapter());
    Hive.registerAdapter(SurveyModelAdapter());
    Hive.registerAdapter(QuestionModelAdapter());
    Hive.registerAdapter(SubmittedSurveyAdapter());
  }

  /// Open Local Users
  static openBoxes() async {
    ///
    await Hive.openBox<AdminUser>(ADMIN_BOX);

    ///
    await Hive.openBox<SurveyModel>(SURVEY_BOX);
    await Hive.openBox(SURVEY_BOX_ALL);

    ///
    await Hive.openBox<SubmittedSurvey>(SUBMITTED_BOX);
    await Hive.openBox(SUBMITTED_BOX_ALL);
  }
}
