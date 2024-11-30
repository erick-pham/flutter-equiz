import 'package:equiz/src/pages/auth/login_screen.dart';
import 'package:equiz/src/pages/favorite/favorite_screen.dart';
import 'package:equiz/src/pages/home/home_screen.dart';
import 'package:equiz/src/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:equiz/src/settings/settings_controller.dart';
import 'package:equiz/src/settings/settings_view.dart';

class RoutingUtils {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String settingRoute = '/setting';
  static const String profileRoute = '/profile';
  static const String favoriteRoute = '/favorite';

  static Route<dynamic> generateRoute(
      RouteSettings routeSettings, SettingsController settingsController) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        if (settingsController.isLoggedIn != true) {
          return LoginScreen(settingsController);
        }
        switch (routeSettings.name) {
          case RoutingUtils.settingRoute:
            return SettingsView(controller: settingsController);
          // case SampleItemDetailsView.routeName:
          //   return const SampleItemDetailsView();
          // case SampleItemListView.routeName:
          case RoutingUtils.favoriteRoute:
            return const FavoriteScreen();
          case RoutingUtils.profileRoute:
            return const ProfileScreen();
          default:
            return const SafeArea(child: HomeScreen());
        }
      },
    );
  }
}
