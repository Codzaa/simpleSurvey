import 'package:flutter/material.dart';
import '../surveys/mysurveys.dart';
import '../surveys/submittedsurvey.dart';

class AdminDashboardUI extends StatefulWidget {
  AdminDashboardUI({Key? key}) : super(key: key);

  @override
  State<AdminDashboardUI> createState() => _AdminDashboardUIState();
}

class _AdminDashboardUIState extends State<AdminDashboardUI> {
  int _selectedIndex = 0;
  //
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  //
  static final List<Widget> _widgetOptions = <Widget>[
    MySurveysUI(),
    MySubmittedSurveyUI()
  ];
  //
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 20,
              left: 30,
              child: FloatingActionButton(
                heroTag: "Back",
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_new),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'My Surveys',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Submitted Surveys',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}
