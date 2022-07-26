import 'package:aes_encryptor_app/app_state/aes_encryptor_state.dart';
import 'package:aes_encryptor_app/screens/home_screen/components/decrypt_file_widget.dart';
import 'package:aes_encryptor_app/screens/home_screen/components/decrypt_string_widget.dart';
import 'package:aes_encryptor_app/screens/home_screen/components/encrypt_file_widget.dart';
import 'package:aes_encryptor_app/screens/home_screen/components/encrypt_string_widget.dart';
import 'package:aes_encryptor_app/screens/home_screen/components/options_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: lightModeStatusBarOverlay));
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Aes Encryptor',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 41, right: 41, top: 43),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  OptionsWidget(option: Options.encryptString),
                  OptionsWidget(option: Options.encryptFile),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  OptionsWidget(option: Options.decryptString),
                  OptionsWidget(option: Options.decryptFile),
                ],
              ),
              Consumer<AesEncryptorState>(builder: (context, state, child) {
                return SingleChildScrollView(
                    child: getOptionWidgetToShow(context));
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget getOptionWidgetToShow(BuildContext context) {
    // if(context.read<AesEncryptorState>().selectedOption =)
    //

    switch (context.read<AesEncryptorState>().selectedOption) {
      case null:
        return Column(
          children: [
            const SizedBox(
              height: 83,
            ),
            Text(
              'Please select an option',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        );
      case Options.decryptString:
        return DecryptStringWidget();
      case Options.decryptFile:
        return DecryptFileWidget();
      case Options.encryptString:
        return EncryptStringWidget();
      case Options.encryptFile:
        return EncryptFileWidget();
      default:
        return Container(
          color: Colors.white60,
          height: 20,
          width: 50,
          child: Text('AN error occurred'),
        );
    }
  }
}
