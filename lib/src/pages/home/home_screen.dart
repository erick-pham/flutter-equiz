import 'package:equiz/src/core/widgets/bottom_navigator.dart';
import 'package:equiz/src/utils/routing.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(child: Text('HomeScreen')),
        bottomNavigationBar:
            MyBottomNavigationBar(currentRouteName: RoutingUtils.homeRoute));
  }
}
