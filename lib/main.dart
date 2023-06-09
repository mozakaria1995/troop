import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:troop/service/all_services_service.dart';
import 'package:troop/service/app_string_service.dart';
import 'package:troop/service/auth_services/change_pass_service.dart';
import 'package:troop/service/auth_services/email_verify_service.dart';
import 'package:troop/service/auth_services/facebook_login_service.dart';
import 'package:troop/service/auth_services/google_sign_service.dart';
import 'package:troop/service/auth_services/login_service.dart';
import 'package:troop/service/auth_services/logout_service.dart';
import 'package:troop/service/auth_services/reset_password_service.dart';
import 'package:troop/service/book_confirmation_service.dart';
import 'package:troop/service/book_steps_service.dart';
import 'package:troop/service/booking_services/book_service.dart';
import 'package:troop/service/booking_services/coupon_service.dart';
import 'package:troop/service/booking_services/personalization_service.dart';
import 'package:troop/service/booking_services/place_order_service.dart';
import 'package:troop/service/booking_services/shedule_service.dart';
import 'package:troop/service/country_states_service.dart';
import 'package:troop/service/home_services/category_service.dart';
import 'package:troop/service/home_services/recent_services_service.dart';
import 'package:troop/service/home_services/slider_service.dart';
import 'package:troop/service/home_services/top_all_services_service.dart';
import 'package:troop/service/home_services/top_rated_services_service.dart';
import 'package:troop/service/leave_feedback_service.dart';
import 'package:troop/service/my_orders_service.dart';
import 'package:troop/service/order_details_service.dart';
import 'package:troop/service/pay_services/bank_transfer_service.dart';
import 'package:troop/service/pay_services/stripe_service.dart';
import 'package:troop/service/payment_gateway_list_service.dart';
import 'package:troop/service/profile_edit_service.dart';
import 'package:troop/service/profile_service.dart';
import 'package:troop/service/rtl_service.dart';
import 'package:troop/service/saved_items_service.dart';
import 'package:troop/service/serachbar_with_dropdown_service.dart';
import 'package:troop/service/service_details_service.dart';
import 'package:troop/service/auth_services/signup_service.dart';
import 'package:troop/service/serviceby_category_service.dart';
import 'package:troop/service/support_ticket/create_ticket_service.dart';
import 'package:troop/service/support_ticket/support_messages_service.dart';
import 'package:troop/service/support_ticket/support_ticket_service.dart';
import 'package:troop/view/intro/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences localStorage;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  localStorage=await SharedPreferences.getInstance();
  var publishableKey = await StripeService().getStripeKey();
  Stripe.publishableKey = publishableKey;
  await Stripe.instance.applySettings();
  Stripe.merchantIdentifier = 'any string works';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(EasyLocalization(
    supportedLocales: [Locale("en"),Locale("ar")],
    path: 'assets/lang',
    fallbackLocale: Locale('en', 'US'),
    child: const MyApp(


    ),
  ));

//get user id, so that we can clear everything cached by provider when user logs out and logs in again
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userId = prefs.getInt('userId');
}

int? userId;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      key: ObjectKey(userId),
      providers: [
        ChangeNotifierProvider(create: (_) => CountryStatesService()),
        ChangeNotifierProvider(create: (_) => SignupService()),
        ChangeNotifierProvider(create: (_) => BookConfirmationService()),
        ChangeNotifierProvider(create: (_) => BookStepsService()),
        ChangeNotifierProvider(create: (_) => AllServicesService()),
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => ResetPasswordService()),
        ChangeNotifierProvider(create: (_) => LogoutService()),
        ChangeNotifierProvider(create: (_) => ChangePassService()),
        ChangeNotifierProvider(create: (_) => ProfileService()),
        ChangeNotifierProvider(create: (_) => SliderService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => TopRatedServicesSerivce()),
        ChangeNotifierProvider(create: (_) => ProfileEditService()),
        ChangeNotifierProvider(create: (_) => RecentServicesService()),
        ChangeNotifierProvider(create: (_) => SavedItemService()),
        ChangeNotifierProvider(create: (_) => ServiceDetailsService()),
        ChangeNotifierProvider(create: (_) => LeaveFeedbackService()),
        ChangeNotifierProvider(create: (_) => GoogleSignInService()),
        ChangeNotifierProvider(create: (_) => StripeService()),
        ChangeNotifierProvider(create: (_) => BankTransferService()),
        ChangeNotifierProvider(create: (_) => ServiceByCategoryService()),
        ChangeNotifierProvider(create: (_) => PersonalizationService()),
        ChangeNotifierProvider(create: (_) => BookService()),
        ChangeNotifierProvider(create: (_) => BookService()),
        ChangeNotifierProvider(create: (_) => SheduleService()),
        ChangeNotifierProvider(create: (_) => CouponService()),
        ChangeNotifierProvider(create: (_) => AppStringService()),
        ChangeNotifierProvider(create: (_) => SearchBarWithDropdownService()),
        ChangeNotifierProvider(create: (_) => MyOrdersService()),
        ChangeNotifierProvider(create: (_) => PlaceOrderService()),
        ChangeNotifierProvider(create: (_) => FacebookLoginService()),
        ChangeNotifierProvider(create: (_) => SupportTicketService()),
        ChangeNotifierProvider(create: (_) => SupportMessagesService()),
        ChangeNotifierProvider(create: (_) => CreateTicketService()),
        ChangeNotifierProvider(create: (_) => EmailVerifyService()),
        ChangeNotifierProvider(create: (_) => OrderDetailsService()),
        ChangeNotifierProvider(create: (_) => RtlService()),
        ChangeNotifierProvider(create: (_) => TopAllServicesService()),
        ChangeNotifierProvider(create: (_) => PaymentGatewayListService()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Troop',
        theme: ThemeData(
          // scaffoldBackgroundColor: ConstantColors().secondaryColor,
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
