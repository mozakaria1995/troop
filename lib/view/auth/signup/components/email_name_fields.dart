import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:troop/view/utils/custom_input.dart';

import '../../../utils/common_helper.dart';

class EmailNameFields extends StatelessWidget {
  const EmailNameFields(
      {Key? key,
      this.fullNameController,
      this.userNameController,
      this.emailController})
      : super(key: key);

  final fullNameController;
  final userNameController;
  final emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Name ============>
        CommonHelper().labelCommon("Full name"),

        CustomInput(
          controller: fullNameController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
          hintText: "Enter your full name".tr(),
          icon: 'assets/icons/user.png',
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(
          height: 8,
        ),

        //User name ============>
        CommonHelper().labelCommon("Username"),

        CustomInput(
          controller: userNameController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
          hintText: "Enter your username".tr(),
          icon: 'assets/icons/user.png',
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(
          height: 8,
        ),

        //Email ============>
        CommonHelper().labelCommon("Email"),

        CustomInput(
          controller: emailController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email'.tr();
            }
            return null;
          },
          hintText: "Enter your email".tr(),
          icon: 'assets/icons/email-grey.png',
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
