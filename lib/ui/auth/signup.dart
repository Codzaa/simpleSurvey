import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../dashboard/adminBoard.dart';

class SignUpUI extends StatefulWidget {
  SignUpUI({Key? key}) : super(key: key);

  @override
  State<SignUpUI> createState() => _SignUpUIState();
}

class _SignUpUIState extends State<SignUpUI> {
  /// Company Name Controller
  final TextEditingController companyNameController = TextEditingController();

  /// Username Text Controller
  final TextEditingController userNameController = TextEditingController();

  /// Password Text Controller
  final TextEditingController passwordController = TextEditingController();

  /// Sign Up/Register Function
  signUpRegister() {
    ///
    var result = AuthService.signUp(userNameController.text,
        passwordController.text, companyNameController.text);
    if (result == "Success") {
      ///
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => AdminDashboardUI()));
    } else {
      ///
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Ooopsss'),
                content: const Text('User Exists'),
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
        title: const Text("Sign Up"),
      ),
      body: Column(
        children: [buildForm()],
      ),
    );
  }

  Widget buildForm() {
    return Column(
      children: [
        Center(
          child: TextField(
            controller: companyNameController,
            decoration: const InputDecoration(labelText: 'Company Name'),
          ),
        ),
        Center(
          child: TextField(
            controller: userNameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
        ),
        Center(
          child: TextField(
            obscureText: true,
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
                signUpRegister();
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
            ))
      ],
    );
  }
}
