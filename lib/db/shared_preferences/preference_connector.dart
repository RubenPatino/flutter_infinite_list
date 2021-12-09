import 'dart:convert';

import 'package:aflore_flutter/db/shared_preferences/preferences_constants.dart';
import 'package:aflore_flutter/models/network/model_movie_popular.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesConnector {
  Future<SharedPreferences> _getSharedPreference() async {
    final shared = await SharedPreferences.getInstance();

    return shared;
  }

  Future<bool> savedModelMovie(ModelMoviePopular model) async {
    try {
      final modelLogin = json.encode(model.toJson());
      final _prefs = await _getSharedPreference();
      return _prefs.setString(Preferences.modelMovie, modelLogin);
    } on Exception catch (ex) {
      Logger().d(ex);
      return false;
    }
  }

  Future<ModelMoviePopular?> getModelMovie() async {
    try {
      final _prefs = await _getSharedPreference();

      final dataString = _prefs.getString(Preferences.modelMovie);

      if (dataString != null) {
        return ModelMoviePopular.fromJson(json.decode(dataString));
      } else {
        return null;
      }
    } on Exception catch (ex) {
      Logger().d(ex);
      return null;
    }
  }
}
