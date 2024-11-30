import 'dart:async';

import 'package:equiz/src/pages/auth/entity/user_entity.dart';

abstract class UserRepository {
  Future<User?> signInwWithGoogle();

  // Future<void> saveIsLoggedIn(bool value);
}
