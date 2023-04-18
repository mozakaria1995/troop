import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BookStepsService with ChangeNotifier {
  int currentStep = 1;

  int totalStep = 5;

  increaseCurrentStep(int increaseBy) {
    currentStep = currentStep + increaseBy;
    notifyListeners();
  }

  setStepsToDefault() {
    currentStep = 1;
  }

  // setCurrentStepOne() {
  //   currentStep = 1;
  //   Future.delayed(
  //       const Duration(
  //         milliseconds: 400,
  //       ), () {
  //     notifyListeners();
  //   });
  // }

  decreaseCurrentStep(int decreaseBy) {
    currentStep = currentStep - decreaseBy;
    notifyListeners();
  }

  List<StepsAndNext> stepsNameList = [
    StepsAndNext("Service Personalization".tr(), 'Available Schedules'.tr()),
    StepsAndNext("Available Schedules".tr(), 'Choose Location'.tr()),
    StepsAndNext("Choose Location".tr(), 'Informations'.tr()),
    StepsAndNext("Informations".tr(), 'Booking Confirmations'.tr()),
    StepsAndNext("Booking Confirmations".tr(), ''),
  ];

  decreaseStep(BuildContext context, {int decreaseBy = 1}) {
    //increase page steps by one
    Provider.of<BookStepsService>(context, listen: false)
        .decreaseCurrentStep(decreaseBy);
  }

  onNext(BuildContext context, {int increaseBy = 1}) {
    //increase page steps by one
    Provider.of<BookStepsService>(context, listen: false)
        .increaseCurrentStep(increaseBy);
  }
}

class StepsAndNext {
  String title;
  String subtitle;
  StepsAndNext(this.title, this.subtitle);
}
