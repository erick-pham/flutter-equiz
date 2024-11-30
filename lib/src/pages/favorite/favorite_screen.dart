import 'package:equiz/src/core/widgets/bottom_navigator.dart';
import 'package:equiz/src/utils/routing.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        bottomNavigationBar: MyBottomNavigationBar(
          currentRouteName: RoutingUtils.favoriteRoute,
        ),
        body: Center(child: Text('FavoriteScreen')));
  }
}
