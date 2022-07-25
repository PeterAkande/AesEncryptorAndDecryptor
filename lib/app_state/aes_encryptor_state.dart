import 'package:flutter/cupertino.dart';

enum Options { encryptFile, encryptString, decryptFile, decryptString }

class AesEncryptorState extends ChangeNotifier {
  Options? selectedOption; //This would denote the currently selected option
  bool decryptFileCompleted = false;
  bool encryptFileCompleted = false;
  bool decryptStringCompleted = false;
  bool encryptStringCompleted = false;

  String? selectedFilePath;
  String? encryptedFilePath;
  String? decryptedFilePath;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController textToBeEncryptedOrDecryptedController =
      TextEditingController();

  updateSelectedOption(Options option) {
    selectedFilePath = null;
    encryptedFilePath = null;
    selectedOption = option;
    notifyListeners();
  }

  updateSelectedFilePath(String? path) {
    selectedFilePath = path;
    encryptedFilePath = null;
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
}
