import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:troop/service/common_service.dart';
import 'package:troop/service/service_details_service.dart';
import 'package:troop/service/serviceby_category_service.dart';
import 'package:troop/view/services/service_details_page.dart';
import 'package:troop/view/utils/common_helper.dart';
import 'package:troop/view/utils/constant_colors.dart';
import 'package:troop/view/utils/others_helper.dart';
import 'package:troop/view/utils/responsive.dart';

import '../home/components/service_card.dart';

class ServicebyCategoryPage extends StatefulWidget {
  const ServicebyCategoryPage(
      {Key? key, this.categoryName = '', required this.categoryId})
      : super(key: key);

  final String categoryName;
  final categoryId;

  @override
  State<ServicebyCategoryPage> createState() => _ServicebyCategoryPageState();
}

class _ServicebyCategoryPageState extends State<ServicebyCategoryPage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon(widget.categoryName, context, () {
        Provider.of<ServiceByCategoryService>(context, listen: false)
            .setEverythingToDefault();

        Navigator.pop(context);
      }),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown:
            context.watch<ServiceByCategoryService>().currentPage > 1
                ? false
                : true,
        onRefresh: () async {

          final result = await Provider.of<ServiceByCategoryService>(context,
                  listen: false).fetchCategoryService(context, widget.categoryId);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await Provider.of<ServiceByCategoryService>(context,
                  listen: false)
              .fetchCategoryService(context, widget.categoryId);
          if (result) {
            //loadcomplete function loads the data again
            refreshController.loadComplete();
          } else {
            print(result);
            debugPrint('no more data');
            refreshController.loadNoData();

            Future.delayed(const Duration(seconds: 1), () {
              //it will reset footer no data state to idle and will let us load again
              refreshController.resetNoData();
            });
          }
        },

        child: WillPopScope(
          onWillPop: () {
            Provider.of<ServiceByCategoryService>(context, listen: false)
                .setEverythingToDefault();
            return Future.value(true);
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Consumer<ServiceByCategoryService>(
                builder: (context, provider, child) {

                  return
                    provider.isLoading != true

                    ?
                    provider.serviceMap.isNotEmpty
                        ? Column(children: [
                            // Service List ===============>
                            const SizedBox(
                              height: 15,
                            ),

                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap:true ,
                      itemBuilder: (context,index)=> Column(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                  const ServiceDetailsPage(),
                                ),
                              );
                              Provider.of<ServiceDetailsService>(
                                  context,
                                  listen: false)
                                  .fetchServiceDetails(provider
                                  .serviceMap[index]['serviceId']);
                            },
                            child: ServiceCard(
                              cc: cc,
                              imageLink: provider.serviceMap[index]
                              ['image'] ??
                                  placeHolderUrl,
                              rating: twoDouble(
                                  provider.serviceMap[index]['rating']),
                              title: provider.serviceMap[index]['title'],
                              sellerName: provider.serviceMap[index]
                              ['sellerName'],
                              price: provider.serviceMap[index]['price'],
                              buttonText: 'book now'.tr(),
                              width: double.infinity,
                              marginRight: 0.0,
                              pressed: () {
                                provider.saveOrUnsave(
                                    provider.serviceMap[index]['serviceId'],
                                    provider.serviceMap[index]['title'],
                                    provider.serviceMap[index]['image'],
                                    provider.serviceMap[index]['price']
                                        .round(),
                                    provider.serviceMap[index]
                                    ['sellerName'],
                                    twoDouble(provider.serviceMap[index]
                                    ['rating']),
                                    index,
                                    context,
                                    provider.serviceMap[index]['sellerId']);
                              },
                              isSaved: provider.serviceMap[index]
                              ['isSaved'] ==
                                  true
                                  ? true
                                  : false,
                              serviceId: provider.serviceMap[index]
                              ['serviceId'],
                              sellerId: provider.serviceMap[index]
                              ['sellerId'],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                      itemCount:  provider.serviceMap.length,
                    )

                          ])
                        :


                    Container(
                      alignment: Alignment.center,
                      height: screenHeight - 140,
                      child: const Text("No service available"),
                    )
                    :
                    Container(
                      alignment: Alignment.center,
                      height: screenHeight - 140,
                      child: OthersHelper().showLoading(cc.primaryColor),
                    );



                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
