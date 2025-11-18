import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_mobile_11pplg1_13/models/product_model.dart';
import 'package:pas_mobile_11pplg1_13/helpers/db_helper.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var products = <ProductModel>[].obs;
  final DBHelper dbHelper = DBHelper();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    const url = 'https://fakestoreapi.com/products';
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<ProductModel> loadedProducts = data
            .map((item) => ProductModel.fromJson(item))
            .toList();
        products.assignAll(loadedProducts);
        // sync bookmarked state from local database
        try {
          final favs = await dbHelper.getFavorites();
          final favIds = favs.map((e) => e.id).toSet();
          for (var i = 0; i < products.length; i++) {
            products[i].isBookmarked = favIds.contains(products[i].id);
          }
          products.refresh();
        } catch (_) {
          // ignore db errors here
        }
      } else {
        Get.snackbar("Error", "Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void toggleBookmark(ProductModel produk) async {
    final idx = products.indexWhere((p) => p.id == produk.id);
    if (idx != -1) {
      products[idx].isBookmarked = !products[idx].isBookmarked;
      products.refresh();
      // persist change
      try {
        if (products[idx].isBookmarked) {
          await dbHelper.insertFavorite(products[idx]);
        } else {
          await dbHelper.deleteFavoriteById(products[idx].id);
        }
      } catch (_) {
        // ignore db errors for now
      }
    }
  }
}
