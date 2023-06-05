import 'package:movies_app/src/network/network_repository.dart';
import 'package:movies_app/src/utils/enums.dart';

class Requests {
  // Future<void> authenticate() async {
  //   try {
  //     final result = await networkRepo.get(url: Endpoints.auth);
  //     print('a');
  //   } catch (e, b) {
  //     print('e $e b $b');
  //   }
  // }

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
}
