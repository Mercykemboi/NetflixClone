import 'package:flutter/material.dart';
//import 'package:netflix_clone/screens/splash_screen.dart';
import 'homescreen.dart';
import '../widgets/status_bar.dart';  // Import your Custom Status Bar

class MainScreen1 extends StatefulWidget {
  const MainScreen1({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen1> {
  int _selectedIndex = 0;

  // List of pages for navigation
  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  // Method to handle the bottom navigation bar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const CustomStatusBar(),  // Custom status bar stays at the top
          Expanded(
            child: _pages[_selectedIndex],  // The selected page is displayed here
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle, size: 10), // Center dot
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stop),
            label: '',
          ),
        ],
      ),
    );
  }
}
