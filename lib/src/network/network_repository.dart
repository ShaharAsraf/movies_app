import 'package:dio/dio.dart';

const String _accessToken =
    " eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTExMjAzMTU0MmMxZmNiNzc3NTNlN2ZhNzQxNDA5YSIsInN1YiI6IjY0N2RkMzNmY2Y0YjhiMDBhODc4OTVhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.h2AVdr3FOZOY4RvdQ1KV2vofNTbVYYYvHfvMfVWxYn8";
const String _baseUrl = "https://api.themoviedb.org/3/";
const int _timeOut = 30;
const Map<String, String> _headers = {
  'accept': 'application/json',
  'Authorization': 'Bearer $_accessToken',
};

NetworkRepository networkRepo = NetworkRepository.instance;

class NetworkRepository {
  static NetworkRepository? _instance;
  final Dio dio = Dio();

  static NetworkRepository get instance {
    if (_instance == null) {
      _instance = NetworkRepository._();
      _instance!.init();
    }
    return _instance!;
  }

  NetworkRepository._() : super();

  void init() {
    dio.options = BaseOptions(
      baseUrl: _baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: _timeOut),
      connectTimeout: const Duration(seconds: _timeOut),
      headers: _headers,
    );
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    return await dio.get(url, queryParameters: queryParams);
  }
}
