import 'package:flutter/material.dart';
import 'package:watch_me/components/rating.dart';
import 'package:watch_me/models/movie.dart';
import 'package:watch_me/services/database_helper.dart';
import 'package:watch_me/utils/colors.dart';
import 'package:watch_me/utils/time.dart';

class MovieDetailsPage extends StatelessWidget {
  final String movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Details',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: FutureBuilder<Movie?>(
        future: DatabaseHelper.getMovie(movieId),
        builder: (BuildContext context, AsyncSnapshot<Movie?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text(
                'Failed to load movie details',
                style: TextStyle(color: AppColors.white),
              ),
            );
          } else {
            Movie movie = snapshot.data!;
            String imageUrl = movie.imageUrl;
            String movieTitle = movie.title;
            int releaseYear = movie.year;
            List<String> genres = [movie.genre];
            String ageRange = movie.ageRange;
            int runtime = movie.runtime;
            double rating = movie.rating;
            String description = movie.description;

            return Container(
              color: AppColors.background,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movieTitle,
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white),
                          ),
                        ),
                        Text(
                          releaseYear.toString(),
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            genres.join(', '),
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: AppColors.gray,
                            ),
                          ),
                        ),
                        Text(
                          '$ageRange anos',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            formatDuration(runtime),
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: AppColors.gray,
                            ),
                          ),
                        ),
                        StarRating(rating: rating),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      description,
                      style: const TextStyle(
                          fontSize: 16.0, color: AppColors.white),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
