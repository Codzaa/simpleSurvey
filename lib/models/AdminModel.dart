import 'package:hive/hive.dart';

part 'AdminModel.g.dart';

@HiveType(typeId: 1)
class AdminUser {
  //-//
  @HiveField(0)
  String id;
  //-//
  @HiveField(1)
  String name;
  //-//
  @HiveField(2)
  String password;
  //-//
  @HiveField(3)
  String companyName;
  //-//
  AdminUser(
      {required this.id,
      required this.name,
      required this.password,
      required this.companyName});
}
