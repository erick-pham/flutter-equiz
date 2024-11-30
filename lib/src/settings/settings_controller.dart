import 'package:flutter/material.dart';

import 'settings_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(
    this._settingsService,
  );

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService;

  late bool _isLoggedIn;
  late ThemeMode _themeMode;
  late String _currentLanguage;
  late int _selectedPage;

  ThemeMode get themeMode => _themeMode;
  bool get isLoggedIn => _isLoggedIn;
  String get currentLanguage => _currentLanguage;
  int get selectedPage => _selectedPage;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _selectedPage = 0;
    _isLoggedIn = false;

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> saveIsLoggedIn(bool value) async {
    if (_isLoggedIn != value) {
      _isLoggedIn = value;
      notifyListeners();
      // return _settingsService.saveIsLoggedIn(value);
    }
    return value;
  }

  // Bottom Navigator :---------------------------------------------------------------------
  void updateSelectedPage(int selectedPage) async {
    _selectedPage = selectedPage;
    notifyListeners();
  }
}
