import 'package:aes_encryptor_app/utils/delete_files_created.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_state/aes_encryptor_state.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/get_button_colors.dart';

class OptionsWidget extends StatelessWidget {
  final Options option;

  const OptionsWidget({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AesEncryptorState>(builder: (context, state, child) {
      return SizedBox(
        width: 146,
        height: 85,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //
        //   //If the option is equal to the selected option, then the option widget was chosen
        //   color: option == state.selectedOption
        //       ? getButtonSelectedColor(context)
        //       : getButtonColor(context),
        // ),
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(
                option == state.selectedOption
                    ? getButtonSelectedColor(context)
                    : getButtonColor(context),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
          onPressed: () async {
            await deleteFilesCreated(context);
            state.updateSelectedOption(option);
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  getFirstString(option),
                  style: (option == state.selectedOption)
                      ? getTextSelectedStyle(context)
                      : Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(fontSize: 17),
                ),
                Text(
                  getSecondString(option),
                  style: (option == state.selectedOption)
                      ? getTextSelectedStyle(context)
                      : Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(fontSize: 17),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  String getFirstString(Options option) {
    //This function would be used to get the firstString that is displayed
    //In the options widget, depending on the particular option.

    if (option == Options.decryptFile || option == Options.decryptString) {
      return 'Decrypt';
    } else {
      //This is an encryption option then

      return 'Encrypt';
    }
  }

  String getSecondString(Options option) {
    //This function would be used to get the second that is displayed
    //In the options widget, depending on the particular option.

    if (option == Options.decryptFile || option == Options.encryptFile) {
      return 'file';
    } else {
      //This is an file option then

      return 'string';
    }
  }

// TextStyle getTextColorStyle(BuildContext context) {
//   //This would give the text depending on the mode of the app. Dark or light
//
//   bool darkMode =
//       MediaQuery.of(context).platformBrightness == Brightness.dark;
//
//   if (darkMode) {
//     return Theme.of(context).textTheme.headline2!;
//   } else {
//     return Theme.of(context).textTheme.he;
//   }
// }

}
