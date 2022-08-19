
import 'package:ecom_user_starter/pages/product_list_page.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import 'login_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher';
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if(AuthService.currentUser == null ) {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }else {
        Navigator.pushReplacementNamed(context, ProductListPage.routeName);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
