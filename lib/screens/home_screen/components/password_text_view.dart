import 'package:aes_encryptor_app/app_state/aes_encryptor_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';

class PasswordTextView extends StatefulWidget {
  const PasswordTextView({Key? key}) : super(key: key);

  @override
  State<PasswordTextView> createState() => _PasswordTextViewState();
}

class _PasswordTextViewState extends State<PasswordTextView> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscuringCharacter: '*',
      obscureText: showPassword,
      cursorColor: lightModeTextColor,
      // autofocus: true,
      controller: context.read<AesEncryptorState>().passwordController,
      style: Theme.of(context)
          .textTheme
          .headline3
          ?.copyWith(fontSize: 16, color: lightModeTextColor),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            showPassword ? Icons.visibility_off : Icons.visibility,
            color: lightModeTextColor,
          ),
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: const Icon(
          Icons.key,
          color: lightModeTextColor,
        ),
        hintText: 'Enter Password',
        contentPadding: EdgeInsets.only(left: 30, bottom: 9),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSubmitted: (text) {},
      onChanged: (text) {},
    );
  }
}
