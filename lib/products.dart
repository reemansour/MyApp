import 'dart:convert';
import 'package:Project/Home_Data.dart';
import 'package:Project/screen_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Products> _products = [];
  double _totalPrice = 0.0;
//  String _baseUrl = "http://164.52.197.189:8181/fdb/prudle/db001/query";
  String _baseUrl = "https://retail.amit-learning.com/api/products";

  get products {
    return _products;
  }

  Products getProductById(String id) {
    return _products.firstWhere((product) => product.id == id,
        orElse: () => null);
  }

  double get totalPrice {
    return _totalPrice;
  }

  void setTotalPrice(double newPrice) {
    _totalPrice = newPrice;
  }

  void calculateTotalPrice() {
    _totalPrice = 0.0;
    _products.forEach((product) {
      _totalPrice += product.price;
          //* product.;
    });
  }

  void modifyQuantity(String id, int newQuantity) {
    Products product = getProductById(id);
    //product.quantity = newQuantity;
    calculateTotalPrice();
    notifyListeners();
  }

  void removeItem(String id) {
    _products.removeWhere((product) => product.id == id);
    calculateTotalPrice();
    notifyListeners();
  }

  bool checkIfExists(String id) {
    Products product = getProductById(id);
    if (product == null) {
      return false;
    }
    return true;
  }

  Future<void> fetchProducts(String barcodeValue) async {
    try {
//      final response = await http.post(
//        _baseUrl,
//        body: json.encode({
//          "select": {
//            "?group": [
//              "barcodeValue",
//              "productName",
//              "productVariant",
//              "productImage",
//              "productPrice"
//            ]
//          },
//          "where": [
//            ["?group", "productDetails/barcodeValue", barcodeValue]
//          ]
//        }),
//      );
      final response = await http.get(_baseUrl);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List;
        Products product;
        for(var item in extractedData) {
          print(item["barcodeValue"]);
          if(item["barcodeValue"] == barcodeValue) {
            print("__________");
            product = Products.fromJson(item);
            break;
          }
        }
        /// If product already exists then increment quantity instead of
        /// adding to list
        if (checkIfExists(product.id)) {
          product = getProductById(product.id);
          //product. += 1;
        } else {
          /// Insert new product at top of list
          _products.insert(0, product);
        }

        /// Modify total price
        calculateTotalPrice();
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }
}