import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v4c_solutions/Views/category_screen.dart';
import 'package:v4c_solutions/Views/product_screen.dart';

import '../Controllers/cart_controller.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pages = [
    ProductCategoryPages(),
    const CartScreen(),
    CategoryPage(),
  ];

  int _currentIndex = 0;

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: const Color.fromARGB(255, 2, 78, 31),
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white.withOpacity(.60),
                  selectedFontSize: 14,
                  unselectedFontSize: 14,
                  onTap: (value) {
                    setState(() => _currentIndex = value);
                  },
                  items: [
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.preview), label: 'Products'),
                    BottomNavigationBarItem(
                        label: 'Cart',
                        icon: Stack(
                          children: [
                            const Icon(Icons.shopping_cart),
                            Positioned(
                                left: 11,
                                child: Container(
                                  height: 15,
                                  width: 12,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Center(
                                    child: Text(
                                      controller.itemCount.toString(),
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ))
                          ],
                        )),
                    const BottomNavigationBarItem(
                        label: 'Categories', icon: Icon(Icons.category))
                  ]),
              body: pages[_currentIndex],
            ));
      },
    );
  }
}
