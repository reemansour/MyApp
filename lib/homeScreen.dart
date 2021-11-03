import 'dart:convert';

import 'package:Project/Home_Data.dart';
import 'package:Project/item.dart';
import 'package:Project/screen_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'routes.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  Main_Screen createState() => Main_Screen();
}

class Main_Screen extends State<MainScreen> {
  Future<HomeData> future;

  @override
  void initState() {
    super.initState();
    future = getfunc() as Future<HomeData>;
  }

  HomeData wtf = HomeData();

  Future<HomeData> getfunc() async {
    /// Server LockUp - Get Response from it
    try {
      final response = await http
          .get(Uri.parse('https://retail.amit-learning.com/api/products'));

      wtf = HomeData.fromJson(jsonDecode(response.body));
      print(' wtf : ${jsonDecode(response.body)}');
      return wtf;
    } catch (error) {
      throw Exception('Failed to load data');
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.red[800],
          actions: [
            IconButton(
              icon: Icon(Icons.search_off_rounded,
                color: Colors.white,
              ),

            ),
          ],


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
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: wtf.products.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Card(
                            child: Hero(
                              tag: wtf.products[index].name.toString(),
                              child: Material(
                                child: InkWell(
                                  onTap: ()=> Navigator.pushNamed(context, routeList.secondscreen,
                                      arguments: screenArgument(num: index),
                                  ),
                                  child: GridTile(
                                    footer: Container(
                                      color: Colors.white70,
                                      child: ListTile(
                                        title: Text(
                                          wtf.products[index].title.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                        trailing: Text(
                                          '\$ ${wtf.products[index].price.toString()}',
                                          style: TextStyle(
                                            color: Colors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          wtf.products[index].name.toString(),
                                          // style: TextStyle(
                                          //     fontSize: 18,
                                          //     fontWeight: FontWeight.bold
                                          // ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                      ),
                                    ),
                                    child: Image.network(
                                      wtf.products[index].avatar,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );

                          // Padding(
                          //   padding: EdgeInsets.all(12.0),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(15),
                          //         image: DecorationImage(
                          //           fit: BoxFit.cover,
                          //           image: NetworkImage(
                          //               wtf.products[index].avatar),
                          //         )),
                          //     alignment: Alignment.bottomCenter,
                          //     child: Container(
                          //       width: double.infinity,
                          //       height: 150,
                          //       color: Colors.white,
                          //       child: Stack(children: [
                          //         ListTile(
                          //           title: Stack(
                          //             children: [
                          //               Flexible(
                          //                 child: Text(
                          //                   '${wtf.products[index].title.toString()}',
                          //                   maxLines: 1,
                          //                   softWrap: false,
                          //                   overflow: TextOverflow.fade,
                          //                   style: TextStyle(
                          //                       fontSize: 18,
                          //                       fontWeight: FontWeight.bold),
                          //                 ),
                          //               ),
                          //               Align(
                          //                 alignment: Alignment.bottomRight,
                          //                 child: Text(
                          //                     '${wtf.products[index].price.toString()}',
                          //                     style: TextStyle(
                          //                         fontWeight: FontWeight.bold,
                          //                         color: Colors.black)),
                          //               ),
                          //             ],
                          //           ),
                          //           subtitle: Stack(
                          //             children: [
                          //               Flexible(
                          //                 child: Text(
                          //                     '${wtf.products[index].name.toString()}',
                          //                     maxLines: 1,
                          //                     softWrap: false,
                          //                     overflow: TextOverflow.fade,
                          //                     style: TextStyle(
                          //                         fontWeight: FontWeight.bold,
                          //                         color: Colors.black)),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ]),
                          //     ),
                          //   ),
                          // );
                        });
              }
            }));
  }
}
