import 'package:flutter/material.dart';
import 'package:health/loginPage.dart';
import 'package:health/sensor_data_page.dart';
import 'package:health/videos_page.dart';
import 'package:health/weeklyGraph.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health App',
      theme: ThemeData(
        primaryColor: Colors.black,
        hintColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    VideosPage(),
    WeeklyGraphPage(),
    SensorDataPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AnimatedBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AnimatedBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.video_library,
            color: Colors.black, // Set the icon color
          ),
          label: 'Videos',
          activeIcon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.greenAccent,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            child: Icon(
              Icons.video_library,
              size: 30,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pie_chart,
            color: Colors.black, // Set the icon color
          ),
          label: 'Weekly Graph',
          activeIcon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.greenAccent,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            child: Icon(
              Icons.pie_chart,
              size: 30,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.health_and_safety,
            color: Colors.black, // Set the icon color
          ),
          label: 'Sensor Data',
          activeIcon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.greenAccent,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            child: Icon(
              Icons.health_and_safety,
              size: 30,
            ),
          ),
        ),
      ],
      selectedItemColor: Colors.blueAccent, // Set the selected item color
      unselectedItemColor: Colors.grey, // Set the unselected item color
    );
  }
}
