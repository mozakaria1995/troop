import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:troop/service/profile_service.dart';
import 'package:troop/view/tabs/settings/components/settings_page_grid.dart';
import 'package:troop/view/tabs/settings/password/change_password_page.dart';
import 'package:troop/view/tabs/settings/profile_edit.dart';
import 'package:troop/view/tabs/settings/settings_helper.dart';
import 'package:troop/view/tabs/settings/supports/my_tickets_page.dart';
import 'package:troop/view/utils/common_helper.dart';
import 'package:troop/view/utils/constant_colors.dart';
import 'package:troop/view/utils/constant_styles.dart';
import 'package:troop/view/utils/others_helper.dart';

import '../../../main.dart';
import '../../booking/booking_helper.dart';

class SettingsPage extends StatefulWidget {


  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


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
            physics: physicsCommon,
            child: Consumer<ProfileService>(
              builder: (context, profileProvider, child) => profileProvider
                          .profileDetails !=
                      null
                  ? profileProvider.profileDetails != 'error'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenPadding),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //profile image, name ,desc
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        //Profile image section =======>
                                        InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        ProfileEditPage(),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              profileProvider.profileImage !=
                                                      null
                                                  ? CommonHelper().profileImage(
                                                      profileProvider
                                                          .profileImage,
                                                      62,
                                                      62)
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.asset(
                                                        'assets/images/avatar.png',
                                                        height: 62,
                                                        width: 62,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),

                                              const SizedBox(
                                                height: 12,
                                              ),

                                              //user name
                                              CommonHelper().titleCommon(
                                                  profileProvider.profileDetails
                                                          .userDetails.name ??
                                                      ''),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              //phone
                                              CommonHelper().paragraphCommon(
                                                  profileProvider.profileDetails
                                                          .userDetails.phone ??
                                                      '',
                                                  TextAlign.center),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              profileProvider.profileDetails
                                                          .userDetails.about !=
                                                      null
                                                  ? CommonHelper()
                                                      .paragraphCommon(
                                                          profileProvider
                                                              .profileDetails
                                                              .userDetails
                                                              .about,
                                                          TextAlign.center)
                                                  : Container(),
                                            ],
                                          ),
                                        ),

                                        //Grid cards
                                        SettingsPageGrid(cc: cc),
                                      ],
                                    ),

                                    //
                                  ]),
                            ),
                            SettingsHelper().borderBold(30, 20),

                            // Personal information ==========>
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenPadding),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonHelper()
                                        .titleCommon('Personal informations'.tr()),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    BookingHelper().bRow(
                                        'null',
                                        'Email'.tr(),
                                        profileProvider.profileDetails
                                                .userDetails.email ??
                                            ''),
                                    BookingHelper().bRow(
                                        'null',
                                        'City'.tr(),
                                        profileProvider.profileDetails
                                                .userDetails.city.serviceCity ??
                                            ''),
                                    BookingHelper().bRow(
                                        'null',
                                        'Area'.tr(),
                                        profileProvider.profileDetails
                                                .userDetails.area.serviceArea ??
                                            ''),
                                    BookingHelper().bRow(
                                        'null',
                                        'Country'.tr()  ,
                                        profileProvider.profileDetails
                                                .userDetails.country.country ??
                                            ''),
                                    // BookingHelper().bRow(
                                    //     'null',
                                    //     'Post Code'.tr(),
                                    //     profileProvider.profileDetails
                                    //             .userDetails.postCode ??
                                    //         ''),
                                    BookingHelper().bRow(
                                        'null',
                                        'Address'.tr(),
                                        profileProvider.profileDetails
                                                .userDetails.address ??
                                            '',
                                        lastBorder: false),
                                  ]),
                            ),

                            SettingsHelper().borderBold(35, 8),

                            //Other settings options ========>
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                SettingsHelper().settingOption(
                                    'assets/svg/message-circle.svg',
                                    'Support Ticket'.tr(), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const MyTicketsPage(),
                                    ),
                                  );
                                }),
                                CommonHelper().dividerCommon(),
                                SettingsHelper().settingOption(
                                    'assets/svg/profile-edit.svg',
                                    'Edit Profile'.tr(), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          ProfileEditPage(),
                                    ),
                                  );
                                }),
                                CommonHelper().dividerCommon(),
                                SettingsHelper().settingOption(
                                    'assets/svg/lock-circle.svg',
                                    'Change Password'.tr(), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const ChangePasswordPage(),
                                    ),
                                  );
                                }),
                                CommonHelper().dividerCommon(),
                                Padding(
                                  padding: const EdgeInsets.all(16.0,),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Change Language").tr(),
                                      ToggleSwitch(
                                        activeBgColor: [cc.primaryColor,],
                                        inactiveBgColor: cc.secondaryColor,
                                        initialLabelIndex:localStorage.getInt("selectedLang")??0,
                                        totalSwitches: 2,
                                        labels: ['English'.tr(), 'Arabic'.tr()],
                                        onToggle: (index) async{
                                          localStorage.setInt("selectedLang", index!);

                                          if(index==0){

                                            context.setLocale(Locale('en'));
                                          }else{
                                            context.setLocale(Locale('ar'));
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ),

                            // logout
                            SettingsHelper().borderBold(12, 5),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                SettingsHelper().settingOption(
                                    'assets/svg/logout-circle.svg', 'Logout'.tr(),
                                    () {
                                  SettingsHelper().logoutPopup(context);
                                }),
                                sizedBox20()
                              ]),
                            )
                          ],
                        )
                      : OthersHelper().showError(context)
                  : Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height - 150,
                      child: OthersHelper().showLoading(cc.primaryColor),
                    ),
            ),
          ),
        ));
  }
}
