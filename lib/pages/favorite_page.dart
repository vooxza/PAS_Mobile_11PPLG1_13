import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_13/controllers/product_controller.dart';
import 'package:pas_mobile_11pplg1_13/models/product_model.dart';
import 'package:pas_mobile_11pplg1_13/widgets/widget_bookmark.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Page"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Obx(() {
          final List<ProductModel> bookmarks = controller.products.where((p) => p.isBookmarked).toList();
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (bookmarks.isEmpty) {
            return Center(child: Text('No bookmarks yet'));
          }
          return ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final produk = bookmarks[index];
              return Card(
                key: ValueKey(produk.id),
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
                    onConfirm: (newValue) async {
                      if (!newValue) {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Are you sure?'),
                            content: const Text('Remove this item from favorites?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(false),
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(true),
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        );
                        return confirmed == true;
                      }
                      return true;
                    },
                    onChanged: (isBookmarked) {
                      controller.toggleBookmark(produk);
                    },
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}