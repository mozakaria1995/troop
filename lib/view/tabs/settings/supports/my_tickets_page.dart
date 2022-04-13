import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/tabs/orders/orders_helper.dart';
import 'package:qixer/view/tabs/settings/components/settings_page_grid.dart';
import 'package:qixer/view/tabs/settings/password/update_password_page.dart';
import 'package:qixer/view/tabs/settings/settings_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({Key? key}) : super(key: key);

  @override
  _MyTicketsPageState createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Support tickets', context),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < 2; i++)
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 3,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: cc.borderColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  '#812466',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: cc.primaryColor,
                                  ),
                                ),
                                // put the hamburger icon here
                                PopupMenuButton(
                                  // initialValue: 2,
                                  child: Icon(Icons.more_vert),
                                  itemBuilder: (context) {
                                    return List.generate(3, (index) {
                                      return PopupMenuItem(
                                        value: index,
                                        child: Text('button no $index'),
                                      );
                                    });
                                  },
                                )
                              ],
                            ),

                            //Ticket title
                            const SizedBox(
                              height: 7,
                            ),
                            CommonHelper()
                                .titleCommon('Emergency Service Needed'),

                            //Divider
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 17, bottom: 12),
                              child: CommonHelper().dividerCommon(),
                            ),
                            //Capsules
                            Row(
                              children: [
                                OrdersHelper()
                                    .statusCapsule('High', cc.warningColor),
                                const SizedBox(
                                  width: 11,
                                ),
                                OrdersHelper().statusCapsuleBordered(
                                    'Open', cc.greyParagraph),
                              ],
                            )
                          ]),
                    )
                ],
              ),
            ),
          ),
        ));
  }
}
