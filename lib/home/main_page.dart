import 'package:eshop/home/cart_page/cart_page.dart';
import 'package:eshop/home/category_page/category_page.dart';
import 'package:eshop/home/home_page/home_page.dart';
import 'package:eshop/home/profile_page/profile_page.dart';
import 'package:eshop/utils/constants.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;
  List<Widget> pages = [
    const HomePage(),
    const CategoryPage(),
    const CartPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        fixedColor: kPrimaryColor,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
      ),
    );
  }
}
