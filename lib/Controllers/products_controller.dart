import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:v4c_solutions/Models/womens_clothing_model.dart';
import '../Models/jewelery_model.dart';
import '../Services/api_services.dart';

class ProductController extends GetxController {
  List<WomensClothings> ladiesCloths = [];
  List<String> categories = [];
  List<Jewelery> jeweleries = [];

  var CurrentIndex = 0;

  List<String> categorys = [
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];

  bool isLoading = true;

  @override
  void onInit() {
    fetchClothDetails();
    fetchCategory();
    changeCategory(CurrentIndex);
    super.onInit();
  }

  changeCategory(int index) async {
    CurrentIndex = index;
    update();

    try {
      isLoading = true;
      update();
      var items = await ApiService.fetchJeweleries(categorys[index]);
      if (items != null) {
        jeweleries = items;
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  /// fetching Products

  void fetchClothDetails() async {
    try {
      isLoading = true;
      update();
      var cloths = await ApiService.fetchProducts();
      if (cloths != null) {
        ladiesCloths = cloths;
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  /// fetching Categories

  void fetchCategory() async {
    try {
      isLoading = true;
      update();
      var items = await ApiService.fetchCategories();
      if (items != null) {
        categories = items;
      }
    } finally {
      isLoading = false;
      update();
    }
  }
}
