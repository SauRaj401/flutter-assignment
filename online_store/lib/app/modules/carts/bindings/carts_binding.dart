import 'package:get/get.dart';

import '../controllers/carts_controller.dart';

class CartsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartsController>(
      () => CartsController(),
    );
  }
}
