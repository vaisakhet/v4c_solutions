import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v4c_solutions/Controllers/products_controller.dart';
import 'package:v4c_solutions/Models/womens_clothing_model.dart';
import 'package:v4c_solutions/Widgets/product_details.dart';

class ProductCategoryPages extends StatefulWidget {
  ProductCategoryPages({super.key});

  @override
  State<ProductCategoryPages> createState() => _ProductCategoryPagesState();
}

class _ProductCategoryPagesState extends State<ProductCategoryPages> {
  final ProductController productController = Get.put(ProductController());

  final scrollController = ScrollController();
  bool isLoadinMore = false;

  Future<void> _scrollListener() async {
    // print("Scroll Listener Called");
    // CircularProgressIndicator(
    //   color: Colors.green,
    // );
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print("call");
      setState(() {
        isLoadinMore = true;
      });
    } else {
      print(" don\'t called");
      setState(() {
        isLoadinMore = false;
      });
    }
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Color.fromARGB(255, 11, 84, 13),
              ))
            : GridView.builder(
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12),
                itemCount: isLoadinMore
                    ? controller.ladiesCloths.length + 1
                    : controller.ladiesCloths.length,
                itemBuilder: (context, index) {
                  if (index < controller.ladiesCloths.length) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                products:
                                    controller.ladiesCloths.elementAt(index),
                              ),
                            ));
                      },
                      child: ProductTitle(
                        products: controller.ladiesCloths[index],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
      },
    );
  }
}

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    super.key,
    required this.products,
  });
  final WomensClothings products;

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
