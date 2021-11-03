import 'Home_Data.dart';

class Send_Data {
  var id;
  var name;
  var title;
  var categoryId;
  var description;
  var price;
  var discount;
  var discountType;
  var currency;
  var inStock;
  String avatar;
  var priceFinal;
  var priceFinalText;

  Send_Data({this.id,
    this.name,
    this.title,
    this.categoryId,
    this.description,
    this.price,
    this.discount,
    this.discountType,
    this.currency,
    this.inStock,
    this.avatar,
    this.priceFinal,
    this.priceFinalText});


Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['name'] = this.name;
  data['title'] = this.title;
  data['category_id'] = this.categoryId;
  data['description'] = this.description;
  data['price'] = this.price;
  data['discount'] = this.discount;
  data['discount_type'] = this.discountType;
  data['currency'] = this.currency;
  data['in_stock'] = this.inStock;
  data['avatar'] = this.avatar;
  data['price_final'] = this.priceFinal;
  data['price_final_text'] = this.priceFinalText;
  return data;
}
//   String error;
//
//   Send_Data({this.error});
//
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['error'] = this.error;
//     return data;
//   }
}