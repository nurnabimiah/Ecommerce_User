import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

class OrderDetailsPage extends StatefulWidget {
  static const String routeName = '/order_details';

  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String? orderId;
  late OrderProvider _orderProvider;
  @override
  void didChangeDependencies() {
    orderId = ModalRoute.of(context)!.settings.arguments as String;
    _orderProvider = Provider.of<OrderProvider>(context);
    _orderProvider.getOrderDetails(orderId!);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: ListView.builder(
        itemCount: _orderProvider.orderDetailsList.length,
        itemBuilder: (context, index) {
          final details = _orderProvider.orderDetailsList[index];
          return ListTile(
            title: Text(details.productName),
            trailing: Text('${details.qty}x${details.price}'),
          );
        },
      ),
    );
  }
}
