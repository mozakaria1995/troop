import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/service/login_service.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupService with ChangeNotifier {
  int selectedPage = 0;
  var pagecontroller;
  bool isloading = false;

  String phoneNumber = '0';
  setPhone(value) {
    phoneNumber = value;
    notifyListeners();
  }

  setPageController(p) {
    pagecontroller = p;
    Future.delayed(const Duration(milliseconds: 400), () {
      notifyListeners();
    });
  }

  setSelectedPage(int i) {
    selectedPage = i;
    notifyListeners();
  }

  prevPage(int i) {
    selectedPage = i;
    notifyListeners();
  }

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future<bool> signup(String fullName, String email, String userName,
      String password, BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      OthersHelper()
          .showToast("Please turn on your internet connection", Colors.black);
      return false;
    } else {
      setLoadingTrue();
      var data = jsonEncode({
        'name': fullName,
        'email': email,
        'username': userName,
        'phone': phoneNumber,
        'password': password,
        'service_city':
            Provider.of<CountryStatesService>(context, listen: false)
                .selectedStateId,
        'service_area':
            Provider.of<CountryStatesService>(context, listen: false)
                .selectedAreaId,
        'country_id': Provider.of<CountryStatesService>(context, listen: false)
            .selectedCountryId,
        'terms_conditions': 1,
      });
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      var response = await http.post(Uri.parse('$baseApi/register'),
          body: data, headers: header);

      if (response.statusCode == 201) {
        OthersHelper().showToast(
            "Registration successful", ConstantColors().successColor);

        setLoadingFalse();

        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const LandingPage(),
          ),
        );

        String token = jsonDecode(response.body)['token'];

        LoginService().saveDetails(email, password, token);

        return true;
      } else {
        //Sign up unsuccessful ==========>

        showError(jsonDecode(response.body)['errors']);
        setLoadingFalse();
        return false;
      }
    }
  }

  showError(error) {
    if (error.containsKey('email')) {
      OthersHelper().showToast(error['email'][0], Colors.black);
    } else if (error.containsKey('username')) {
      OthersHelper().showToast(error['username'][0], Colors.black);
    } else if (error.containsKey('phone')) {
      OthersHelper().showToast(error['phone'][0], Colors.black);
    } else {
      OthersHelper().showToast('Something went wrong', Colors.black);
    }
  }
}
