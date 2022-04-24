import 'package:hive_flutter/hive_flutter.dart';

part 'QuestionModel.g.dart';

@HiveType(typeId: 4)
class QuestionModel {
  @HiveField(0)
  String body;
  @HiveField(1)
  bool isYes;
  @HiveField(2)
  bool isNo;

  QuestionModel({
    required this.body,
    required this.isNo,
    required this.isYes,
  });
}
