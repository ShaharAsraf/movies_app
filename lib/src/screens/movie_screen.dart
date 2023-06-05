import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie/movie.dart';
import 'package:movies_app/src/network/endpoints.dart';
import 'package:movies_app/src/widgets/my_app_bar.dart';

class MovieScreen extends StatelessWidget {
  final Movie? movie;
  const MovieScreen({this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Row(
            children: [_renderImage()],
          ),
        ],
      ),
      appBar: MovieAppBar(movieTitle: movie?.title ?? ''),
    );
  }

  Widget _renderImage() {
    return CachedNetworkImage(
      height: 300,
      imageUrl: '${Endpoints.images}${movie?.posterPath}',
      errorWidget: (context, url, error) =>
          const Icon(Icons.error_outline_rounded),
      fit: BoxFit.cover,
    );
  }
}
