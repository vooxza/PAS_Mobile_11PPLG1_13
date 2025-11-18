import 'package:flutter/material.dart';
import 'package:pas_mobile_11pplg1_13/models/product_model.dart';
import 'package:pas_mobile_11pplg1_13/widgets/widget_bookmark.dart';

class WidgetCard extends StatelessWidget {
  final ProductModel produk;
  final Function(bool) onBookmarkChanged;

  const WidgetCard({
    super.key,
    required this.produk,
    required this.onBookmarkChanged,
  });

  @override
  Widget build(BuildContext context) {
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
          onChanged: onBookmarkChanged,
        ),
      ),
    );
  }
}