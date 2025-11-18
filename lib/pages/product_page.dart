import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_13/controllers/product_controller.dart';
import 'package:pas_mobile_11pplg1_13/widgets/widget_bookmark.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Page"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Obx((){
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());  
          }
        return RefreshIndicator(
          onRefresh: () {
            controller.fetchProducts();
            return Future.value();  
          },
          child: ListView.builder(
            itemCount: controller.products.value.length,
            itemBuilder: (context, index) {
              final produk = controller.products.value[index];
              return Card(
                child: ListTile(
                  leading: Image.network(
                    produk.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  title: Text(produk.title),
                  subtitle: Text("\$${produk.price}"),
                  trailing: WidgetBookmark(
                    initialValue: produk.isBookmarked,
                    onChanged: (isBookmarked) {
                      controller.toggleBookmark(produk);
                    },
                  ),
                ),
              );
            }
          ),
        );
        }),
      ),
    );
  }
}
