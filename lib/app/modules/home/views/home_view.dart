import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Product List'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () => controller.productsList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10.0, // Spacing between columns
                        mainAxisSpacing: 10.0, // Spacing between rows
                        childAspectRatio:
                            1.0, // Ratio of the width to the height of grid items
                      ),
                      itemCount: controller
                          .productsList.length, // Total number of items

                      itemBuilder: (BuildContext context, int index) {
                        return GridTile(
                          header: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                    controller.productsList[index].productName!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                const SizedBox(height: 5),
                                Text(
                                    "Available - ${controller.productsList[index].isActive! ? "Yes" : "No"}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                                const SizedBox(height: 5),
                                Text(
                                    "Quantity - ${controller.productsList[index].quantity.toString()}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                              ],
                            ),
                          ),
                          footer: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              IconButton(
                                  onPressed: () async {
                                    await controller.addProduct(
                                        controller.productsList.value[index]);
                                  },
                                  icon: const Icon(Icons.add_shopping_cart)),
                              // IconButton(
                              //     onPressed: () async {
                              //       await controller.removeProduct(
                              //           controller.productsList[index]);
                              //     },
                              //     icon: const Icon(Icons.remove_shopping_cart)),
                              const SizedBox(width: 10),
                              IconButton(
                                  onPressed: () async {
                                    await controller.orderProduct(
                                        controller.productsList.value[index]);
                                  },
                                  icon: const Icon(Icons.payment)),
                              const SizedBox(width: 10),
                            ],
                          ),
                          child: Container(
                            // Your grid item UI here
                            color: const Color.fromARGB(255, 228, 207,
                                207), // Example of setting background color
                            alignment: Alignment.center,

                            // Your grid item UI here
                            child: const Column(
                              children: [],
                            ), // Example of aligning content
                          ),
                        );
                      },
                    ),
            ),
          )),
    );
  }
}
