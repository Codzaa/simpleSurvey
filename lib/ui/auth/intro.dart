import 'package:flutter/material.dart';
import 'package:survey/ui/client/dashboard.dart';
import '../../services/server.dart';
import 'login.dart';
import 'signup.dart';

class IntroUI extends StatefulWidget {
  IntroUI({Key? key}) : super(key: key);

  @override
  State<IntroUI> createState() => _IntroUIState();
}

class _IntroUIState extends State<IntroUI> {
  bool boxesOpened = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///
    asyncFunctions();
  }

  ///
  void asyncFunctions() async {
    //
    await ServerC.init();
    ServerC.registerAdpters();
    await ServerC.openBoxes();
    //boxesOpened = true;
    setState(() {
      boxesOpened = true;
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    return boxesOpened
        ? Column(
            children: [
              TextButton(
                  onPressed: () {
                    //
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => SignUpUI()));
                    //
                  },
                  child: const Text("Sign Up")),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => LoginUI()));
                  },
                  child: const Text("Login")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ClientDashUI()));
                  },
                  child: const Text("Take Survey")),
            ],
          )
        : Column();
  }
}
