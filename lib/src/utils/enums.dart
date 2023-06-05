import 'package:movies_app/src/network/endpoints.dart';

enum MoviesFilter {
  topRated(Endpoints.topRated, 'Top rated'),
  popular(Endpoints.popular, 'Popular'),
  upcoming(Endpoints.upcoming, 'Upcoming');

  const MoviesFilter(this.endpoint, this.text);
  final String endpoint;
  final String text;
}
