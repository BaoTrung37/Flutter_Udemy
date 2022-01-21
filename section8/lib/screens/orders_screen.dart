import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    // * Có thể sử dùng Provider.of<Orders>(context) bởi vì mình chỉ dùng dễ hiện thị chứ ko lắng nghe

    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders!'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
              itemBuilder: (ctx, index) =>
                  OrderItem(order: orderData.orders[index]),
              itemCount: orderData.orders.length,
            )),
    );
  }
}
