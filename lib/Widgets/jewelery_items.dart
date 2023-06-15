import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v4c_solutions/Controllers/products_controller.dart';
import 'package:v4c_solutions/Widgets/category_selected_details.dart';
import 'package:v4c_solutions/Widgets/product_details.dart';

import '../Models/jewelery_model.dart';

class JeweleryItems extends StatelessWidget {
  JeweleryItems({super.key});
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Color.fromARGB(255, 11, 84, 13),
              ))
            : Scaffold(
                appBar: AppBar(),
                body: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12),
                    itemCount: controller.jeweleries.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryDetails(
                                      products: controller.jeweleries
                                          .elementAt(index))));
                        },
                        child: jeweleryTitels(
                          products: controller.jeweleries[index],
                        ),
                      );
                    }),
              );
      },
    );
  }
}

class jeweleryTitels extends StatelessWidget {
  const jeweleryTitels({
    super.key,
    required this.products,
  });
  final Jewelery products;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    products.image,
                    fit: BoxFit.cover,
                  ),
                ),
                // Positioned(
                //   right: 0,
                //   child: Obx(() => CircleAvatar(
                //         backgroundColor: Colors.white,
                //         child: IconButton(
                //           icon:
                //               // product.isFavorite.value
                //               //     ? Icon(Icons.favorite_rounded)
                //               //:
                //               Icon(Icons.favorite_border),
                //           onPressed: () {
                //             //product.isFavorite.toggle();
                //           },
                //         ),
                //       )),
                // )
              ],
            ),
            Text(
              products.title,
              maxLines: 2,
              style: const TextStyle(
                  fontFamily: 'avenir', fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis,
            ),
            Text('\$${products.price}',
                style: const TextStyle(fontSize: 18, fontFamily: 'avenir')),
          ],
        ),
      ),
    );
  }
}
