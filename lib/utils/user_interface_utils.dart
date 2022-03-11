import 'package:flutter/material.dart';

class UserInterfaceUtils {
  static route(page, context) {
    return MaterialPageRoute(builder: (__) {
      return page;
    });
  }

  static showSnackBar(message, context, {duration}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}