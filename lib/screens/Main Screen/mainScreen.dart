import 'package:babylid/screens/DashBoard%20Screen/dashboard.dart';
import 'package:babylid/screens/Milestones/add_milestone.dart';
import 'package:babylid/screens/Milestones/milestone.dart';
import 'package:babylid/utils/appcolors.dart';
import 'package:babylid/widgets/bottombar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const routeName = "/mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    setState(() {
      _currentIndex = 0;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> body = const [
    DashBoard(),
    Milestone(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: body[_currentIndex],
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        homePressed: () {
          setState(() {
            _currentIndex = 0;
          });
        },
        milestonePressed: () {
          setState(() {
            _currentIndex = 1;
          });
        },
        addPressed: () {
          Navigator.of(context).pushNamed(AddMilestoneScreen.routeName);
        },
      ),
    );
  }
}
