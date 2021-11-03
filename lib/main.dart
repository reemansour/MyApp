import 'dart:io';

import 'package:Project/cart.dart';
import 'package:Project/item.dart';
import 'package:Project/loginScreen.dart';
import 'package:Project/routes.dart';
import 'package:flutter/material.dart';
import 'categoriesScreen.dart';
import 'homeScreen.dart';


void main() async {
  /// save list
  // WidgetsFlutterBinding.ensureInitialized();
  // await UserSimplePreferences.init();
  runApp(MyApp());

}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
        // MainScreen(),
               initialRoute: routeList.login,
              routes: {
                routeList.login: (context) => FirstScreen(),
                routeList.firstscreen: (context) => MainScreen(),
                routeList.secondscreen: (context) => Item_screen(),
                routeList.thirdscreen: (context) => ScendScreen(),
                routeList.cartScreen: (context) => Cart_1(),
              }

        );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  PageController pageController = PageController();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }
  final Tabs=[
    MainScreen(),
    ScendScreen(),
    Cart_1(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:PageView(
          controller: PageController(),
          children:[
            Tabs[_selectedIndex],
          ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red[900],
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}