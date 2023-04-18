import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:troop/view/home/components/search_bar.dart';
import 'package:troop/view/search/components/search_bar.dart';
import 'package:troop/view/search/search_bar_page_with_dropdown.dart';
import 'package:troop/view/home/components/service_card.dart';
import 'package:troop/view/services/service_details_page.dart';
import 'package:troop/view/utils/common_helper.dart';
import 'package:troop/view/utils/constant_colors.dart';
import 'package:troop/view/utils/constant_styles.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: physicsCommon,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenPadding),
                clipBehavior: Clip.none,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      CommonHelper().titleCommon('Search services'.tr()),
                      sizedBox20(),
                      //Search input field ============>
                      // SearchBar(
                      //   cc: cc,
                      //   isHomePage: false,
                      // ),
                      const SearchBar(),
                      // Text(
                      //   'Best matched:',
                      //   textAlign: TextAlign.start,
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     color: cc.greyFour,
                      //     fontSize: 14,
                      //   ),
                      // ),

                      // sizedBox20(),

                      // for (int i = 0; i < 3; i++)
                      //   InkWell(
                      //     splashColor: Colors.transparent,
                      //     highlightColor: Colors.transparent,
                      //     onTap: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute<void>(
                      //           builder: (BuildContext context) =>
                      //               const ServiceDetailsPage(),
                      //         ),
                      //       );
                      //     },
                      //     child: Column(
                      //       children: [
                      //         ServiceCardContents(
                      //           cc: cc,
                      //           imageLink:
                      //               "https://cdn.pixabay.com/photo/2021/09/14/11/33/tree-6623764__340.jpg",
                      //           rating: '4.5',
                      //           title:
                      //               'Hair cutting service at low price Hair cutting',
                      //           sellerName: 'Jane Cooper',
                      //           price: '30',
                      //         ),
                      //         Container(
                      //           margin:
                      //               const EdgeInsets.only(top: 28, bottom: 20),
                      //           child: CommonHelper().dividerCommon(),
                      //         )
                      //       ],
                      //     ),
                      //   )

                      //
                    ]),
              ),
            ),
          )),
    );
  }
}
