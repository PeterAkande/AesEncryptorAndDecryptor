import 'package:aes_encryptor_app/utils/delete_files_created.dart';
import 'package:flutter/cupertino.dart';

enum Options { encryptFile, encryptString, decryptFile, decryptString }

class AesEncryptorState extends ChangeNotifier {
  Options? selectedOption; //This would denote the currently selected option

  String? selectedFilePath;
  String? encryptedFilePath;
  String? decryptedFilePath;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController textToBeEncryptedOrDecryptedController =
      TextEditingController();
  final TextEditingController textDecryptedOrEncryptedController =
      TextEditingController();
  final FocusNode textToBeEncryptedOrDecryptedFocusNode = FocusNode();

  updateSelectedOption(Options option) {

    selectedFilePath = null;
    encryptedFilePath = null;
    decryptedFilePath=null;
    passwordController.text = '';
    textToBeEncryptedOrDecryptedController.text = '';
    textDecryptedOrEncryptedController.text = '';
    selectedOption = option;

    notifyListeners();
  }

  updateSelectedFilePath(String? path) {
    selectedFilePath = path;
    encryptedFilePath = null;
    decryptedFilePath = null;
    notifyListeners();
  }

  updateEncryptedFilePath(String? path) {
    encryptedFilePath = path;
    notifyListeners();
  }

  updateDecryptedFilePath(String? path) {
    decryptedFilePath = path;
    notifyListeners();
  }

  updateTextDecryptedOrEncrypted(String value) {
    textDecryptedOrEncryptedController.text = value;
    notifyListeners();
  }

  removeFocus() {
    textToBeEncryptedOrDecryptedFocusNode.unfocus();
  }
}
