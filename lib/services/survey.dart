import 'package:hive_flutter/hive_flutter.dart';
import 'package:survey/models/SubmittedSurvey.dart';
import 'package:survey/models/SurveyModel.dart';
import 'package:survey/services/auth.dart';
import 'package:survey/services/server.dart';
import 'package:uuid/uuid.dart';

import '../models/QuestionModel.dart';

class SurveyService {
  /// Function to get All the Surveys
  static List<SurveyModel> getSurveys() {
    List<SurveyModel> mylist = [];
    //
    var box = Hive.box(ServerC.SURVEY_BOX_ALL);
    //
    var result = box.get(AuthService.globalUserObj.name);
    //
    if (result == null) {
      //
    } else {
      //
      mylist = result.cast<SurveyModel>();
      //
    }
    return mylist;
  }

  //
  static void createSurvey(
      String _topic, List<QuestionModel> _questions) async {
    /**
     * id
     * ownerid
     * topic
     * companyName
     * questions(List<QuestionModel>)
     */
    var uuid = const Uuid();
    var myId = uuid.v1();
    var ownerId = AuthService.globalUserObj.name;
    var topic = _topic;
    var questions = _questions;
    //
    var newSurvey = SurveyModel(
        id: myId,
        ownerId: ownerId,
        topic: topic,
        companyName: AuthService.globalUserObj.companyName,
        questions: questions);
    //
    var box = Hive.box(ServerC.SURVEY_BOX_ALL);
    //
    List<SurveyModel> mySurveys = [];
    //
    var oldS = box.get(AuthService.globalUserObj.name);
    if (oldS != null) {
      mySurveys = oldS.cast<SurveyModel>();
    }
    //
    bool exists = true;
    //
    if (mySurveys.isNotEmpty) {
      for (var item in mySurveys) {
        if (item.topic != newSurvey.topic) {
          //
          exists = false;
        }
      }
    } else {
      //
      mySurveys.add(newSurvey);
      //
      await box.put(AuthService.globalUserObj.name, mySurveys);
    }

    if (!exists) {
      mySurveys.add(newSurvey);
      //
      await box.put(AuthService.globalUserObj.name, mySurveys);
    }
  }

  static void editSurvey(SurveyModel _survey) async {
    //
    var box = Hive.box<SurveyModel>(ServerC.SURVEY_BOX);
    //
    await box.put(AuthService.globalUserObj.name, _survey);
  }

  static List<SurveyModel> searchSurvey(String author) {
    ///
    var box = Hive.box(ServerC.SURVEY_BOX_ALL);

    ///
    List<SurveyModel> result = [];
    var results = box.get(author);
    if (results != null) {
      result = results.cast<SurveyModel>();
    }

    ///
    return result;
  }

  //
  static void deleteSurvey(SurveyModel _survey) async {
    List<SurveyModel> mySurveys = [];
    //
    var box = Hive.box(ServerC.SURVEY_BOX_ALL);
    //
    var oldS = box.get(AuthService.globalUserObj.name);
    //
    if (oldS != null) {
      mySurveys = oldS.cast<SurveyModel>();
      mySurveys.remove(_survey);
    }
    //box.delete(AuthService.globalUserObj.name);
    await box.put(AuthService.globalUserObj.name, mySurveys);
  }

  static void submitSurvey(SurveyModel _survey) async {
    //
    var uuid = const Uuid();
    var myId = uuid.v1();
    //
    List<SubmittedSurvey> newList = [];
    //
    SubmittedSurvey survey = SubmittedSurvey(
        id: myId,
        ownerId: _survey.ownerId,
        topic: _survey.topic,
        questions: _survey.questions);
    //
    var box = Hive.box(ServerC.SUBMITTED_BOX_ALL);
    //
    var oldList = box.get(_survey.ownerId);
    //
    if (oldList != null) {
      newList = oldList.cast<SubmittedSurvey>();
    }
    //
    newList.add(survey);
    //
    await box.put(_survey.ownerId, newList);
  }

  static List<SubmittedSurvey> getSubmittedSurvey(String searchValue) {
    List<SubmittedSurvey> results = [];
    List<SubmittedSurvey> results2 = [];
    //
    var box = Hive.box(ServerC.SUBMITTED_BOX_ALL);
    //
    var heros = box.get(AuthService.globalUserObj.name);
    //
    if (heros != null) {
      //
      results = heros.cast<SubmittedSurvey>();
      for (var item in results) {
        if (item.topic == searchValue) {
          results2.add(item);
        }
      }
      //
    }
    return results2;
  }
}
