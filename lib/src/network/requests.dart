import 'package:injectable/injectable.dart';
import 'package:movies_app/src/network/endpoints.dart';
import 'package:movies_app/src/network/network_repository.dart';
import 'package:movies_app/src/utils/enums.dart';

abstract class RequestsDependency {
  Future<Map?> fetchMovies(MoviesFilter filter, int page);
  Future<Map?> fetchMovieTrailer(int page);
}

@injectable
class Requests implements RequestsDependency {
  @override
  Future<Map?> fetchMovies(MoviesFilter filter, int page) async {
    try {
      final result = await networkRepo.get(url: filter.endpoint, queryParams: {
        'page': page.toString(),
      });
      return result.data;
    } catch (e, b) {
      print('e $e b $b');
      return null;
    }
  }

  @override
  Future<Map?> fetchMovieTrailer(int id) async {
    try {
      final result = await networkRepo.get(
        url: '${Endpoints.movie}$id/videos',
      );
      return result.data;
    } catch (e, b) {
      print('e $e b $b');
      return null;
    }
  }
}
