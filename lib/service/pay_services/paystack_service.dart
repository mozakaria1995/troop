import 'package:flutter/material.dart';
import 'package:troop/view/payments/paystack_payment_page.dart';

class PaystackService {
  payByPaystack(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const PaystackPaymentPage(),
      ),
    );
  }
}
