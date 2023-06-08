import 'package:flutter/material.dart';
import 'package:watch_me/components/rating.dart';
import 'package:watch_me/utils/colors.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double rating;

  MovieCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background2,
      child: SizedBox(
        height: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: AppColors.white),
                    ),
                    Text(description,
                        style: const TextStyle(color: AppColors.gray)),
                    const Spacer(),
                    StarRating(rating: rating),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
