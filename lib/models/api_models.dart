import 'dart:convert';
import 'package:eshop/api/responses.dart';
import 'package:eshop/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OnlineModel {
  static getSliders({success, fail}) {
    http.get(Uri.parse("$baseUrl/slider")).then((http.Response response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        success(SliderResponse.fromJson(json).sliders);
      } else {
        fail(response.reasonPhrase);
      }
    });
  }

  static getCategories({success, fail}) {
    http
        .get(Uri.parse("$baseUrl/get-categories"))
        .then((http.Response response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        success(CategoryResponse.fromJson(json).categories);
      } else {
        fail(response.reasonPhrase);
      }
    });
  }

  static getAllProducts({success, fail}) {
    http
        .get(Uri.parse("$baseUrl/get-all-products"))
        .then((http.Response response) {
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        success(ProductListResponse.fromJson(json).products);
      } else {
        fail(response.reasonPhrase);
      }
    });
  }

  static login({
    required email,
    required password,
    required success,
    required fail,
  }) {
    http.post(Uri.parse("$baseUrl/login"), body: {
      "email": email,
      "password": password
    }).then((http.Response response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(json);
        if (!loginResponse.error!) {
          SharedPreferences.getInstance().then((value) {
            value.setString(Keys.LOGIN_RESPONSE_KEY, json.toString());
            value.setBool(Keys.IS_LOGGED_KEY, true);
          });
          success(loginResponse);
        } else {
          fail(loginResponse.message);
        }
      } else {
        fail(response.reasonPhrase);
      }
    });
  }

  static register({
    required email,
    required password,
    required name,
    required success,
    required fail,
  }) {
    http.post(Uri.parse("$baseUrl/register"), body: {
      "name": name,
      "email": email,
      "password": password
    }).then((http.Response response) {
      if (response.statusCode == 201) {
        var json = jsonDecode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(json);
        if (!loginResponse.error!) {
          success(loginResponse);
        } else {
          fail(loginResponse.message);
        }
      } else {
        fail(response.reasonPhrase);
      }
    });
  }

  static addToCart(
      {required apiKey,
      required pid,
      required quanity,
      required success,
      required fail}) {
    http.post(Uri.parse("$baseUrl/cart"), headers: {
      'Apikey': apiKey
    }, body: {
      "p_id": pid,
      "quantity": quanity
    }).then((http.Response response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(json);
        if (!loginResponse.error!) {
          success(loginResponse);
        } else {
          fail(loginResponse.message);
        }
      } else {
        fail(response.reasonPhrase);
      }
    });
  }

  static getCart({required apiKey, required success, required fail}) {
    http.get(
      Uri.parse("$baseUrl/cart"),
      headers: {'Apikey': apiKey},
    ).then((http.Response response) {
      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
        var json = jsonDecode(response.body);
        success(ProductListResponse.fromJson(json).products);
      } else {
        fail(response.reasonPhrase);
      }
    });
  }
}
