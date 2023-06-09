import 'package:flutter/material.dart';
import 'package:watch_me/components/movie_card.dart';
import 'package:watch_me/models/movie.dart';
import 'package:watch_me/screens/movie_details.dart';
import 'package:watch_me/screens/manage_movie.dart';
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
      theme: AppColors.theme,
      home: const MyHomePage(title: 'Watch-me'),
      routes: {
        '/manage_movie': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          final movieId = args?['id'] as String?;
          return ManageMoviePage(movieId: movieId ?? '');
        }, // This is your second page.
        '/movie_details': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          final movieId = args?['id'] as String?;
          return MovieDetailsPage(movieId: movieId ?? '');
        }, // This is your second page.
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
  void _refresh() {
    setState(() {});
  }

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
            icon: const Icon(Icons.info_outline),
            onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Team:",
                        style: TextStyle(color: AppColors.white)),
                    content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Alisson Silva - RGM: 23405589",
                              style: TextStyle(color: AppColors.white)),
                          Text("Daniel Cazé - RGM: 23467932",
                              style: TextStyle(color: AppColors.white)),
                          Text("Daniel Vitor - RGM: 23381876",
                              style: TextStyle(color: AppColors.white)),
                          Text("Victor Fernandes - RGM: 23383828",
                              style: TextStyle(color: AppColors.white)),
                        ]),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("Close",
                            style: TextStyle(color: AppColors.yellow)),
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
                style: const TextStyle(color: AppColors.white),
              ));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return Dismissible(
                        key: Key(item.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            DatabaseHelper.delete(item);
                          }
                          _refresh();
                        },
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.background2,
                          ),
                        ),
                        child: MovieCard(movie: item, refresh: _refresh));
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
          await Navigator.pushNamed(context, '/manage_movie');
          _refresh();
        },
        tooltip: 'Add a new movie',
        backgroundColor: AppColors.yellow,
        child: const Icon(Icons.add, color: AppColors.background2),
      ),
    );
  }
}
