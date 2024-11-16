import 'dart:async';
import 'package:flutter/material.dart';
import '../models/movies.dart';
import '../services/apiservice.dart';
import '../widgets/moviecard.dart';
import 'detailedscreen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final PageController _pageController = PageController(viewportFraction: 0.8);
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  
    // Set up timer for auto-scrolling the upcoming movies
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      title: Image.asset(
  'assets/netflix.png',
  height: 50, // Adjust height as needed
),
   
      backgroundColor: Colors.black,
      elevation: 0,
       actions: [
          // Add the account icon with circular background
        Padding(
  padding: const EdgeInsets.only(right: 16.0),
  child: Container(
    width: 28,  // Width of the square icon
    height: 28, // Height of the square icon
    decoration: BoxDecoration(
      color: Colors.blue,          // Background color of the icon
      borderRadius: BorderRadius.circular(4), // Rounded corners for a slightly rounded square
    ),
    child: IconButton(
      icon: const Icon(Icons.person, color: Colors.white, size: 18), // White person icon inside the square
      onPressed: () {
        // Add functionality here, like opening a profile page
      },
      padding: EdgeInsets.zero, // Remove padding inside IconButton
      constraints: const BoxConstraints(), // Remove default IconButton constraints
    
 
              ),
            ),
          ),
        ],
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUpcomingSection(context),
          _buildSection(context, 'Popular', apiService.fetchPopularMovies),
          _buildSection(context, 'Top Rated', apiService.fetchTopRatedMovies),
           _buildTopSection(context, 'Top 10 Movies in Kenya', apiService.fetchTop10Movies),
            _buildSection(context, 'Continue Watching', apiService.fetchTopRatedMovies),
        ],
      ),
    ),
  );
}

Widget _buildTopSection(BuildContext context, String title, Future<List<Movie>> Function() fetchMovies) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: FutureBuilder<List<Movie>>(
            future: fetchMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final movie = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Stack(
                        clipBehavior: Clip.none, // To allow the number to overlap the card
                        children: [
                          // MovieCard
                          MovieCard(
                            movie: movie,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailedScreen(movie: movie),
                                ),
                              );
                            },
                          ),
                          // Number before the movie card
                          Positioned(
                            top: 10, // Position number above the movie card
                            left: -5, // Position the number slightly left and overlap
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6), // Semi-transparent background
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${index + 1}', 
                                style: const TextStyle(
                                  color: Colors.white, 
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}


  Widget _buildUpcomingSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Upcoming',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: FutureBuilder<List<Movie>>(
              future: apiService.fetchUpcomingMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  final movies = snapshot.data ?? [];
                  return PageView.builder(
                    controller: _pageController,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 34.0),
                        child: MovieCard(
                          movie: movie,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailedScreen(movie: movie),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Future<List<Movie>> Function() fetchMovies) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: FutureBuilder<List<Movie>>(
              future: fetchMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final movie = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: MovieCard(
                          movie: movie,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailedScreen(movie: movie),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
 }
