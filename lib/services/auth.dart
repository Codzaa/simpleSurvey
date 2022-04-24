import 'package:hive_flutter/hive_flutter.dart';
import 'package:survey/models/AdminModel.dart';
import 'package:survey/services/server.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  ///
  static late AdminUser globalUserObj;

  /// Function to login
  static AdminUser login(String username, String password) {
    var user = AdminUser(id: "", name: "", password: "", companyName: "");
    //
    var box = Hive.box<AdminUser>(ServerC.ADMIN_BOX);
    //
    var result = box.get(username);
    if (result!.password == password) {
      user = result;
      globalUserObj = user;
    }
    print(result.name);
    //
    return user;
  }

  /// Function Signing Up
  static String signUp(String username, String password, String companyName) {
    ///
    String result = "Success";

    ///
    var box = Hive.box<AdminUser>(ServerC.ADMIN_BOX);

    /// Check if User Already Exits
    var userExits = doesUserExist(box, username);
    if (userExits == false) {
      //
      var uuid = const Uuid();

      /// Generate a v1 (time-based) id
      var myId = uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
      var myUser = AdminUser(
          id: myId,
          name: username,
          password: password,
          companyName: companyName);

      /// Save the User
      saveUser(box, myUser, username);
      globalUserObj = myUser;

      /// Save User into Database
      result = "Success";
    } else {
      ///
      result = "User Already Exists";
    }
    return result;
  }

  /// Function to Check if the user exists
  static bool doesUserExist(Box<dynamic> box, String username) {
    bool result = true;
    var user = box.get(username);
    if (user == null) {
      result = false;
    } else {
      ///
      globalUserObj = user;
    }
    return result;
  }

  /// Function to save the user
  static void saveUser(
      Box<dynamic> box, dynamic userToSave, String username) async {
    //
    await box.put(username, userToSave);
    //
  }
}
