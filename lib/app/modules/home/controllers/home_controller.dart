import 'package:get/get.dart';
import 'package:onlineretail/app/modules/home/home_repositroy/home_repository.dart';
import 'package:onlineretail/app/modules/home/model/product.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  HomeRepository repo = HomeRepository();
  RxList<Product> productsList = <Product>[].obs;
  RxList<Product> addedList = <Product>[].obs;
  @override
  void onInit() async {
    super.onInit();
    await callProductList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> callProductList() async {
    await repo.productList().then((onValue) {
      // if(onValue == []){}
      // List<dynamic> item = json.decode(onValue);
      List<Product> items =
          onValue.map((json) => Product.fromJson(json)).toList();
      productsList.value = items;
      addedList.value = productsList.value;
      // productsList.sort((a, b) => a.quantity!.compareTo(b.quantity!));
      // productsList.refresh();
    });
  }

  Future<void> addProduct(Product element) async {
    Product orderP = Product(
        // productId: element.productId!,
        productName: element.productName!,
        quantity: element.quantity! + 1,
        isActive: element.isActive!);
    List<Product> list = productsList;
    for (int i = 0; i < list.length; i++) {
      if (list[i].productName == element.productName!) {
        list[i].quantity = list[i].quantity! + 1;
      } else {}
    }
    addedList.value = list;
    addedList.add(orderP);
    await repo.addproductList(orderP).then((onValue) {
      print(onValue);
    });
  }

  Future<void> removeProduct(Product element) async {
    Product s = Product(
        productId: element.productId!,
        productName: element.productName!,
        quantity: element.quantity! - 1,
        isActive: element.isActive!);
    List<Product> list = productsList.value;
    list.removeWhere((test) => test.productName! == element.productName);
    addedList.value = list;
    addedList.add(s);

    await repo.addproductList(s).then((onValue) {
      print(onValue);
    });
  }

  Future<void> orderProduct(Product p) async {
    await repo.orderProduct(p).then((response) {
      print(response);
    });
  }

  // Future<void> addProductList() async {
  //   await repo.addproductList(addedList).then((onValue) {
  //     // if(onValue == []){}
  //     // List<dynamic> item = json.decode(onValue);
  //     List<Product> items =
  //         onValue.map((json) => Product.fromJson(json)).toList();
  //     productsList.value = items;
  //     // productsList.sort((a, b) => a.quantity!.compareTo(b.quantity!));
  //     // productsList.refresh();
  //   });
  // }
}
