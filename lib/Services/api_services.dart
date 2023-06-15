import 'package:http/http.dart' as http;
import 'package:v4c_solutions/Models/category_model.dart';
import 'package:v4c_solutions/Models/womens_clothing_model.dart';

import '../Models/jewelery_model.dart';

class ApiService {
  static var client = http.Client();

  static Future<List<WomensClothings>?> fetchProducts() async {
    var url = Uri.parse('https://fakestoreapi.com/products?sort=desc');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return womensClothingsFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<String>?> fetchCategories() async {
    var url = Uri.parse('https://fakestoreapi.com/products/categories');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoryFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<Jewelery>?> fetchJeweleries(String categoryName) async {
    var url = 'https://fakestoreapi.com/products/category/';
    var response = await client.get(Uri.parse(url + categoryName));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jeweleryFromJson(jsonString);
    } else {
      return null;
    }
  }
}
