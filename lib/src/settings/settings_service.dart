import 'package:equiz/src/shared_preferences/constants/preferences.dart';
import 'package:equiz/src/shared_preferences/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  final SharedPreferenceHelper _sharedPreference;

  SettingsService(
    this._sharedPreference,
  );

  /// Theme:------------------------------------------------------------
  // Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    if (_sharedPreference.themeMode == 'ThemeMode.dark') {
      return ThemeMode.dark;
    }

    if (_sharedPreference.themeMode == 'ThemeMode.light') {
      return ThemeMode.light;
    }

    return ThemeMode.system;
  }

  // Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    return _sharedPreference.setThemeMode(theme);
  }

  /// Login:---------------------------------------------------------------------
  bool get isLoggedIn {
    return _sharedPreference.isLoggedIn;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.saveIsLoggedIn(value);
  }
}
