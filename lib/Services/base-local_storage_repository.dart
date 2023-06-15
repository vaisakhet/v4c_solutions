import 'dart:ffi';
import 'package:hive/hive.dart';
import 'package:v4c_solutions/Models/cart_model.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  List<CartItem> getCartItemList(Box box);

  Future<Void> addProductsToCartList(Box box, CartItem cartItem);

  Future<Void> removeProductFromCartList(Box box, CartItem cartItem);

  Future<Void> clearCartItem(Box box, CartItem cartItem);
}
