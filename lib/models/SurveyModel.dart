import 'package:hive/hive.dart';
import 'package:survey/models/QuestionModel.dart';

part 'SurveyModel.g.dart';

@HiveType(typeId: 2)
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
  String companyName;
  //-//
  @HiveField(4)
  List<QuestionModel> questions;
  //
  SurveyModel({
    required this.id,
    required this.ownerId,
    required this.topic,
    required this.companyName,
    required this.questions,
  });
}
