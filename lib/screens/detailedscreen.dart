import 'package:flutter/material.dart';
import '../models/movies.dart';
import '../widgets/status_bar.dart'; // Import the custom status bar widget

class DetailedScreen extends StatelessWidget {
  final Movie movie;
  const DetailedScreen({super.key, required this.movie});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Add the custom status bar
          const CustomStatusBar(),

          // The app bar with a back button
          Container(
            color: const Color.fromARGB(255, 24, 24, 24), // AppBar background color
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop(); // Navigate back to the previous screen
                  },
                ),
              ],
            ),
          ),

          // Movie details content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie image
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: 300, // Fixed height for the image
                          width: double.infinity, // Stretch image to full width
                          child: Image.network(
                            movie.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Movie title
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 8),

                    // Row for rating and release date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Align items on opposite sides
                      children: [
                        // Movie rating
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.star,
                        //       color: Colors.yellow,
                        //       size: 24,
                        //     ),
                        //     const SizedBox(width: 8),
                        //     Text(
                        //       movie.rating.toString(),
                        //       style: const TextStyle(
                        //         fontSize: 16,
                        //         color: Colors.white70,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        
                        // Movie release date
                        Text(
                          movie.releaseDate,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 10),

                    // Movie description
                    Text(
                      movie.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
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
