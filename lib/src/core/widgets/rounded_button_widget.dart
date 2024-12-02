import 'package:flutter/material.dart';

enum ButtonSize {
  small(40),
  medium(60),
  large(70);

  const ButtonSize(
    this.height,
  );

  final double height;
}

class RoundedButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color textColor;
  final Color? borderColor;
  final String? imagePath;
  final double buttonTextSize;
  final double? height;
  final VoidCallback? onPressed;
  final ShapeBorder shape;
  final Icon? icon;
  final ButtonSize size;

  const RoundedButtonWidget(
      {super.key,
      this.buttonText,
      this.buttonColor,
      this.textColor = Colors.white,
      this.onPressed,
      this.imagePath,
      this.borderColor,
      this.shape = const StadiumBorder(),
      this.buttonTextSize = 14.0,
      this.height,
      this.size = ButtonSize.small,
      this.icon});

  double getButtonHeight() {
    if (height != null) {
      return height as double;
    }

    return size.height;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return MaterialButton(
      height: getButtonHeight(),
      key: key,
      color: buttonColor ?? colorScheme.primary,
      shape: borderColor != null
          ? StadiumBorder(side: BorderSide(color: borderColor!))
          : shape,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          imagePath != null
              ? Image.asset(
                  imagePath!,
                  height: 15.0,
                )
              : const SizedBox.shrink(),
          const SizedBox(width: 5.0),
          icon ?? const SizedBox.shrink(),
          const SizedBox(width: 5.0),
          Text(
            buttonText!,
            overflow: TextOverflow.clip,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.normal,
              fontSize: buttonTextSize,
            ),
          ),
        ],
      ),
    );
  }
}
