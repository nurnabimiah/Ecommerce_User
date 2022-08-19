import 'package:flutter/material.dart';

class OrderSuccessfulPage extends StatefulWidget {
  static const String routeName = '/successful';

  const OrderSuccessfulPage({Key? key}) : super(key: key);

  @override
  _OrderSuccessfulPageState createState() => _OrderSuccessfulPageState();
}

class _OrderSuccessfulPageState extends State<OrderSuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Successful'),),
      body: Center(
        child: Column(
          children: [
            Text('Your order has been placed'),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text('Go back to Home'))
          ],
        ),
      ),
    );
  }
}
