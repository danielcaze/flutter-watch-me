import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:watch_me/components/movie-card.dart';
import 'package:watch_me/models/movie.dart';
import 'package:watch_me/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'watch-me',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Watch-me'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> movies = [
    Movie(
        id: Uuid(),
        imageUrl: 'https://github.com/danielcaze.png',
        title: 'Movie 1',
        description: 'This is a description of movie 1.',
        rating: 3.9,
        ageRange: '14',
        gender: 'HORROR',
        runtime: const Duration(hours: 12),
        year: 2012),
    // Add more movies here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.yellow,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Team:"),
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Alisson Silva - RGM: 23405589"),
                          Text("Daniel Cazé - RGM: 23467932"),
                          Text("Daniel Vitor - RGM: 23381876"),
                          Text("Victor Fernandes - RGM: "),
                        ]),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              )
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieCard(
            imageUrl: movies[index].imageUrl,
            title: movies[index].title,
            description: movies[index].description,
            rating: movies[index].rating,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Add a new movie',
        child: const Icon(Icons.add),
      ),
    );
  }
}
