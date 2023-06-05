import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/blocs/movie_bloc/movie_bloc_provider.dart';
import 'package:movies_app/src/models/movie/movie.dart';
import 'package:movies_app/src/network/endpoints.dart';
import 'package:movies_app/src/widgets/my_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(scrollListener);
    super.dispose();
  }

  void scrollListener() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!_controller.hasClients) {
      return;
    }
    final double trigger = 0.9 * _controller.position.maxScrollExtent;
    if (_controller.position.pixels >= trigger && context.mounted) {
      MovieBlocProvider.of(context).fetchMovies(pagination: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: StreamBuilder<List<Movie>?>(
          stream: MovieBlocProvider.of(context).moviesStream,
          builder: (context, AsyncSnapshot<List<Movie>?> snapshot) {
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return _renderMovies(snapshot.data ?? [], context);
          }),
    );
  }

  Widget _renderMovies(List<Movie> movies, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.count(
        crossAxisCount: 2,
        controller: _controller,
        padding: const EdgeInsets.all(8),
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        children: movies.map((e) => _renderMovie(e)).toList(),
      ),
    );
  }

  Widget _renderMovie(Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/movie_screen', arguments: movie);
      },
      child: CachedNetworkImage(
        imageUrl: '${Endpoints.images}${movie.posterPath}',
        errorWidget: (context, url, error) =>
            const Icon(Icons.error_outline_rounded),
        fit: BoxFit.cover,
      ),
    );
  }
}
