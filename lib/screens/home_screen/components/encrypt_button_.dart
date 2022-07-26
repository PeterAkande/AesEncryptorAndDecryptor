import 'package:aes_encryptor_app/app_state/aes_encryptor_state.dart';
import 'package:aes_encryptor_app/utils/aeas_encrypt_n_decrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../utils/get_button_colors.dart';

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
          if (context
              .read<AesEncryptorState>()
              .passwordController
              .text
              .isEmpty) {
            Fluttertoast.showToast(msg: 'Please input password');
            return;
          }
          showDialog(
              context: context,
              builder: (context) => Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ));
          if (context.read<AesEncryptorState>().selectedOption ==
              Options.encryptString) {
            await compute(
                encryptString,
                StringProperties(
                  password:
                      context.read<AesEncryptorState>().passwordController.text,
                  content: context
                      .read<AesEncryptorState>()
                      .textToBeEncryptedOrDecryptedController
                      .text,
                )).then((value) {
              context
                  .read<AesEncryptorState>()
                  .updateTextDecryptedOrEncrypted(value);

              Navigator.pop(context);
            }, onError: (error) {
              Navigator.of(context).pop();
            });
          } else if (context.read<AesEncryptorState>().selectedOption ==
              Options.encryptFile) {
            if (context.read<AesEncryptorState>().selectedFilePath == null) {
              Fluttertoast.showToast(msg: 'Please select file first');
              Navigator.of(context).pop();
              return;
            }
            await compute(
                    encryptFile,
                    FileProperties(
                        filePath: context
                            .read<AesEncryptorState>()
                            .selectedFilePath as String,
                        password: context
                            .read<AesEncryptorState>()
                            .passwordController
                            .text))
                .then((value) {
              context
                  .read<AesEncryptorState>()
                  .updateEncryptedFilePath(value.path);
              Navigator.of(context).pop();

              print('done');
            }, onError: (error) {
              print('error occurred $error');
              Navigator.of(context).pop();
            });
          } else if (context.read<AesEncryptorState>().selectedOption ==
              Options.decryptFile) {
            if (context.read<AesEncryptorState>().selectedFilePath == null) {
              Fluttertoast.showToast(msg: 'Please select file first');
              Navigator.of(context).pop();
              return;
            }
            print(context.read<AesEncryptorState>().selectedFilePath);
            await compute(
                    decryptFile,
                    FileProperties(
                        filePath: context
                            .read<AesEncryptorState>()
                            .selectedFilePath as String,
                        password: context
                            .read<AesEncryptorState>()
                            .passwordController
                            .text))
                .then((value) {
              context
                  .read<AesEncryptorState>()
                  .updateDecryptedFilePath(value.path);
              Navigator.of(context).pop();
            }, onError: (error) {
              if (error.toString().contains('414553')) {
                Fluttertoast.showToast(msg: 'File is not an encrypted File');
              }

              print('error occurred $error');
              Navigator.of(context).pop();
            });
          } else if (context.read<AesEncryptorState>().selectedOption ==
              Options.decryptString) {
            await compute(
                    decryptString,
                    StringProperties(
                        password: context
                            .read<AesEncryptorState>()
                            .passwordController
                            .text,
                        content: context
                            .read<AesEncryptorState>()
                            .textToBeEncryptedOrDecryptedController
                            .text))
                .then((value) {
              context
                  .read<AesEncryptorState>()
                  .updateTextDecryptedOrEncrypted(value);

              Navigator.pop(context);
            }, onError: (error) {
              print('error occurred o $error');
              Navigator.of(context).pop();
            });
          } else {
            Fluttertoast.showToast(msg: 'Error!');
          }
        },
        child: Text(
          getTextEncryptOrDecrypt(context),
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(color: Colors.white),
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
