import 'package:flutter/material.dart';

import '../../../utils/get_button_colors.dart';


class OptionsForEncryptedOrDecryptedFile extends StatelessWidget {
  final String actionText;
  final Function()? actionCallback;

  const OptionsForEncryptedOrDecryptedFile({Key? key, required this.actionText, required this.actionCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 118,
      height: 66,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor:
            MaterialStateProperty.all(getButtonSelectedColor(context)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        onPressed: actionCallback,
        child: Text(
          actionText,
          style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}