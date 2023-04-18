import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troop/model/recent_service_model.dart';
import 'package:troop/model/serviceby_category_model.dart';
import 'package:troop/service/common_service.dart';
import 'package:troop/service/db/db_service.dart';
import 'package:troop/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceByCategoryService with ChangeNotifier {
  var serviceMap = [];
  bool alreadySaved = false;
  bool hasError = false;
  bool isLoading = true;

  late int totalPages;

  int currentPage = 1;
  var alreadyAddedtoFav = false;
  List averageRateList = [];
  List imageList = [];

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    print("app total pages "+totalPages.toString());
    notifyListeners();
  }

  setEverythingToDefault() {
    serviceMap = [];
    currentPage = 1;
    averageRateList = [];
    imageList = [];
    hasError = false;
    isLoading=true;
    notifyListeners();
  }

  fetchCategoryService(context, categoryId, {bool isrefresh = false}) async {
    // isLoading=true;
    //=================>
    var apiLink;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stateId = prefs.getString('state');
    if (stateId == null) {

      apiLink =
          '$baseApi/service-list/search-by-category/$categoryId?page=$currentPage';
    } else {

      apiLink =
          '$baseApi/service-list/search-by-category/$categoryId?page=$currentPage&state_id=$stateId';
    }
    //====================>

    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      // serviceMap = [];
      notifyListeners();

      Provider.of<ServiceByCategoryService>(context, listen: false)
          .setCurrentPage(currentPage);
    } else {
      // if (currentPage > 2) {
      //   refreshController.loadNoData();
      //   return false;
      // }
    }
    // serviceMap = [];
    // Future.delayed(const Duration(microseconds: 500), () {
    //   notifyListeners();
    // });
    var connection = await checkConnection();
    if (connection) {

      //if connection is ok
      var response = await http.get(Uri.parse(apiLink));

      if (response.statusCode == 201) {
        isLoading=false;

        var data = ServicebyCategoryModel.fromJson(jsonDecode(response.body));

        setTotalPage(data.allServices.lastPage);

        for (int i = 0; i < data.allServices.data.length; i++) {
          var serviceImage;

          if (data.serviceImage.length > i) {
            serviceImage = data.serviceImage[i].imgUrl;
          } else {
            serviceImage = null;
          }

          int totalRating = 0;
          for (int j = 0;
              j < data.allServices.data[i].reviewsForMobile.length;
              j++) {
            totalRating = totalRating +
                data.allServices.data[i].reviewsForMobile[j].rating!.toInt();
          }
          double averageRate = 0;

          if (data.allServices.data[i].reviewsForMobile.isNotEmpty) {
            averageRate = (totalRating /
                data.allServices.data[i].reviewsForMobile.length);
          }
          averageRateList.add(averageRate);
          imageList.add(serviceImage);
        }

        if (isrefresh) {
          print('refresh true');
          //if refreshed, then remove all service from list and insert new data
          setServiceList(
              data.allServices.data, averageRateList, imageList, false);
        } else {
          print('add new data');

          //else add new data
          setServiceList(
              data.allServices.data, averageRateList, imageList, true);
        }

        currentPage++;
        setCurrentPage(currentPage);

        return true;
      } else {
        print("XXXXX"+response.body);
        hasError = true;
        isLoading=false;

        notifyListeners();

        return false;
      }
    }
  }

  setServiceList(data, averageRateList, imageList, bool addnewData) {

    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      serviceMap = [];
      notifyListeners();
    }

    for (int i = 0; i < data.length; i++) {

      serviceMap.add({
        'serviceId': data[i].id,
        'title': data[i].title,
        'sellerName': data[i].sellerForMobile.name,
        'price': data[i].price,
        'rating': averageRateList[i],
        'image': imageList[i],
        'isSaved': false,
        'sellerId': data[i].sellerId,
      });
      checkIfAlreadySaved(data[i].id, data[i].title,
          data[i].sellerForMobile.name, serviceMap.length - 1);
    }
  }

  checkIfAlreadySaved(serviceId, title, sellerName, index) async {
    var newListMap = serviceMap;
    alreadySaved = await DbService().checkIfSaved(serviceId, title, sellerName);
    newListMap[index]['isSaved'] = alreadySaved;
    serviceMap = newListMap;
    notifyListeners();
  }

  saveOrUnsave(
      int serviceId,
      String title,
      String image,
      int price,
      String sellerName,
      double rating,
      int index,
      BuildContext context,
      sellerId) async {
    var newListMap = serviceMap;
    alreadySaved = await DbService().saveOrUnsave(
        serviceId, title, image, price, sellerName, rating, context, sellerId);
    newListMap[index]['isSaved'] = alreadySaved;
    serviceMap = newListMap;
    notifyListeners();
    categoryServiceSaveUnsaveFromOtherPage(serviceId, title, sellerName);
  }

  categoryServiceSaveUnsaveFromOtherPage(
    int serviceId,
    String title,
    String sellerName,
  ) async {
    int? index;
    for (int i = 0; i < serviceMap.length; i++) {
      if (serviceMap[i]['serviceId'] == serviceId &&
          serviceMap[i]['title'] == title &&
          serviceMap[i]['sellerName'] == sellerName) {
        index = i;
        break;
      }
    }

    if (index != null) {
      //if that product exist in other page then change the saved button accordingly
      var newListMap = serviceMap;
      alreadySaved =
          await DbService().checkIfSaved(serviceId, title, sellerName);
      newListMap[index]['isSaved'] = alreadySaved;
      serviceMap = newListMap;
      notifyListeners();
    }
  }
}
