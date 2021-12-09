class PathDio {
  static const String endPoint = 'api.themoviedb.org';

  static Uri getUrl({required String path, Map<String, dynamic>? parameters}) {
    return Uri.https(endPoint, path, parameters);
  }
}
