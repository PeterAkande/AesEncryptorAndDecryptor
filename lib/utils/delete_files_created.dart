import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state/aes_encryptor_state.dart';

deleteFilesCreated(BuildContext context) async {
  /*
This function would have the sole aim of deleting all the files that were created during the c\
encryption and decryption process

 */

  String? selectedFilePath = context.read<AesEncryptorState>().selectedFilePath;
  String? encryptedFilePath =
      context.read<AesEncryptorState>().encryptedFilePath;
  String? decryptedFilePath =
      context.read<AesEncryptorState>().decryptedFilePath;

  if (selectedFilePath != null) {
    await File(selectedFilePath).delete();
  }
  if (encryptedFilePath != null) {
    await File(encryptedFilePath).delete();
  }
  if (decryptedFilePath != null) {
    await File(decryptedFilePath).delete();
  }
}
