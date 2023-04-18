import 'package:flutter/material.dart';
import 'package:troop/service/common_service.dart';
import 'package:troop/service/splash_service.dart';
import 'package:troop/view/utils/constant_colors.dart';
import 'package:troop/view/utils/others_helper.dart';
import 'package:troop/view/utils/responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConstantColors cc = ConstantColors();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      screenSizeAndPlatform(context);
    });
    SplashService().loginOrGoHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          // color: ConstantColors().primaryColor,
          child: Image.asset('assets/images/splash2.jpg',fit: BoxFit.fill),
          decoration:  BoxDecoration(
            color:          cc.secondaryColor,

          ),
        ));
  }
}
