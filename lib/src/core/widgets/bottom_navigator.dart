import 'package:equiz/src/utils/routing.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

String numberToString(int number) {
  switch (number) {
    case 0:
      return RoutingUtils.homeRoute;
    case 1:
      return RoutingUtils.favoriteRoute;
    case 2:
      return RoutingUtils.profileRoute;
    case 3:
      return RoutingUtils.gameRoute;
    case 4:
      return RoutingUtils.settingRoute;
    default:
      throw ArgumentError('Invalid index');
  }
}

int stringToNumber(String string) {
  switch (string) {
    case RoutingUtils.homeRoute:
      return 0;
    case RoutingUtils.favoriteRoute:
      return 1;
    case RoutingUtils.profileRoute:
      return 2;
    case RoutingUtils.gameRoute:
      return 3;
    case RoutingUtils.settingRoute:
      return 4;
    default:
      throw ArgumentError('Invalid route name');
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final String currentRouteName;
  const MyBottomNavigationBar({super.key, required this.currentRouteName});

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: stringToNumber(currentRouteName),
      onTap: (int index) {
        Navigator.pushNamed(context, numberToString(index));
      },
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: const Icon(Icons.home),
          title: const Text("Home"),
          selectedColor: Colors.teal,
        ),

        /// Favorite
        SalomonBottomBarItem(
          icon: const Icon(Icons.favorite),
          title: const Text("Favorite"),
          selectedColor: Colors.teal,
        ),

        /// Profile
        SalomonBottomBarItem(
          icon: const Icon(Icons.person),
          title: const Text("Profile"),
          selectedColor: Colors.teal,
        ),

        /// Game
        SalomonBottomBarItem(
          icon: const Icon(Icons.games),
          title: const Text("Game"),
          selectedColor: Colors.teal,
        ),

        /// Setting
        SalomonBottomBarItem(
          icon: const Icon(Icons.settings),
          title: const Text("Setting"),
          selectedColor: Colors.teal,
        ),
      ],
    );
  }
}
