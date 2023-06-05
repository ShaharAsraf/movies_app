import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kLastRequest = 'last_request';
const String kMovies = 'movies';
const String kThemeMode = 'theme_mode';

class PrefsUtils {
  const PrefsUtils._();

  static late SharedPreferences _sp;

  static Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await _sp.setString(key, value);
  }

  static Future<bool> setMap(String key, Map value) async {
    return await _sp.setString(key, json.encode(value));
  }

  static String? getString(String key) => _sp.getString(key);

  static String getStringOrDefault(String key, String defaultValue) =>
      _sp.getString(key) ?? defaultValue;

  static Map getMapOrEmpty(String key) {
    String? value = _sp.getString(key);
    if (value != null) {
      dynamic decodedValue = json.decode(value);
      if (decodedValue is Map) {
        return decodedValue;
      }
    }
    return {};
  }

  static Future<bool> remove(String key) async {
    return await _sp.remove(key);
  }

  static Future<bool> clear() async {
    return await _sp.clear();
  }
}

class Prefs {
  //----------------------getters----------------------
  static Map lastRequest(String url) =>
      PrefsUtils.getMapOrEmpty('$kLastRequest$url');
  static String get themeMode =>
      PrefsUtils.getStringOrDefault(kThemeMode, ThemeMode.dark.name);

  static List<Movie> get storedMovies {
    final a = json.decode(PrefsUtils.getString(kMovies) ?? '[]');
    if (a is List && a.isEmpty) {
      return <Movie>[];
    }
    if (a is List) {
      return a.map((e) => Movie.fromJson(e)).toList();
    }
    return <Movie>[];
  }

  //----------------------setters----------------------
  static Future<bool> storeLastRequest(String url, Map value) =>
      PrefsUtils.setMap('$kLastRequest$url', value);

  static Future<bool> setThemeMode(String value) =>
      PrefsUtils.setString(kThemeMode, value);

  static Future<bool> setMovies(List movies) {
    final List stored = {...storedMovies, ...movies}.toList();
    return PrefsUtils.setString(kMovies, json.encode(stored));
  }

  static Future<bool> addFavMovie(Movie movie) =>
      PrefsUtils.setString(kMovies, json.encode([...storedMovies, movie]));
}
