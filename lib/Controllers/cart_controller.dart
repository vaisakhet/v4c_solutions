import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:v4c_solutions/Services/local_storage_repository.dart';
import '../Models/cart_model.dart';

class CartController extends GetxController {
  LocalStorageRepository _localStorageRepository = LocalStorageRepository();

  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  /// Item Count
  int get itemCount {
    // ignore: unnecessary_null_comparison
    if (_items == null) {
      return 0;
    }

    return _items.length;
  }

  /// product Count

  int get productsCount {
    var length = 0;
    // ignore: unnecessary_null_comparison
    if (_items == null) {
      return length;
    }
    _items.forEach((key, value) {
      length += value.quantity * 1;
    });

    return length;
  }

  /// Total Amount

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  /// Add item in to cart

  void addItem(
      {String? title,
      double? price,
      String? description,
      String? image,
      String? productId}) async {
    if (_items.containsKey(productId)) {
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.addProductsToCartList(
          box,
          _items.update(
              productId!,
              (existingItem) => CartItem(
                  title: existingItem.title,
                  price: existingItem.price,
                  image: existingItem.image,
                  productId: productId,
                  description: existingItem.description,
                  quantity: existingItem.quantity + 1)));
      // _items.update(
      //   productId!,
      //   (existingItem) => CartItem(
      //     title: existingItem.title,
      //     quantity: existingItem.quantity + 1,
      //     price: existingItem.price,
      //     productId: existingItem.productId,
      //     description: existingItem.description,
      //     image: existingItem.image,
      //   ),
      //);
    } else {
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.addProductsToCartList(
          box,
          _items.putIfAbsent(
              productId!,
              () => CartItem(
                  title: title!,
                  price: price!,
                  image: image!,
                  productId: productId,
                  description: description!,
                  quantity: 1)));
      // _items.putIfAbsent(
      //   productId!,
      //   () => CartItem(
      //       title: title!,
      //       quantity: 1,
      //       price: price!,
      //       productId: productId,
      //       description: description!,
      //       image: image!),
      // );
    }
    Get.snackbar(
      "$title Add to cart",
      "$price",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
    update();
  }

  /// remove item in to cart

  void removeItem(int productId) {
    _items.remove(productId);
    // update();
  }

  void incrementQuantity(String productId) async {
    Box box = await _localStorageRepository.openBox();
    _localStorageRepository.addProductsToCartList(
        box,
        _items.update(
            productId,
            (existingItem) => CartItem(
                title: existingItem.title,
                price: existingItem.price,
                image: existingItem.image,
                productId: productId,
                description: existingItem.description,
                quantity: existingItem.quantity + 1)));
    // _items.update(
    //   productId,
    //   (existingItem) => CartItem(
    //     title: existingItem.title,
    //     quantity: existingItem.quantity + 1,
    //     price: existingItem.price,
    //     productId: existingItem.productId,
    //     description: existingItem.description,
    //     image: existingItem.image,
    //   ),
    // );
    Get.snackbar(
      "Add Item",
      "Success",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
    update();
  }

  /// Degrement Quantity

  void decrementQuantity(String productId) async {
    // Box box = await _localStorageRepository.openBox();

    CartItem item =
        _items.values.firstWhere((element) => element.productId == productId);

    if (item.quantity <= 1) {
      _items.removeWhere((key, value) {
        return value.productId == productId;
      });
    } else {
      _items.update(
        productId,
        (existingItem) {
          return CartItem(
            title: existingItem.title,
            quantity: existingItem.quantity - 1,
            price: existingItem.price,
            productId: existingItem.productId,
            description: existingItem.description,
            image: existingItem.image,
          );
        },
      );
    }
    Get.snackbar(
      "Remove Item ",
      "Success",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
    update();
  }

  /// Clear items in cart

  void clearCart() {
    _items = {};
    update();
  }
}
