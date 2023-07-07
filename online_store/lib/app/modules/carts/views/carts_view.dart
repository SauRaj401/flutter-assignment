import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:online_store/consts/app_colors.dart';

import '../controllers/carts_controller.dart';

class CartsView extends GetView<CartsController> {
  final CartsController _cartsController = Get.find<CartsController>();
  CartsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPaletteA,
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 246, 247, 248),
      body: Obx(
        () => ListView.builder(
          itemCount: _cartsController.count,
          itemBuilder: (context, index) {
            final product = _cartsController.cartItems[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: ListTile(
                  title: Text(product.title),
                  subtitle: Text('\$${product.price.toString()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      _cartsController.removeFromCart(product);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () {
              return Text(
                'Total Price: \$${_cartsController.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          )),
    );
  }
}
