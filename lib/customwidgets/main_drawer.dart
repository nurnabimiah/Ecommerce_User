
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../pages/login_page.dart';
import '../pages/user_order_list_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.green,
            height: 200,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.person),
            title: Text('My Profile'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, UserOrderListPage.routeName),
            leading: Icon(Icons.reorder),
            title: Text('My Orders'),
          ),
          ListTile(
            onTap: () {
              AuthService
                  .logout()
                  .then((_) => Navigator.pushReplacementNamed(context, LoginPage.routeName));
            },
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
