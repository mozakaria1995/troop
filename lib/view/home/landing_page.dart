import 'package:flutter/material.dart';
import 'package:qixer/view/home/home.dart';

import 'bottom_nav.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<LandingPage> {
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  //Bottom nav pages
  final List<Widget> _children = [
    const Homepage(),
    const Homepage(),
    const Homepage(),
    const Homepage(),
    const Homepage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }
}