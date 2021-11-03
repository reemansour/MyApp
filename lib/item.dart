import 'dart:convert';

import 'package:Project/screen_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Home_Data.dart';
import 'cart.dart';
import 'routes.dart';


class Item_screen extends StatefulWidget {
  Item_screen({Key key}) : super(key: key);

  @override
  ItemDetailsScreen createState() => ItemDetailsScreen();
}

class ItemDetailsScreen extends State<Item_screen> {
  Future<HomeData> future;
  bool isAdded = false;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    future = getitem() as Future<HomeData>;
  }

  HomeData obj1 = HomeData();

  Future<HomeData> getitem() async {
    /// Server LockUp - Get Response from it
    try {
      final response = await http
          .get(Uri.parse('https://retail.amit-learning.com/api/products'));
      obj1 = HomeData.fromJson(jsonDecode(response.body));
      print('obj1: ${jsonDecode(response.body)}');
      return obj1;
    } catch (error) {
      throw Exception('Failed to load data');
    }
  }

  int count = 0;

  void increase() {
    setState(() {
      count++;
    });
  }

  void decrease() {
    setState(() {
      if (count > 0)
        count--;
      else
        count = 0;
    });
  }

  void inc() {
    setState(() {
      counter++;
    });
  }
  @override
  Widget build(BuildContext context) {

    final screenArgument argu = ModalRoute
        .of(context)
        .settings
        .arguments;
    //var cart = FlutterCart();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.add_shopping_cart_rounded, color: Colors.white),
              onPressed: () {})
        ],
        title: Text('item'),
        backgroundColor: Colors.red[800],
      ),
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text('Data Not Found'));
                } else
                  return Padding(
                    padding: EdgeInsets.all(15.0),
                    child: ListView(
                      children: [
                      Container(
                      height: 400,
                      child: Image.network(obj1.products[argu.num].avatar,
                          fit: BoxFit.cover),
                    ),
                    Container(
                      height: 100,
                      color: Colors.white,
                      child: ListTile(
                        title: Text(obj1.products[argu.num].title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        subtitle: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(obj1.products[argu.num].name,
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 2.0,
                    ),
                    Container(
                      child: ListTile(
                        leading: Text(
                            '${obj1.products[argu.num].price} ${obj1
                                .products[argu.num].currency}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                        trailing:
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: Size(30.0, 30.0),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            onPressed: decrease,
                            //   if (count > 0) {
                            //     count--;
                            //   } else {
                            //     count = 0;
                            //   }
                            //   print('count:$count');
                            // },
                          ),
                          Container(
                              width: 30,
                              height: 30,
                              child: Center(
                                child: Text('$count'),
                              )),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: Size(30.0, 30.0),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: increase,
                            // count = count + 1;
                            // print('count: $count');
                            //},
                          ),
                        ]),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 2.0,
                    ),
                    Container(
                        height: 200,
                        width: double.infinity,
                        child: obj1.products[argu.num].description == null
                            ? Text('')
                            : Text('${obj1.products[argu.num].description}',
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                    RaisedButton(
                        onPressed: () async {
                          inc();
                          Navigator.pushNamed(context, routeList.cartScreen,
                              arguments: screenArgument(
                                  no: argu.num, counter: counter));
                          listItems.add(obj1.products[argu.num]);
                          // await UserSimplePreferences.saveItems(listItems);
                        },
                    color: Colors.red,
                    child: Text('Add to Cart',
                        style: TextStyle(color: Colors.white)),
                    ),

            ],
            ),
            );
          }
          }),
    );
  }
}
