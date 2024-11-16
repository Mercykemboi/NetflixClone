import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movies.dart';

class ApiService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '9e8ee532c2c2d5af6e9922ad48e6c79c';

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top-rated movies');
    }
  }
   Future<List<Movie>> fetchUpcomingMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/upcoming?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> movieList = jsonDecode(response.body)['results'];
      return movieList.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

    Future<List<Movie>> fetchTop10Movies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      
      // Limit to top 10 movies
      final top10Movies = results.take(10).toList();
      
      return top10Movies.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top 10 movies');
    }
  }

}

