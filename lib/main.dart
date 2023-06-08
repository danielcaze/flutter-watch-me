import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:watch_me/components/movie_card.dart';
import 'package:watch_me/models/movie.dart';
import 'package:watch_me/screens/register_movie.dart';
import 'package:watch_me/services/database_helper.dart';
import 'package:watch_me/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initializeDatabase();
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
      routes: {
        '/register-movie': (context) =>
            MovieRegistrationPage(), // This is your second page.
      },
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
      body: FutureBuilder<List<Movie>?>(
          future: DatabaseHelper.getAll(),
          builder: (context, AsyncSnapshot<List<Movie>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: AppColors.white),
              ));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      imageUrl: snapshot.data![index].imageUrl,
                      title: snapshot.data![index].title,
                      description: snapshot.data![index].description,
                      rating: snapshot.data![index].rating,
                    );
                  },
                );
              }
            }
            return const Center(
                child: Text(
              "No movies registered yet. Try registering a new movie!",
              style: TextStyle(color: AppColors.white),
            ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/register-movie');
          setState(() {});
        },
        tooltip: 'Add a new movie',
        backgroundColor: AppColors.yellow,
        child: const Icon(Icons.add, color: AppColors.background2),
      ),
    );
  }
}
