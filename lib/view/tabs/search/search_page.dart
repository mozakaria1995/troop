import 'package:flutter/material.dart';
import 'package:qixer/view/home/components/search_bar.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              clipBehavior: Clip.none,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    CommonHelper().titleCommon('Search services'),
                    sizedBox20(),
                    SearchBar(
                      cc: cc,
                    ),
                    Text(
                      'Best matched:',
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 14,
                      ),
                    ),

                    sizedBox20(),

                    for (int i = 0; i < 3; i++)
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
                        },
                        child: Column(
                          children: [
                            ServiceCardContents(
                              cc: cc,
                              imageLink:
                                  "https://cdn.pixabay.com/photo/2021/09/14/11/33/tree-6623764__340.jpg",
                              rating: '4.5',
                              title:
                                  'Hair cutting service at low price Hair cutting',
                              sellerName: 'Jane Cooper',
                              price: '30',
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 28, bottom: 20),
                              child: CommonHelper().dividerCommon(),
                            )
                          ],
                        ),
                      )

                    //
                  ]),
            ),
          ),
        ));
  }
}