import 'package:flutter/material.dart';

class CustomStatusBar extends StatelessWidget {
  const CustomStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Background color of the status bar
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 24, // Typical height of a status bar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side items (time + icons)
          Row(
            children: [
              // Time text
              Text(
                '8:21', // Displayed time
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(width: 8), // Spacing between time and icons

              // Warning Icon
              Icon(Icons.warning, color: Colors.white, size: 16),

              SizedBox(width: 4), // Spacing

              // App Notification Icon (e.g., App A)
              Icon(Icons.apps, color: Colors.white, size: 16),

              SizedBox(width: 4), // Spacing

              // Email Notification Icon
              Icon(Icons.email, color: Colors.white, size: 16),

              SizedBox(width: 4), // Spacing

              // WhatsApp-like Notification Icon
              Icon(Icons.chat, color: const Color.fromARGB(255, 140, 196, 142), size: 16),

              SizedBox(width: 4), // Spacing

              // A Dot Icon
              Icon(Icons.circle, color: Colors.white, size: 6),
            ],
          ),

          // Right side items (signal, Wi-Fi, battery)
          Row(
            children: [
              Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Icon(Icons.wifi, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Icon(Icons.battery_full, color: Colors.white, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}
