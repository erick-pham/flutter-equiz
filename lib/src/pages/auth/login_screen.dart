import 'package:equiz/src/constants/assets.dart';
import 'package:equiz/src/core/widgets/app_icon_widget.dart';
import 'package:equiz/src/core/widgets/rounded_button_widget.dart';
import 'package:equiz/src/pages/auth/repository/user_repository_impl.dart';
import 'package:equiz/src/settings/settings_controller.dart';
import 'package:equiz/src/utils/routing.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final UserRepositoryImpl userRepositoryImpl;
  final SettingsController settingsController;

  LoginScreen(this.settingsController, {super.key})
      : userRepositoryImpl = UserRepositoryImpl(settingsController);

  @override
  Widget build(BuildContext context) {
    if (settingsController.isLoggedIn) {
      // Navigate to home if logged in
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(
          RoutingUtils.homeRoute,
        );
      });
    }
    return Scaffold(
      body: _buildBody(context),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        MediaQuery.of(context).orientation == Orientation.landscape
            ? Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _buildLeftSide(),
                  ),
                  Expanded(
                    flex: 1,
                    child: _buildRightSide(),
                  ),
                ],
              )
            : Center(child: _buildRightSide()),
      ],
    );
  }

  Widget _buildLeftSide() {
    return SizedBox.expand(
      child: Image.asset(
        Assets.carBackground,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const AppIconWidget(image: 'assets/icons/ic_app_icon.png'),
            const SizedBox(height: 24.0),
            _buildSignInButton()
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return RoundedButtonWidget(
      buttonText: 'Sign in with Google',
      buttonColor: Colors.red,
      textColor: Colors.white,
      icon: const Icon(
        Icons.golf_course,
        color: Colors.white,
      ),
      onPressed: () async {
        await userRepositoryImpl.signInwWithGoogle();
      },
      size: ButtonSize.large,
    );
  }
}
