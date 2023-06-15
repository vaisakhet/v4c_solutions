import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v4c_solutions/Controllers/cart_controller.dart';
import 'package:v4c_solutions/Models/jewelery_model.dart';
import 'package:v4c_solutions/Views/cart_screen.dart';

class CategoryDetails extends StatelessWidget {
  CategoryDetails({super.key, required this.products});
  final Jewelery products;
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(
                    products.image,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('\$${products.price}',
                      textAlign: TextAlign.left,
                      style:
                          const TextStyle(fontSize: 32, fontFamily: 'avenir')),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  products.title,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w800),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  products.description,
                  maxLines: 6,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 65, 64, 64),
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                // ignore: unnecessary_null_comparison
                if (products.rating != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            products.rating.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Color.fromARGB(255, 239, 185, 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        controller.addItem(
                            productId: products.id.toString(),
                            title: products.title,
                            description: products.description,
                            price: products.price,
                            image: products.image);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const CartScreen()));
                      },
                      child: const Center(
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
