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
        
            await deleteFilesCreated(context); // Delete all files that might have been created when encrypting or decrypting
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
                          ?.copyWith(fontSize: 17, color: lightModeTextColor),
                ),
                Text(
                  getSecondString(option),
                  style: (option == state.selectedOption)
                      ? getTextSelectedStyle(context)
                      : Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(fontSize: 17, color: lightModeTextColor),
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

    //Like for encrypt, The first string would be Encrypt, same goes for derypt.
    //Trying to make things simple as possible

    if (option == Options.decryptFile || option == Options.decryptString) {
      return 'Decrypt';
    } else {
      //This is an encryption option then

      return 'Encrypt';
    }
  }

  String getSecondString(Options option) {
    //This function would be used to get the second String that is displayed
    //In the options widget, depending on the particular option.

    if (option == Options.decryptFile || option == Options.encryptFile) {
      return 'file';
    } else {
      //This is an string option then

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
