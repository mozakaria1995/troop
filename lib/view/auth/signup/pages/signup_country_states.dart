import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troop/service/country_states_service.dart';
import 'package:troop/service/auth_services/signup_service.dart';
import 'package:troop/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:troop/view/auth/signup/signup_helper.dart';
import 'package:troop/view/home/landing_page.dart';
import 'package:troop/view/utils/common_helper.dart';
import 'package:troop/view/utils/constant_colors.dart';
import 'package:troop/view/utils/others_helper.dart';

class SignupCountryStates extends StatefulWidget {
  const SignupCountryStates({
    Key? key,
    this.fullNameController,
    this.userNameController,
    this.emailController,
    this.passController,
  }) : super(key: key);

  final fullNameController;
  final userNameController;
  final emailController;
  final passController;

  @override
  _SignupCountryStatesState createState() => _SignupCountryStatesState();
}

class _SignupCountryStatesState extends State<SignupCountryStates> {
  @override
  void initState() {
    super.initState();
  }

  bool termsAgree = false;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const CountryStatesDropdowns(),
            //Agreement checkbox ===========>
            const SizedBox(
              height: 17,
            ),
            CheckboxListTile(
              checkColor: Colors.white,
              activeColor: ConstantColors().primaryColor,
              contentPadding: const EdgeInsets.all(0),
              title: Container(
                padding:  EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "I agree with the terms and conditions",
                  style: TextStyle(
                      color: ConstantColors().greyFour,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ).tr(),
              ),
              value: termsAgree,
              onChanged: (newValue) {
                setState(() {
                  termsAgree = !termsAgree;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            //Login button ==================>
            const SizedBox(
              height: 17,
            ),
            Consumer<SignupService>(
              builder: (context, provider, child) =>
                  CommonHelper().buttonOrange("Sign Up", () {
                if (termsAgree == false) {
                  OthersHelper().showToast(
                      'You must agree with the terms and conditions to register'.tr(),
                      Colors.black);
                } else {
                  if (provider.isloading == false) {
                    provider.signup(
                        widget.fullNameController.text.trim(),
                        widget.emailController.text.trim(),
                        widget.userNameController.text.trim(),
                        widget.passController.text.trim(),
                        context);
                  }
                }
              }, isloading: provider.isloading == false ? false : true),
            ),

            const SizedBox(
              height: 25,
            ),
            SignupHelper().haveAccount(context),

            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
