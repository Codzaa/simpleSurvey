// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdminModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminUserAdapter extends TypeAdapter<AdminUser> {
  @override
  final int typeId = 1;

  @override
  AdminUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminUser(
      id: fields[0] as String,
      name: fields[1] as String,
      lastName: fields[2] as String,
      companyName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdminUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.companyName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
