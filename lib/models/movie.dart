class Movie {
  final String id;
  final String imageUrl;
  final String title;
  final String genre;
  final String ageRange;
  final int runtime;
  final double rating;
  final String description;
  final int year;

  Movie({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.genre,
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
      genre: json['genre'],
      ageRange: json['ageRange'],
      runtime: json['runtime'],
      rating: json['rating'],
      description: json['description'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'genre': genre,
        'ageRange': ageRange,
        'runtime': runtime,
        'rating': rating,
        'description': description,
        'year': year,
      };
}
