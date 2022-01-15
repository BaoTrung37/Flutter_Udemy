import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/product_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Shop',
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              // print(selectedValue);
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  showOnlyFavorites = true;
                } else {
                  showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              )
            ],
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: ProductsGrid(
        showFavorites: showOnlyFavorites,
      ),
    );
  }
}
