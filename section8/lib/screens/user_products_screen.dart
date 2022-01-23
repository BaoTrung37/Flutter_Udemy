import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ! lỗi chỗ này
    final String id = "_";
    print('building orders');
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Products',
        ),
        actions: [
          IconButton(
            onPressed: () {
              //TODO: implement logout
              // ! lỗi chỗ này
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: id);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, index) => Column(
              children: [
                UserProductItem(
                  id: productData.items[index].id,
                  title: productData.items[index].title,
                  imageUrl: productData.items[index].imageUrl,
                ),
                Divider(),
              ],
            ),
            itemCount: productData.items.length,
          ),
        ),
      ),
    );
  }
}
