import 'dart:async';

import 'package:equiz/src/pages/auth/domain/user_repository.dart';
import 'package:equiz/src/pages/auth/entity/user_entity.dart';
import 'package:equiz/src/settings/settings_controller.dart';

class UserRepositoryImpl extends UserRepository {
  final SettingsController settingsController;

  // constructor
  UserRepositoryImpl(this.settingsController);

  // Login:---------------------------------------------------------------------
  @override
  Future<User?> signInwWithGoogle() async {
    await settingsController.saveIsLoggedIn(true);
    return User();
  }

  // @override
  // Future<void> saveIsLoggedIn(bool value) =>
  //     _settingsController.saveIsLoggedIn(value);
}
