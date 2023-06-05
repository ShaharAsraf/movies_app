import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/blocs/movie_bloc/movie_bloc_provider.dart';
import 'package:movies_app/src/blocs/ui_bloc/ui_bloc_provider.dart';
import 'package:movies_app/src/style/colors.dart';
import 'package:movies_app/src/utils/consts.dart';
import 'package:movies_app/src/utils/enums.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: _renderAppBarContent(context),
    );
  }

  Widget _renderAppBarContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _renderFilter(context),
          _renderThemeButton(context),
        ],
      ),
    );
  }

  Widget _renderFilter(BuildContext context) {
    return ValueListenableBuilder<MoviesFilter>(
        valueListenable: MovieBlocProvider.of(context).filterNotifier,
        builder: (context, filter, child) {
          return DropdownButton<MoviesFilter>(
              value: filter,
              items: MoviesFilter.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.text),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  MovieBlocProvider.of(context).onFilterChange(value);
                }
              });
        });
  }

  Widget _renderThemeButton(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: UIBlocProvider.of(context).isDarkMode,
        builder: (context, isDark, child) {
          return Row(
            children: [
              const Icon(CupertinoIcons.sun_max, color: dayColor),
              Switch(
                value: isDark,
                onChanged: (value) {
                  UIBlocProvider.of(context).onModeChange(value);
                },
                activeTrackColor: scaffoldBackground,
                activeColor: primaryColor,
              ),
              const Icon(CupertinoIcons.moon_fill, color: nightColor),
            ],
          );
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}

class MovieAppBar extends StatelessWidget with PreferredSizeWidget {
  final String movieTitle;
  const MovieAppBar({required this.movieTitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      iconTheme: Theme.of(context).iconTheme,
      title: Text(movieTitle, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
