import 'package:flutter/material.dart';
import '../models/movies.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              movie.imageUrl,
              height: 200,
              width: 130,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 1),
        ],
      ),
    );
  }
}
