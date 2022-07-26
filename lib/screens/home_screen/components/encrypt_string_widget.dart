import 'package:aes_encryptor_app/app_state/aes_encryptor_state.dart';
import 'package:aes_encryptor_app/constants/app_colors.dart';
import 'package:aes_encryptor_app/screens/home_screen/components/encrypt_button_.dart';
import 'package:aes_encryptor_app/screens/home_screen/components/password_text_view.dart';
import 'package:aes_encryptor_app/utils/size_config.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../utils/get_button_colors.dart';

class EncryptStringWidget extends StatefulWidget {
  const EncryptStringWidget({Key? key}) : super(key: key);

  @override
  State<EncryptStringWidget> createState() => _EncryptStringWidgetState();
}

class _EncryptStringWidgetState extends State<EncryptStringWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        PasswordTextView(),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 126,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  maxLines: null,
                  maxLength: null,
                  // autofocus: true,
                  focusNode: context
                      .read<AesEncryptorState>().textToBeEncryptedOrDecryptedFocusNode,
                  controller: context
                      .read<AesEncryptorState>()
                      .textToBeEncryptedOrDecryptedController,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontSize: 16, color: lightModeTextColor),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter Text to be encrypted',
                    hintStyle:
                        TextStyle(color: lightModeTextColor.withOpacity(0.7)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (text) {},
                  onChanged: (text) {},
                ),
              )
            ],
          ),
        ),
        getWidgetThatIsShownWhenStringIsEncryptedOrDecrypted(context)
      ],
    );
  }

  Widget getWidgetThatIsShownWhenStringIsEncryptedOrDecrypted(
      BuildContext context) {
    if (context
        .read<AesEncryptorState>()
        .textDecryptedOrEncryptedController
        .text
        .isEmpty) {
      //if the
      return Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(160),
          ),
          EncryptButton(),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  height: getProportionateScreenHeight(200),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    maxLines: null,
                    enabled: false,
                    maxLength: null,
                    // autofocus: true,
                    controller: context
                        .read<AesEncryptorState>()
                        .textDecryptedOrEncryptedController,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(fontSize: 16, color: lightModeTextColor),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,

                      hintText: 'Enter Text to be encrypted',
                      // contentPadding: EdgeInsets.only(left: 30, bottom: 9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (text) {},
                    onChanged: (text) {},
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              SizedBox(
                // width: 30,
                // height: 70,
                child: IconButton(
                  // splashRadius: 2,
                  // iconSize: 60,
                  icon: SvgPicture.asset(
                    'assets/copy_icon.svg',
                    height: 25,
                    color: getButtonSelectedColor(context),
                  ),
                  onPressed: () {
                    FlutterClipboard.copy(context
                            .read<AesEncryptorState>()
                            .textDecryptedOrEncryptedController
                            .text)
                        .then((value) {
                      Fluttertoast.showToast(msg: 'Copied');
                    });
                  },
                ),
              )
            ],
          ),
        ],
      );
    }
  }
}
