import 'package:hive/hive.dart';
part 'cart_model.g.dart';

/// buildRunner Code : flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs

@HiveType(typeId: 1)
class CartItem {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String productId;
  @HiveField(4)
  final String description;
  @HiveField(6)
  final int quantity;

  CartItem({
    required this.title,
    required this.price,
    required this.image,
    required this.productId,
    required this.description,
    required this.quantity,
  });
}
