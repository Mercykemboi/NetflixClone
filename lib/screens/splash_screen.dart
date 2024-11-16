import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_app/screens/main_screen.dart'; // Correct import for MainScreen
import '../widgets/status_bar.dart'; // Import the custom status bar widget

class IntroAnimationScreen extends StatefulWidget {
  const IntroAnimationScreen({super.key});

  @override
  _IntroAnimationScreenState createState() => _IntroAnimationScreenState();
}

class _IntroAnimationScreenState extends State<IntroAnimationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int _selectedIndex = 0; // For bottom navigation tabs
  // Placeholder pages for navigation tabs
  static final List<Widget> _pages = <Widget>[
    Center(child: Text('', style: TextStyle(color: Colors.white, fontSize: 18))),
    Center(child: Text('', style: TextStyle(color: Colors.white, fontSize: 18))),
    Center(child: Text('', style: TextStyle(color: Colors.white, fontSize: 18))),
  ];

  // Method to handle navigation tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen1()), // Navigate to MainScreen after animation
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Lottie animation at the center
          Center(
            child: Lottie.asset(
              'assets/netflixintro.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
                _controller.forward(); // Start the animation
              },
            ),
          ),

          // Custom status bar at the top
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomStatusBar(), // Add the custom status bar widget here
          ),

          // Display the selected tab's content in the background
          Positioned.fill(
            child: Column(
              children: [
                const CustomStatusBar(), // Custom status bar remains at the top
                Expanded(
                  child: _pages[_selectedIndex], // Display content for the selected tab
                ),
              ],
            ),
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
