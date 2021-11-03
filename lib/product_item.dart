import 'package:Project/Home_Data.dart';
import 'package:Project/products.dart';
import 'package:Project/screen_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Products product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    screenArgument hey = ModalRoute.of(context).settings.arguments;
    return Card(
      color: Color.fromRGBO(241, 238, 245, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(2),
            child: InkWell(
              onTap: () {
                Provider.of<ProductsProvider>(context, listen: false)
                    .removeItem(product.id);
              },
              child: Icon(
                Icons.clear,
                size: 18,
                color: Color.fromRGBO(132, 132, 132, 1),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Image.network(
              product.avatar,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${product.price}",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Color.fromRGBO(132, 132, 132, 1),
                        splashColor: Theme.of(context).accentColor,
                        disabledColor: Color.fromRGBO(150, 150, 150, 1),
                        onPressed:
                        hey.count == 0
                            ? null
                            : () {
                          int newQuantity = hey.count - 1;
                          Provider.of<ProductsProvider>(context,
                              listen: false)
                              .modifyQuantity(product.id, newQuantity);
                        },
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          product.price.toString(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Color.fromRGBO(132, 132, 132, 1),
                        splashColor: Theme.of(context).accentColor,
                        onPressed: () {
                          int newQuantity = product.price + 1;
                          Provider.of<ProductsProvider>(context, listen: false)
                              .modifyQuantity(product.id, newQuantity);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}