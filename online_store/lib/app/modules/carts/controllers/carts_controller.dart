import 'package:get/get.dart';

import '../../../models/products/product.dart';

class CartsController extends GetxController {
  var cartItems = <GetProducts>[].obs;

  int get count => cartItems.length;
  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);

//to add the product to cart
  addToCart(GetProducts products) async {
    cartItems.add(products);
    Get.toNamed("home");
    update();
  }

//to remove product form cart
  removeFromCart(GetProducts product) {
    cartItems.remove(product);
    update();
  }
}
