import 'package:container_locations/core/values/colors.dart' as colors;
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final CustomButton? customButton;

  const ButtonWidget({Key? key, required this.customButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final action =
        customButton?.disabled == true ? null : customButton?.onPress;

    Color textColor = colors.lightColor;
    Color backgroundColor = customButton?.disabled ?? false
        ? colors.greenTransparent
        : colors.green;

    //TODO box shadow
    return ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            fixedSize: const Size(304, 43),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            primary: backgroundColor,
            shadowColor: colors.shadowColorGreen,
            elevation: 4),
        child: Text(
          (customButton?.label ?? 'Label').toUpperCase(),
          style: Theme.of(context).textTheme.button,
        ));
  }
}

class CustomButton {
  final String label;
  final void Function() onPress;
  final bool? disabled;

  CustomButton({required this.label, required this.onPress, this.disabled});
}
