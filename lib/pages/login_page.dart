
import 'package:ecom_user_starter/pages/product_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  String _errMsg = '';

  bool isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            shrinkWrap: true,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email Address'
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return emptyFieldErrMsg;
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                obscureText: _obscureText,
                controller: _passwordController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    hintText: 'Password'
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return emptyFieldErrMsg;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                child: Text('LOGIN'),
                onPressed: () {
                  isLogin = true;
                  _loginUser();
                },
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New User?'),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.blue
                    ),
                    child: Text('Reginster'),
                    onPressed: () {
                      isLogin = false;
                      _loginUser();
                    },
                  )
                ],
              ),
              Text(_errMsg)
            ],
          ),
        )
      ),
    );
  }

  void _loginUser() async {
    if(_formKey.currentState!.validate()) {
      try {
        User? user;
        if(isLogin) {
          user = await AuthService.loginUser(_emailController.text, _passwordController.text);
        }else {
          user = await AuthService.registerUser(_emailController.text, _passwordController.text);
        }
        if(user != null) {
          //todo create user and insert to db
          if(!isLogin) {
            final userModel = UserModel(
                userId: user.uid,
                email: user.email!,
              userCreationTime: user.metadata.creationTime!.millisecondsSinceEpoch,
            );
            Provider.of<UserProvider>(context, listen: false)
                .addUser(userModel).then((value) {
              Navigator.pushReplacementNamed(context, ProductListPage.routeName);
            });
          } else {
            Navigator.pushReplacementNamed(context, ProductListPage.routeName);
          }
        }
      } on FirebaseAuthException catch (error) {
        setState(() {
          _errMsg = error.message!;
        });
    }
    }
  }
}
