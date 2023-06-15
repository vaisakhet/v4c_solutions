import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/products_controller.dart';
import '../Widgets/jewelery_items.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Categories",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.changeCategory(index);

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return JeweleryItems();
                        },
                      ));
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 30, 117, 33)),
                      child: Center(
                        child: Text(
                          controller.categories[index].toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
