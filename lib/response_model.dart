class Response_Model {

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

  Response_Model({this.id,
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

  Response_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    categoryId = json['category_id'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'];
    discountType = json['discount_type'];
    currency = json['currency'];
    inStock = json['in_stock'];
    avatar = json['avatar'];
    priceFinal = json['price_final'];
    priceFinalText = json['price_final_text'];
  }
//
//   String error;
//   String token;
//
//   Response_Model({this.error, this.token});
//
//   Response_Model.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     token = json['token'];
//   }
}
