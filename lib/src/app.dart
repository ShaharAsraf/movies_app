import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/blocs/movie_bloc/movie_bloc_provider.dart';
import 'package:movies_app/src/blocs/ui_bloc/ui_bloc.dart';
import 'package:movies_app/src/blocs/ui_bloc/ui_bloc_provider.dart';
import 'package:movies_app/src/models/movie/movie.dart';
import 'package:movies_app/src/screens/main_screen.dart';
import 'package:movies_app/src/screens/movie_screen.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UIBlocProvider(
      child: MovieBlocProvider(
        child: ValueListenableBuilder<ThemeData?>(
            valueListenable: uiBloc.theme,
            builder: (BuildContext context, ThemeData? theme, Widget? child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: theme,
                title: 'Movies App',
                builder: (ctx, widget) {
                  return MediaQuery(
                    data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1),
                    child: widget!,
                  );
                },
                onGenerateRoute: appRoutes,
                navigatorObservers: [routeObserver],
              );
            }),
      ),
    );
  }

  Route appRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/movie_screen':
        return CupertinoPageRoute(
          builder: (BuildContext context) {
            final movie = settings.arguments as Movie?;
            return MovieScreen(movie: movie);
          },
        );
      case '/':
      default:
        return CupertinoPageRoute(
          builder: (BuildContext context) {
            return const MainScreen();
          },
        );
    }
  }
}
