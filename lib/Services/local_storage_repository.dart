import 'package:hive/hive.dart';
import 'package:v4c_solutions/Services/base-local_storage_repository.dart';
import '../Models/cart_model.dart';

class LocalStorageRepository extends BaseLocalStorageRepository {
  String boxName = 'cartlist_product';

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<CartItem>(boxName);
    return box;
  }

  @override
  List<CartItem> getCartItemList(Box box) {
    return box.values.toList() as List<CartItem>;
  }

  @override
  Future<void> addProductsToCartList(Box box, CartItem cartItem) async {
    await box.put(cartItem.productId, cartItem);
  }

  @override
  Future<void> removeProductFromCartList(Box box, CartItem cartItem) async {
    await box.delete(cartItem.productId);
  }

  @override
  Future<void> clearCartItem(Box box, CartItem cartItem) async {
    await box.clear();
  }
}
