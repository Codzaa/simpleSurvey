import 'package:hive/hive.dart';
import 'package:survey/models/QuestionModel.dart';

part 'SubmittedSurvey.g.dart';

@HiveType(typeId: 3)
class SurveyModel {
  //-//
  @HiveField(0)
  String id;
  //-//
  @HiveField(1)
  String ownerId;
  //-//
  @HiveField(2)
  String topic;
  //-//
  @HiveField(3)
  List<QuestionModel> questions;
  //
  SurveyModel({
    required this.id,
    required this.ownerId,
    required this.topic,
    required this.questions,
  });
}
