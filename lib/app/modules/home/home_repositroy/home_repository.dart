import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:onlineretail/app/modules/home/model/product.dart';
import "package:dio/dio.dart";
import 'package:onlineretail/app/utilities/utility.dart';

class HomeRepository {
  final dio = Dio();
  Future<List<dynamic>> productList() async {
    String url = "https://uiexercise.theproindia.com/api/Product/GetAllProduct";
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        List<dynamic> jsonList = jsonDecode(response.body);
        // print(jsonList);

        // Map the JSON list to a list of Item objects
        // List<Product> items =
        //     jsonList.map((json) => Product.fromJson(json)).toList();

        return jsonList;
      } else {
        // If the server returns an error response, throw an exception
        return [];
        // throw Exception('Failed to load items');
      }
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> addproductList(Product item) async {
    String url = "https://uiexercise.theproindia.com/api/Product/AddProduct";
    Map<String, dynamic> singleItem = {
      "productName": item.productName ?? "",
      "quantity": item.quantity,
      "isActive": true
    };
    // Headers
    Map<String, String> headers = {
      // 'accept': 'application/json',
      'Content-Type': 'application/json'
      /* 'X-CSRFTOKEN': csrfToken,*/
    };

    print("API --- addproductAPI - $singleItem");
    print(url);
    try {
      final response =
          await http.post(Uri.parse(url), body: json.encode(singleItem));
      // final http.Client client;
      // Response response = await dio.post(url,
      //     options: Options(headers: headers), data: singleItem);
      // print("API --- addproductAPI 2");

      print(response.body);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        var jsonList = jsonDecode(response.body);
        print(jsonList);

        // Map the JSON list to a list of Item objects
        // List<Product> items =
        //     jsonList.map((json) => Product.fromJson(json)).toList();
        await Utility().toast("Successfully Product is added", Colors.green);

        return jsonList;
      } else {
        await Utility().toast(response.body, Colors.red);

        // If the server returns an error response, throw an exception
        return "";
        // throw Exception('Failed to load items');
      }
    } catch (e) {
      await Utility().toast(e.toString(), Colors.red);

      print(e);
      return "";
    }
  }

  Future<dynamic> orderProduct(Product item) async {
    String url = "https://uiexercise.theproindia.com/api/Order/AddOrder";
    Map<String, dynamic> singleItem = {
      "customerId": "710a0e5d-ebe1-4a04-aadd-045447243f52",
      "productId": item.productId!,
      "quantity": item.quantity!.toString()
    };
    print(singleItem);
    try {
      var response = await http.post(Uri.parse(url), body: singleItem);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        var jsonList = jsonDecode(response.body);
        print(jsonList);

        // Map the JSON list to a list of Item objects
        // List<Product> items =
        //     jsonList.map((json) => Product.fromJson(json)).toList();
        await Utility().toast("Successfully Order is added", Colors.green);
        return jsonList;
      } else {
        // If the server returns an error response, throw an exception
        print(response.body);
        await Utility().toast(response.body, Colors.red);

        return "";
        // throw Exception('Failed to load items');
      }
    } catch (e) {
      await Utility().toast(e.toString(), Colors.red);

      print(e);
      return "";
    }
  }
}
