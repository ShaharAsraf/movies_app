import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/src/models/movie/movie.dart';
import 'package:movies_app/src/network/requests.dart';
import 'package:movies_app/src/utils/enums.dart';
import 'package:movies_app/src/utils/prefs.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

@injectable
class MovieBloc {
  static MovieBloc? instance;
  factory MovieBloc() {
    if (instance == null) {
      instance = MovieBloc._();
      instance!.init();
    }
    return instance!;
  }

  MovieBloc._() : super();

  final Requests requests = Requests();
  final ValueNotifier<MoviesFilter> filterNotifier = ValueNotifier<MoviesFilter>(MoviesFilter.values.first);
  int page = 1;
  int totalPages = 10;
  bool isLoading = false;

  final _moviesSubject = BehaviorSubject<List<Movie>?>.seeded(null);

  Stream<List<Movie>?> get moviesStream => _moviesSubject.stream;

  void init() async {
    await fetchMovies();
  }

  Future<void> fetchMovies({bool pagination = false}) async {
    if (page == totalPages || isLoading) {
      return;
    }
    try {
      isLoading = true;
      if (pagination) {
        page++;
      }
      final response = await requests.fetchMovies(filterNotifier.value, page);
      if (response == null) {
        throw Exception('error');
      }
      final int? total = response['total_pages'];
      if (total != null) {
        totalPages = total;
      }
      final List<Movie> movies = (response['results'] as List? ?? []).map((e) => Movie.fromJson(e)).toList();
      if (pagination) {
        _moviesSubject.sink.add([..._moviesSubject.value ?? [], ...movies]);
      } else {
        _moviesSubject.sink.add(movies);
      }
      Prefs.setMovies(movies);
      isLoading = false;
    } catch (e) {
      _moviesSubject.sink.add(Prefs.storedMovies);
    }
  }

  void onFilterChange(MoviesFilter filter) {
    page = 1;
    totalPages = 10;
    filterNotifier.value = filter;
    _moviesSubject.sink.add(null);
    fetchMovies();
  }

  dispose() {
    _moviesSubject.close();
  }

  void clear() {
    _moviesSubject.sink.add([]);
    page = 1;
    totalPages = 10;
    isLoading = false;
  }

  Future<String?> getMovieTrailer(Movie? movie) async {
    if (movie == null || movie.id == null) {
      return null;
    }
    try {
      final res = await requests.fetchMovieTrailer(movie.id!);
      if (res != null && res['results'] != null) {
        final trailer = (res['results'] as List).firstWhereOrNull((e) => e['type'] == 'Trailer');
        return trailer['key'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
