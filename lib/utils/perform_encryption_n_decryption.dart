import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../app_state/aes_encryptor_state.dart';
import 'aes_encrypt_n_decrypt.dart';

performEncryptionNDecryptionProcess(BuildContext context) async {
  /*
    This function would handle all encryption actions
     */
  if (context.read<AesEncryptorState>().passwordController.text.isEmpty) {
    Fluttertoast.showToast(msg: 'Please input password');
    return;
  }
  context.read<AesEncryptorState>().removeFocus();
  //Remove focus from the textfields
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
          password: context.read<AesEncryptorState>().passwordController.text,
          content: context
              .read<AesEncryptorState>()
              .textToBeEncryptedOrDecryptedController
              .text,
        )).then((value) {
      context.read<AesEncryptorState>().updateTextDecryptedOrEncrypted(value);

      Navigator.pop(context);
    }, onError: (error) {
      Fluttertoast.showToast(msg: 'An error occurred');
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
            filePath: context.read<AesEncryptorState>().selectedFilePath
            as String,
            password: context
                .read<AesEncryptorState>()
                .passwordController
                .text))
        .then((value) {
      context.read<AesEncryptorState>().updateEncryptedFilePath(value.path);
      Navigator.of(context).pop();
    }, onError: (error) {
      Fluttertoast.showToast(msg: 'An error occurred');
      Navigator.of(context).pop();
    });
  } else if (context.read<AesEncryptorState>().selectedOption ==
      Options.decryptFile) {
    if (context.read<AesEncryptorState>().selectedFilePath == null) {
      Fluttertoast.showToast(msg: 'Please select file first');
      Navigator.of(context).pop();
      return;
    }
    await compute(
        decryptFile,
        FileProperties(
            filePath: context.read<AesEncryptorState>().selectedFilePath
            as String,
            password: context
                .read<AesEncryptorState>()
                .passwordController
                .text))
        .then((value) {
      context.read<AesEncryptorState>().updateDecryptedFilePath(value.path);
      Navigator.of(context).pop();
    }, onError: (error) {
      if (error.toString().contains('414553')) {
        Fluttertoast.showToast(msg: 'File is not an encrypted File');
      }

      Fluttertoast.showToast(msg: 'An error occurred');
      Navigator.of(context).pop();
    });
  } else if (context.read<AesEncryptorState>().selectedOption ==
      Options.decryptString) {
    await compute(
        decryptString,
        StringProperties(
            password:
            context.read<AesEncryptorState>().passwordController.text,
            content: context
                .read<AesEncryptorState>()
                .textToBeEncryptedOrDecryptedController
                .text))
        .then((value) {
      context.read<AesEncryptorState>().updateTextDecryptedOrEncrypted(value);

      Navigator.pop(context);
    }, onError: (error) {
      Fluttertoast.showToast(msg: 'An error occurred');
      Navigator.of(context).pop();
    });
  } else {
    Fluttertoast.showToast(msg: 'Error!');
  }
}