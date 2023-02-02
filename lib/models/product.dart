
class Product {

  final String? pID;
  final String? pName;
  final int? pPrice;
  final String? pImage;

  Product({this.pID,this.pName,this.pPrice,this.pImage});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        pID: json['id'],
        pName : json['name'],
        pPrice: json['price'],
        pImage: json['image']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.pID;
    data['name'] = this.pName;
    data['price'] = this.pPrice;
    data['image'] = this.pImage;
    return data;
  }
}