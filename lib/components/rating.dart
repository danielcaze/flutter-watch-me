import 'package:flutter/material.dart';
import 'package:watch_me/utils/colors.dart';

class StarRating extends StatelessWidget {
  final double rating;

  StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
            index < rating.floor()
                ? Icons.star
                : (index < rating ? Icons.star_half : Icons.star_border),
            color: index < rating ? AppColors.yellow : AppColors.gray,
            size: 20);
      }),
    );
  }
}
