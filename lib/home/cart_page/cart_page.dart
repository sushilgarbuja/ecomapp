import 'package:eshop/utils/DataHolder.dart';
import 'package:flutter/material.dart';

import '../../api/responses.dart';
import '../../models/api_models.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Products>? productList;
  @override
  void initState() {
    super.initState();
    getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
    );
  }

  void getCartItems() {
    OnlineModel.getCart(
      apiKey: "4bc5704de117415c9bd64e36ab2a4792",
      success: (List<Products> data) {
        setState(() {
          productList = data.reversed.toList();
        });
      },
      fail: (msg) {},
    );
  }
}
