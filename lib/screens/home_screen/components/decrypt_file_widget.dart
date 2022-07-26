import 'package:aes_encryptor_app/screens/home_screen/components/password_text_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

import '../../../app_state/aes_encryptor_state.dart';
import '../../../utils/get_button_colors.dart';
import 'encrypt_button_.dart';
import 'options_for_encrypted_or_decrypted_file.dart';

class DecryptFileWidget extends StatelessWidget {
  const DecryptFileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const PasswordTextView(),
        const SizedBox(
          height: 58,
        ),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor:
                    MaterialStateProperty.all(getButtonColor(context)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
            onPressed: () async {
              /*
              Now its to pick files that would be encrypted
               */
              final result = await FilePicker.platform.pickFiles(
                allowMultiple: false,
              );
              if (result == null) return;

              context.read<AesEncryptorState>().updateSelectedFilePath(result
                      .paths[0]
                  as String); //Update the selectedFilePath in the provider in the state class
            },
            child: (context.read<AesEncryptorState>().selectedFilePath == null)
                ? Text(
                    'Select File',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.white),
                  )
                : Row(
                    children: [
                      SizedBox(
                        height: 35,
                        child: Image.asset('assets/doc.png'),
                      ),
                      Text(
                          p.basename(context
                              .read<AesEncryptorState>()
                              .selectedFilePath as String),
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(fontSize: 20))
                    ],
                  ),
          ),
        ),
        getWidgetToBeShownDependingOnDecryptStatus(context)
      ],
    );
  }

  //This function would give the widgets that would be shown depending on if a file has been selected
  //Or encrypted
  Widget getWidgetToBeShownDependingOnDecryptStatus(BuildContext context) {
    if (context.read<AesEncryptorState>().decryptedFilePath == null) {
      //what would be shown if the file is yet to be encrypted
      return Column(
        children: const [
          SizedBox(
            height: 131,
          ),
          EncryptButton()
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 60,
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      MaterialStateProperty.all(getButtonColor(context)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: () {},
              child: Row(
                children: [
                  SizedBox(
                    height: 35,
                    child: Image.asset('assets/doc.png'),
                  ),
                  Text(
                      p.basename(context
                          .read<AesEncryptorState>()
                          .decryptedFilePath as String),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(fontSize: 20))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              OptionsForEncryptedOrDecryptedFile(actionText: 'Open'),
              OptionsForEncryptedOrDecryptedFile(actionText: 'Share')
            ],
          )
        ],
      );
    }
  }
}