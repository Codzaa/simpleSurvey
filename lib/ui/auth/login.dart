import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../dashboard/adminBoard.dart';

class LoginUI extends StatefulWidget {
  LoginUI({Key? key}) : super(key: key);

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  /// Username Text Controller
  final TextEditingController userNameController = TextEditingController();

  /// Password Text Controller
  final TextEditingController passwordController = TextEditingController();

  /// Sign Up/Register Function
  loginF() {
    ///
    var result =
        AuthService.login(userNameController.text, passwordController.text);
    if (result.id != "") {
      ///
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => AdminDashboardUI()));
    } else {
      ///
      print(result);
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Ooops'),
                content: const Text('Username or password not correct'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ));

      ///
    }
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [const Center(child: Text("Login")), buildForm()],
      ),
    );
  }

  Widget buildForm() {
    return Column(
      children: [
        Center(
          child: TextField(
            controller: userNameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
        ),
        Center(
          child: TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
            width: 100,
            height: 50,
            child: TextButton(
              onPressed: () {
                loginF();
              },
              child: const Text("Login"),
              style: TextButton.styleFrom(backgroundColor: Colors.amber),
            ))
      ],
    );
  }
}
