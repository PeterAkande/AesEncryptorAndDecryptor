import 'dart:convert';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:encryptor/encryptor.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:io';
import 'package:path/path.dart' as p;

class FileProperties {
  final String filePath;
  final String password;

  // final fileName;

  FileProperties({required this.filePath, required this.password});
}

class StringProperties {
  final String content;
  final String password;

  StringProperties(
      {required this.password, required this.content});
}

Future encryptFile(FileProperties fileProperties) async {
  /*
  This function would be in sole charge of encrypting the file.
  It would be done in an isolate
   */
  AesCrypt crypt = AesCrypt(fileProperties.password);
  crypt.setOverwriteMode(
      AesCryptOwMode.on); // If same file exists, overwrite the file

  String fileDestinationPath =
      '${fileProperties.filePath}.aes'; //Concatenate the .aes extension to the file
  try {
    await crypt.encryptFile(fileProperties.filePath, fileDestinationPath);
  } catch (e) {
    return Future.error('An error occurred');
  }

  return File(fileDestinationPath);
}

Future decryptFile(FileProperties fileProperties) async {
  /*
  This function would be in sole charge of decrypting the file.
  It would be done in an isolate
   */


  AesCrypt crypt = AesCrypt(fileProperties.password);
  crypt.setOverwriteMode(
      AesCryptOwMode.on); // If same file exists, overwrite the file

  String fileDestinationPath = getFileDestinationForDecrypt(fileProperties
      .filePath); //get the file destination for the decrypted file

  try {
    await crypt.decryptFile(fileProperties.filePath, fileDestinationPath);
  } catch (e) {
    return Future.error('An error occurred $e');
  }

  return File(fileDestinationPath);
}

Future encryptString(StringProperties stringProperties) async {
  /*
  This function would be in charge of encrypting the string
   */


  try {
    var encrypted =
        Encryptor.encrypt(stringProperties.password, stringProperties.content);
    return encrypted;
  } catch (e) {
    return Future.error(e);
  }

}

Future decryptString(StringProperties stringProperties) async {
  /*
  The sole aim of this function is to decrypt a string file
   */

  try {
    var decrypted =
        Encryptor.decrypt(stringProperties.password, stringProperties.content);
    return decrypted;
  } catch (e) {
    return Future.error(e);
  }

}

getFileDestinationForDecrypt(String filePath) {
  String fileExt;

  fileExt = p.extension(filePath);
  if (fileExt == '.aes') {
    return p.withoutExtension(filePath);
  } else {
    return '$filePath.decrypted';
  }
}
