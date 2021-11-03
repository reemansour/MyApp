import 'dart:convert';
import 'package:Project/screen_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Home_Data.dart';
import 'package:http/http.dart' as http;
import 'item.dart';


List<Products> listItems=[];
class Cart_1 extends StatefulWidget {
  Cart_1({Key key}) : super(key: key);

  @override
  Cart createState() => Cart();
}

class Cart extends State<Cart_1> {

  Future<HomeData> future;

  @override
  void initState() {
    super.initState();
    future = get_cart();
  }

  HomeData obj2 = HomeData();

  Future<HomeData> get_cart() async {
    /// Server LockUp - Get Response from it
    try {
      final response = await http.get(
        ///lookup server
        Uri.parse('https://retail.amit-learning.com/api/products'),
      );
      obj2 = HomeData.fromJson(jsonDecode(response.body));
      print('obj2: ${jsonDecode(response.body)}');

      return obj2;
    } catch (error, stacktrace) {
      throw Exception(error.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    //screenArgument x = ModalRoute.of(context).settings.arguments;
     //print('NUMy: ${x.no}');
    // int current_product;
    // current_product = x.no;
    // List<String> litems = [];
    // litems.add(obj2.products[current_product].title.toString());
    // print('I am HERE:${litems[0]}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
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
                  return Column(
                    children:[
                      listItems.isEmpty ?
                      Center(child: Text('No items in Cart'))
                          :
                     ListView.builder(
                        shrinkWrap: true,
                        itemCount: listItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(14.0),
                            child: ListTile(
                              title: Text('${listItems[index].title.toString()}',
                                  style: TextStyle(fontSize: 18, color: Colors.black)),
                              leading: Image.network(listItems[index].avatar),
                              trailing:  Text('${listItems[index].price} ${listItems[index].currency}',
                              style: TextStyle(fontSize: 14, color: Colors.red),),
                            ),
                          );
                        }),

                      ],
                  );
              // ListView.builder(
              //                     itemCount: obj2.products.length,
              //                     itemBuilder: (BuildContext context, index) {
              //   return ListTile(
              //     leading: Icon(Icons.list),
              //     trailing: Text(
              //       '${obj2.products[x.no].title.toString()}',
              //       style:
              //           TextStyle(color: Colors.green, fontSize: 15),
              //     ),
              //     // title: Text(
              //     //
              //     //     '${litems[index].title.toString()}')
              //   );
              // });
            }
          }),
    );
  }
}
