import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:troop/view/auth/login/login.dart';
import 'package:troop/view/utils/constant_colors.dart';

class SignupHelper {
  ConstantColors cc = ConstantColors();
  haveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: 'Have an account?  '.tr(),
            style: const TextStyle(color: Color(0xff646464), fontSize: 14),
            children: <TextSpan>[
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                  text: 'Sign in',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: cc.primaryColor,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  //
  phoneFieldDecoration() {
    return InputDecoration(
        labelText: 'Phone Number'.tr(),
        // hintTextDirection: TextDirection.rtl,

        labelStyle: TextStyle(color: cc.greyFour, fontSize: 14),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().greyFive),
            borderRadius: BorderRadius.circular(9)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().primaryColor)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().warningColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().primaryColor)),
        hintText: 'Enter phone number',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 18));
  }
}
