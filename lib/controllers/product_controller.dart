import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_mobile_11pplg1_13/models/product_model.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var products = <ProductModel>[].obs;
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
      } else {
        Get.snackbar("Error", "Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void toggleBookmark(ProductModel produk) {
    final idx = products.indexWhere((p) => p.id == produk.id);
    if (idx != -1) {
      products[idx].isBookmarked = !products[idx].isBookmarked;
      products.refresh();
    }
  }
}
