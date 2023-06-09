import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:watch_me/models/movie.dart';
import 'package:watch_me/services/database_helper.dart';
import 'package:watch_me/utils/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieRegistrationPage extends StatefulWidget {
  MovieRegistrationPage({Key? key}) : super(key: key);

  @override
  State<MovieRegistrationPage> createState() => _MovieRegistrationPageState();
}

class _MovieRegistrationPageState extends State<MovieRegistrationPage> {
  bool isEditing = false;
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  String ageRange = 'Select Age Range';
  TextEditingController runtimeController = TextEditingController();
  double rating = 0.0;
  TextEditingController yearController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  createMovie(context) async {
    final movie = Movie(
      id: !isEditing ? const Uuid().v4() : 'id do item aqui',
      imageUrl: imageUrlController.text,
      title: titleController.text,
      genre: genreController.text,
      ageRange: ageRange,
      runtime: int.parse(runtimeController.text),
      rating: rating,
      year: int.parse(yearController.text),
      description: descriptionController.text,
    );

    if (!isEditing) {
      await DatabaseHelper.insert(movie);
    } else {
      await DatabaseHelper.update(movie);
    }

    imageUrlController.clear();
    titleController.clear();
    genreController.clear();
    ageRange = 'Select Age Range';
    runtimeController.clear();
    rating = 0.0;
    yearController.clear();
    descriptionController.clear();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background2,
        title: const Text('Movie Registration',
            style: TextStyle(color: AppColors.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            TextFormField(
              controller: imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                labelStyle: TextStyle(color: AppColors.white),
              ),
              style: const TextStyle(color: AppColors.white),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: AppColors.white),
              ),
              style: const TextStyle(color: AppColors.white),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: genreController,
              decoration: const InputDecoration(
                labelText: 'Genre',
                labelStyle: TextStyle(color: AppColors.white),
              ),
              style: const TextStyle(color: AppColors.white),
            ),
            const SizedBox(height: 20.0),
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: AppColors.background,
                textTheme: const TextTheme(
                  titleMedium: const TextStyle(color: AppColors.white),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: AppColors.background2,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: ageRange,
                  underline: const SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      ageRange = newValue!;
                    });
                  },
                  items: <String>[
                    'Select Age Range',
                    'G',
                    '10',
                    '12',
                    '14',
                    '16',
                    '18'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: DefaultTextStyle(
                        style: TextStyle(color: AppColors.white),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: runtimeController,
              decoration: const InputDecoration(
                labelText: 'Duration',
                labelStyle: TextStyle(color: AppColors.white),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.white),
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rating:',
                    style: TextStyle(color: AppColors.white),
                  ),
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: AppColors.yellow),
                    onRatingUpdate: (rating) {
                      setState(() {
                        this.rating = rating;
                      });
                    },
                  ),
                ],
              ),
            ),
            TextFormField(
              controller: yearController,
              decoration: const InputDecoration(
                labelText: 'Year',
                labelStyle: TextStyle(color: AppColors.white),
                counterText: "",
              ),
              maxLength: 4,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.white),
            ),
            const SizedBox(height: 5.0),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: AppColors.white),
              ),
              maxLines: 3,
              style: const TextStyle(color: AppColors.white),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createMovie(context),
        backgroundColor: AppColors.yellow,
        tooltip: "Save",
        child: const Icon(Icons.save, color: AppColors.background2),
      ),
    );
  }
}
