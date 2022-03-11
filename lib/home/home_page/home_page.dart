import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/home/product_page/product_page.dart';
import 'package:eshop/models/api_models.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/user_interface_utils.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../api/responses.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: kInputColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.search,
                color: Colors.grey,
              ),
              Text(
                "  Search For Products",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
        elevation: 1,
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final url = [];
  late List<Sliders> sliders;
  List<Categories>? categories;
  List<Products>? productList;

  @override
  void initState() {
    getSlider();
    getCategories();
    getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (url.isNotEmpty) buildSlider(),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                GestureDetector(
                    child: const Text(
                  "SHOP MORE >",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: kPrimaryColor),
                ))
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            if (categories != null) buildCategoryLayout(context),
            const SizedBox(
              height: 14,
            ),
            const Text(
              "Just For You",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 14,
            ),
            buildProductsList()
          ],
        ),
      ),
    );
  }

  Container buildCategoryLayout(BuildContext context) {
    return Container(
      height: 230,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.2),
          borderRadius: BorderRadius.circular(10)),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories!.length > 8 ? 8 : categories!.length,
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

  CarouselSlider buildSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150.0,
        autoPlay: true,
        viewportFraction: 1,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 1500),
      ),
      items: url.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: i,
                    fit: BoxFit.fill,
                  ),
                ));
          },
        );
      }).toList(),
    );
  }

  void getSlider() {
    OnlineModel.getSliders(
      success: (List<Sliders> data) {
        setState(() {
          sliders = data;
          for (var element in data) {
            url.add(element.image);
          }
        });
      },
      fail: (msg) {},
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

  void getAllProducts() {
    OnlineModel.getAllProducts(
      success: (List<Products> data) {
        setState(() {
          productList = data.reversed.toList();
        });
      },
      fail: (msg) {},
    );
  }

  buildProductsList() {
    if (productList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? 3
                    : 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 8,
            childAspectRatio: (1.9 / 3),
          ),
          itemCount: productList!.length,
          itemBuilder: (c, i) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => SingleProductPage(
                              products: productList![i],
                            ))));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(children: [
                  SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: CachedNetworkImage(
                          imageUrl: productList![i].images!.first)),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productList![i].name!,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Rs. ${productList![i].discountPrice!}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: kPrimaryColor),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Rs. ${productList![i].price}",
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            );
          });
    }
  }
}

class FruitList extends StatelessWidget {
  const FruitList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ["Mango", "Banana", "Apple", "Cucumber", "Grapes"];
    final url = [
      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Carabao_mangoes_%28Philippines%29.jpg/440px-Carabao_mangoes_%28Philippines%29.jpg",
      "https://cdn1.sph.harvard.edu/wp-content/uploads/sites/30/2018/08/bananas-1354785_1920.jpg",
      "https://usapple.org/wp-content/uploads/2019/10/apple-pink-lady.png",
      "https://static.libertyprim.com/files/familles/concombre-large.jpg",
      "https://monsabsmarketplace.com/wp-content/uploads/2020/12/Grapes.jpg"
    ];
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: data.length,
        itemBuilder: (_, i) {
          return ListTile(
            onTap: () {
              UserInterfaceUtils.showSnackBar("${data[i]} Clicked", context);
            },
            title: Text(data[i]),
            trailing: SizedBox(
              height: 50,
              width: 50,
              child: Image.network(
                url[i],
                fit: BoxFit.fill,
              ),
            ),
          );
        });
  }
}
