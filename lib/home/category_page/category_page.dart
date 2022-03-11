import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../api/responses.dart';
import '../../models/api_models.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Categories>? categories = [];
  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(10),
          itemCount: categories!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? 4
                    : 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: (4 / 5),
          ),
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: CachedNetworkImage(
                        imageUrl: categories![i].categoryImage!),
                  ),
                  Text(
                    "#${categories![i].name!}",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          }),
    );
  }

  void getCategories() {
    OnlineModel.getCategories(
      success: (List<Categories> data) {
        setState(() {
          categories = data.reversed.toList();
        });
      },
      fail: (msg) {},
    );
  }
}
