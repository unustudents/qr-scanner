class ProductModel {
  int? code;
  String? name;
  int? qty;

  ProductModel({this.code, this.name, this.qty});

  ProductModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['qty'] = qty;
    return data;
  }
}
