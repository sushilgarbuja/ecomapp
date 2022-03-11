import 'package:flutter/material.dart';

const baseUrl = "https://ecommerce.saugatimilsina.com.np/api/v1";

class ColorConstants {
  static final kGreyColor = Colors.grey.shade300;
  static final kWarningColor = Colors.red;
  static final kInfoColor = Colors.yellow.shade300;
  static final kSuccessColor = Colors.green[700];
  static final kPrimaryTextColor = Colors.black;
  static final kSecondayTextColor = Colors.grey.shade800;
}

// Form Error
final RegExp emailValidatorRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

const kDividerColor = Color(0xFFF9F9F9);
const kInputColor = Color.fromARGB(255, 231, 231, 231);
const kPrimaryColor = Color(0xFF0084FF);
const kGreyColor = Color(0xFF969696);

class SizeConstants {
  static const normalSpacing = 12.0;
  static const mediumSpacing = 8.0;
  static const smallSpacing = 6.0;
  static const largeSpacing = 16.0;
}

class Keys {
  static const IS_LOGGED_KEY = "iilk";
  static const API_KEY = "ak";
  static const LOGIN_RESPONSE_KEY = "lrk";
}
