import 'package:aes_crypt/aes_crypt.dart';

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
  final String appDir; //This is the application private storage

  StringProperties(
      {required this.password, required this.content, required this.appDir});
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
    return Future.error('An error occurred');
  }

  return File(fileDestinationPath);
}

Future encryptString(StringProperties stringProperties) async {
  /*
  This function would be in charge of encrypting the string
   */

  AesCrypt crypt = AesCrypt(stringProperties.password);
  crypt.setOverwriteMode(
      AesCryptOwMode.on); // If same file exists, overwrite the file
  String destFilePath = p.join(stringProperties.appDir, 'encryptedFile.txt');

  String encryptedFilePath;

  try {
    encryptedFilePath =
        crypt.encryptTextToFileSync(stringProperties.content, destFilePath);
  } catch (e) {
    return Future.error('An error occurred');
  }

  String content = File(encryptedFilePath).readAsStringSync();
  File(encryptedFilePath).deleteSync(); //Delete the text file

  return content;
}

Future decryptString(StringProperties stringProperties) async {
  /*
  The sole aim of this function is to decrypt a string file
   */
  AesCrypt crypt = AesCrypt(stringProperties.password);
  crypt.setOverwriteMode(
      AesCryptOwMode.on); // If same file exists, overwrite the file
  String encryptedFilePath =
      p.join(stringProperties.appDir, 'encryptedFile.txt');

  await File(encryptedFilePath)
      .writeAsString(stringProperties.content); //Write the content into a file

  String decryptedContent;
  try {
    decryptedContent = crypt.decryptTextFromFileSync(encryptedFilePath);
  } catch (e) {
    return Future.error('An error occurred');
  }

  File(encryptedFilePath).deleteSync(); //Delete the text file

  return decryptedContent;
}

getFileDestinationForDecrypt(String filePath) {
  String fileExt;

  fileExt = p.extension(filePath);
  if (fileExt == 'aes') {
    return p.withoutExtension(filePath);
  } else {
    return '$filePath.decrypted';
  }
}
