import 'package:flutter/material.dart';

import '../entity/card_entity.dart';

class CustomCard extends StatelessWidget {
  final bool isDisabled;
  final bool isDisabledOnTap;
  final Function onTap;
  final CardImage child;

  const CustomCard(
      {super.key,
      this.isDisabled = false,
      this.isDisabledOnTap = false,
      required this.onTap,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: isDisabled ? const Color.fromARGB(55, 55, 55, 55) : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: Color.fromARGB(70, 70, 70, 0),
            width: 2,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            splashColor:
                isDisabled ? Colors.transparent : Colors.white.withAlpha(30),
            onTap: !isDisabledOnTap && !isDisabled
                ? () {
                    onTap();
                  }
                : null, // Disable the tap

            child: ColorFiltered(
              colorFilter: isDisabled
                  ? const ColorFilter.mode(
                      Colors.grey, // Apply grey color when disabled
                      BlendMode.saturation,
                    )
                  : const ColorFilter.mode(
                      Colors.transparent, // No filter when enabled
                      BlendMode.dst,
                    ),
              child: child.isVisible
                  ? Image.asset(
                      child.imgPath,
                      fit: BoxFit.cover,
                    )
                  : null,
            )));
  }
}
