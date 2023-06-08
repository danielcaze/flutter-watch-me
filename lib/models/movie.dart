import 'package:uuid/uuid.dart';

class Movie {
  final Uuid id;
  final String imageUrl;
  final String title;
  final String gender;
  final String ageRange;
  final Duration runtime;
  final double rating;
  final String description;
  final int year;

  Movie({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.gender,
    required this.ageRange,
    required this.runtime,
    required this.rating,
    required this.description,
    required this.year,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      gender: json['gender'],
      ageRange: json['ageRange'],
      runtime: Duration(minutes: json['runtime']),
      rating: json['rating'],
      description: json['description'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'gender': gender,
        'ageRange': ageRange,
        'runtime': runtime.inMinutes,
        'rating': rating,
        'description': description,
        'year': year,
      };
}
