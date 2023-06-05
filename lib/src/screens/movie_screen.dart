import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/blocs/movie_bloc/movie_bloc_provider.dart';
import 'package:movies_app/src/models/movie/movie.dart';
import 'package:movies_app/src/network/endpoints.dart';
import 'package:movies_app/src/widgets/animated_scale_widget.dart';
import 'package:movies_app/src/widgets/my_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieScreen extends StatefulWidget {
  final Movie? movie;
  const MovieScreen({this.movie, Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderBackdrop(),
            _renderImageInfo(),
            const SizedBox(height: 30),
            _renderTitle('Overview'),
            const SizedBox(height: 8),
            _renderSubtitle(widget.movie?.overview ?? ''),
          ],
        ),
      ),
      appBar: MovieAppBar(movieTitle: widget.movie?.title ?? ''),
    );
  }

  Widget _renderImageInfo() {
    return Row(
      children: [
        _renderImage(),
        const SizedBox(width: 30),
        Column(
          children: [
            _renderTitle(widget.movie?.releaseDate ?? ''),
            _renderSubtitle('${widget.movie?.voteAverage?.toString() ?? ' '}/10'),
            _renderSubtitle('Total votes: ${widget.movie?.voteCount?.toString() ?? ' '}'),
            _renderSubtitle('Popularity: ${widget.movie?.popularity?.toString() ?? ''}'),
          ],
        ),
      ],
    );
  }

  Widget _renderImage() {
    return AnimatedScaleWidget(
      child: CachedNetworkImage(
        height: 150,
        imageUrl: '${Endpoints.images}${widget.movie?.posterPath}',
        errorWidget: (context, url, error) => const Icon(Icons.error_outline_rounded),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _renderBackdrop() {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedScaleWidget(
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              imageUrl: '${Endpoints.images}${widget.movie?.backdropPath}',
              errorWidget: (context, url, error) => const Icon(Icons.error_outline_rounded),
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              fit: BoxFit.cover,
            ),
          ),
          FutureBuilder(
            future: MovieBlocProvider.of(context).getMovieTrailer(widget.movie),
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              return GestureDetector(
                onTap: () => _showVideoPlayer(snapshot.data!),
                child: const Icon(
                  CupertinoIcons.play_circle,
                  color: Colors.white,
                  size: 50,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _renderTitle(String text) {
    return Text(text, style: Theme.of(context).textTheme.titleLarge);
  }

  Widget _renderSubtitle(String text) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }

  void _showVideoPlayer(String link) async {
    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: link,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            insetPadding: const EdgeInsets.all(16.0),
            //
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.6,
              child: YoutubePlayer(
                controller: controller,
                actionsPadding: EdgeInsets.zero,
                showVideoProgressIndicator: true,
              ),
            ),
          );
        });
  }
}
