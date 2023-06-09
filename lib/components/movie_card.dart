import 'package:flutter/material.dart';
import 'package:watch_me/components/rating.dart';
import 'package:watch_me/models/movie.dart';
import 'package:watch_me/utils/colors.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function refresh;

  const MovieCard({super.key, required this.movie, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background2,
      child: TextButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  color: AppColors.background,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextButton(
                          child: const Text('Open info',
                              style: TextStyle(color: AppColors.yellow)),
                          onPressed: () async {
                            await Navigator.pushNamed(context, '/movie_details',
                                arguments: {'id': movie.id});
                            if (context.mounted) Navigator.of(context).pop();
                            refresh();
                          },
                        ),
                        TextButton(
                            child: const Text('Edit',
                                style: TextStyle(color: AppColors.yellow)),
                            onPressed: () async {
                              await Navigator.pushNamed(
                                  context, '/manage_movie',
                                  arguments: {'id': movie.id});
                              if (context.mounted) Navigator.of(context).pop();
                              refresh();
                            })
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(
                      movie.imageUrl,
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
                          movie.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                        ),
                        Text(movie.description,
                            style: const TextStyle(color: AppColors.gray)),
                        const Spacer(),
                        StarRating(rating: movie.rating),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
