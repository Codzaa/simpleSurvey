// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubmittedSurvey.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubmittedSurveyAdapter extends TypeAdapter<SubmittedSurvey> {
  @override
  final int typeId = 3;

  @override
  SubmittedSurvey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubmittedSurvey(
      id: fields[0] as String,
      ownerId: fields[1] as String,
      topic: fields[2] as String,
      questions: (fields[3] as List).cast<QuestionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubmittedSurvey obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ownerId)
      ..writeByte(2)
      ..write(obj.topic)
      ..writeByte(3)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubmittedSurveyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
