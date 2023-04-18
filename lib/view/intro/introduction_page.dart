import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:troop/view/auth/login/login.dart';
import 'package:troop/view/intro/intro_helper.dart';
import 'package:troop/view/utils/common_helper.dart';
import 'package:troop/view/utils/constant_colors.dart';
import 'package:troop/view/utils/responsive.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  ConstantColors cc = ConstantColors();
  int _selectedSlide = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // var screenWidth = MediaQuery.of(context).size.width;
    // var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,

        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width:double.infinity,
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _selectedSlide = value;
                  });
                },
                itemCount: 2,
                itemBuilder: (context, i) {
                  return Container(
                    width: double.infinity,
                    height:
                    MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(IntroHelper().getImage(i)),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
          ),





          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                              (Route<dynamic> route) => false);
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: cc.primaryColor, width: 1.5),
                          borderRadius: BorderRadius.circular(7)),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: cc.secondaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (_selectedSlide == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      } else {
                        _pageController.animateToPage(_selectedSlide + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding:  EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                              color: cc.secondaryColor,
                              borderRadius: BorderRadius.circular(8)),
                          child:  Text(
                            'Continue',
                            style: TextStyle(
                                color: cc.primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ).tr()),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
