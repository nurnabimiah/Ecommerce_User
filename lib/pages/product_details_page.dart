import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/product_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName = '/product_details';

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductProvider _productProvider;
  String? _productId;
  String? _productName;
  bool _isUploading = false;
  ImageSource _imageSource = ImageSource.camera;
  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    _productId = argList[0];
    _productName = argList[1];
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_productName!),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: _productProvider.getProductByProductId(_productId!),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final product = ProductModel.fromMap(snapshot.data!.data()!);
              return Stack(
                children: [
                  ListView(
                    children: [
                      product.imageDownloadUrl == null ?
                          Image.asset('images/imagenotavailable.png', width: double.infinity, height: 250, fit: BoxFit.cover,) :
                          FadeInImage.assetNetwork(
                            image: product.imageDownloadUrl!,
                            placeholder: 'images/imagenotavailable.png',
                            width: double.infinity,
                            fadeInDuration: const Duration(seconds: 3),
                            fadeInCurve: Curves.bounceInOut,
                            height: 250,
                            fit: BoxFit.cover,
                          ),

                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey, width: 2)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Sale Price'),
                            Text('BDT ${product.price}', style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            if(snapshot.hasError) {
              return const Text('Failed to fetch data');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
