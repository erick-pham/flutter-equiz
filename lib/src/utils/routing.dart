import 'package:equiz/src/pages/auth/login_screen.dart';
import 'package:equiz/src/pages/favorite/favorite_screen.dart';
import 'package:equiz/src/pages/game/game_screen.dart';
import 'package:equiz/src/pages/home/home_screen.dart';
import 'package:equiz/src/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:equiz/src/settings/settings_controller.dart';
import 'package:equiz/src/settings/settings_view.dart';

class RoutingUtils {
  static const String loginRoute = '/login';
  static const String homeRoute = '/';
  static const String settingRoute = '/setting';
  static const String profileRoute = '/profile';
  static const String gameRoute = '/game';
  static const String favoriteRoute = '/favorite';

  static Route<dynamic> generateRoute(
      RouteSettings routeSettings, SettingsController settingsController) {
    if (settingsController.isLoggedIn != true) {
      return MaterialPageRoute(
          settings: const RouteSettings(name: loginRoute),
          builder: (_) => LoginScreen(settingsController));
    }

    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case RoutingUtils.loginRoute:
            return LoginScreen(settingsController);
          case RoutingUtils.homeRoute:
            return const SafeArea(child: HomeScreen());
          case RoutingUtils.favoriteRoute:
            return const FavoriteScreen();
          case RoutingUtils.profileRoute:
            return const ProfileScreen();
          case RoutingUtils.gameRoute:
            return const GameScreen();
          case RoutingUtils.settingRoute:
            return SettingsView(controller: settingsController);
          default:
            return const SafeArea(child: HomeScreen());
        }
      },
    );
  }
}
