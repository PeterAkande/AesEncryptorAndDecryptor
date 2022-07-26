import 'package:aes_encryptor_app/app_state/aes_encryptor_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/get_button_colors.dart';
import '../../../utils/perform_encryption_n_decryption.dart';

class EncryptButton extends StatelessWidget {
  const EncryptButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 66,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor:
                MaterialStateProperty.all(getButtonSelectedColor(context)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        onPressed: () async {
          await performEncryptionNDecryptionProcess(context);
        },
        child: Text(
          getTextEncryptOrDecrypt(context),
          style: getTextSelectedStyle(context)?.copyWith(fontSize: 22),
        ),
      ),
    );
  }

  String getTextEncryptOrDecrypt(BuildContext context) {
    Options? option = context.read<AesEncryptorState>().selectedOption;

    if (option == Options.encryptFile || option == Options.encryptString) {
      return 'Encrypt';
    } else {
      return 'Decrypt';
    }
  }


}
