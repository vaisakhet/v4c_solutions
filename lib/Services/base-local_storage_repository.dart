import 'package:hive/hive.dart';
import 'package:v4c_solutions/Models/cart_model.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  List<CartItem> getCartItemList(Box box);

  Future<void> addProductsToCartList(Box box, CartItem cartItem);

  Future<void> removeProductFromCartList(Box box, CartItem cartItem);

  Future<void> clearCartItem(Box box, CartItem cartItem);
}
