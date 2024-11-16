// lib/models/movies.dart
class Movie {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double rating;
  final Function onTap;
  final bool isRecentlyAdded; 
  final String releaseDate;


  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
     required this.onTap,
      this.isRecentlyAdded = false,
       required this.releaseDate

  });

  // Method to parse JSON data into a Movie object
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
     title: json['title'],
       releaseDate: json['release_date'] ?? 'Unknown', // Parse release date
      description: json['overview'],
      imageUrl: 'https://image.tmdb.org/t/p/w500' + json['poster_path'], // TMDb base URL
      rating: (json['vote_average'] as num).toDouble(),
        onTap: () {}, // Placeholder for onTap; update as needed
      isRecentlyAdded: false, // Default, you can update logic below
    );
    
  }
  
}
