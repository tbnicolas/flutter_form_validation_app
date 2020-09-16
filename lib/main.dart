import 'package:flutter/material.dart';
import 'package:flutter_form_validation_app/src/blocs/provider.dart';
import 'package:flutter_form_validation_app/src/pages/home_page.dart';
import 'package:flutter_form_validation_app/src/pages/login_page.dart';
import 'package:flutter_form_validation_app/src/pages/product_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'login',
        initialRoute: HomePage.routeName,
        routes: {
        LoginPage.routeName : (BuildContext context)=> new LoginPage(),
        HomePage.routeName : (BuildContext context)=> new HomePage(),
        ProductoPage.routeName : (BuildContext context)=> new ProductoPage(),

        },
        theme: new ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );


  }
}

