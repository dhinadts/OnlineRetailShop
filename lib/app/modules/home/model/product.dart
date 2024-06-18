class Product {
  String? productId;
  String? productName;
  int? quantity;
  bool? isActive;

  Product({
    this.productId,
    this.productName,
    this.quantity,
    this.isActive,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'] as String?;
    productName = json['ProductName'] as String?;
    quantity = json['Quantity'] as int?;
    isActive = json['IsActive'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ProductId'] = productId;
    json['ProductName'] = productName;
    json['Quantity'] = quantity;
    json['IsActive'] = isActive;
    return json;
  }
}
