import 'package:flutter/material.dart';
import 'package:watch_me/utils/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieRegistrationPage extends StatefulWidget {
  MovieRegistrationPage({Key? key}) : super(key: key);

  @override
  State<MovieRegistrationPage> createState() => _MovieRegistrationPageState();
}

class _MovieRegistrationPageState extends State<MovieRegistrationPage> {
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  String ageRange = 'Select Age Range';
  TextEditingController durationController = TextEditingController();
  double rating = 0.0;
  TextEditingController yearController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
              controller: durationController,
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
        onPressed: () {
          // Handle saving the movie data here.
          // For now, we'll just print it to the console.
          print("Image URL: ${imageUrlController.text}");
          print('Title: ${titleController.text}');
          print('Genre: ${genreController.text}');
          print('Age Range: $ageRange');
          print(
              "Duration: ${Duration(hours: int.parse(durationController.text))}");
          print('Rating: $rating');
          print('Year: ${yearController.text}');
          print('Description: ${descriptionController.text}');
        },
        backgroundColor: AppColors.yellow,
        child: const Icon(Icons.save, color: AppColors.background2),
      ),
    );
  }
}
