import 'package:equiz/src/core/widgets/bottom_navigator.dart';
import 'package:equiz/src/utils/routing.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        bottomNavigationBar: MyBottomNavigationBar(
          currentRouteName: RoutingUtils.profileRoute,
        ),
        body: Center(child: Text('ProfileScreen')));
  }
}
