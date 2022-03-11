import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/api/responses.dart';
import 'package:eshop/utils/constants.dart';
import 'package:flutter/material.dart';

class SingleProductPage extends StatefulWidget {
  final Products? products;
  const SingleProductPage({Key? key, this.products}) : super(key: key);

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(children: [
          Stack(
            children: [
              buildSlider(widget.products!.images!),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ],
          ),
          Expanded(
              child: Stack(
            children: [
              getProductDetails(),
              Positioned(
                bottom: 0,
                child: getButtons(),
              )
            ],
          )),
        ]),
      ),
    );
  }

  CarouselSlider buildSlider(List<String> url) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 280.0,
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
                    fit: BoxFit.contain,
                  ),
                ));
          },
        );
      }).toList(),
    );
  }

  getProductDetails() {
    return Container(
      padding: const EdgeInsets.only(top: 20, right: 14, left: 14, bottom: 90),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.15),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.products!.name!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 0),
                child: Row(
                  children: [
                    Text(
                      "Rs. ${widget.products!.discountPrice}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                    Text(
                      "  Rs. ${widget.products!.price}",
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Icon(Icons.star_rate_rounded, color: Colors.yellow[800]),
                  const Text(
                    "5.0",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  const Text(
                    "  (1120) Reviews",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              widget.products!.description!,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }

  getButtons() {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Price\nRs. ${widget.products!.discountPrice}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Add To Bag"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ]),
    );
  }
}
