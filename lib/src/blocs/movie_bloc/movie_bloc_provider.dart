import 'package:flutter/material.dart';
import 'package:movies_app/src/blocs/movie_bloc/movie_bloc.dart';

class MovieBlocProvider extends InheritedWidget {
  final MovieBloc bloc;

  MovieBlocProvider({Key? key, required Widget child})
      : bloc = MovieBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(oldWidget) => true;

  static MovieBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MovieBlocProvider>()!
        .bloc;
  }
}
