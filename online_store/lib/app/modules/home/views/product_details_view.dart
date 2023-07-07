import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:online_store/app/models/products/product.dart';
import 'package:online_store/app/modules/carts/controllers/carts_controller.dart';
import 'package:online_store/app/modules/home/controllers/home_controller.dart';

import '../../../../consts/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../../widgets/buttons/custom_rounded_button.dart';

class ProductDetailsView extends GetView {
  final HomeController homeController = Get.find();
  final cartsController = Get.put(CartsController());
  ProductDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var agruments = Get.arguments;
    GetProducts product = agruments["product"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPaletteA,
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 246, 247, 248),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: Get.size.height * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                              image: product.image.isNotEmpty
                                  ? NetworkImage(product.image)
                                  : const NetworkImage(
                                      "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg",
                                    ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${product.price.toString()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              product.title.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            Theme(
                              data: ThemeData().copyWith(
                                expansionTileTheme:
                                    const ExpansionTileThemeData().copyWith(
                                  iconColor: AppColors.colorPaletteA,
                                ),
                                dividerColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                title: Text(
                                  "Detail",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                tilePadding: EdgeInsets.zero,
                                children: [
                                  Text(
                                    product.description,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            color: Colors.white,
            child: CustomRoundedButton(
              radius: 8.0,
              color: AppColors.colorPaletteA,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    InkWell(
                      onTap: () async {
                        Get.showOverlay(
                          asyncFunction: () async {
                            await cartsController.addToCart(product);
                          },
                          loadingWidget: Helpers.getLoadingWidget(),
                        );
                      },
                      child: Text(
                        "Add to cart",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              // onTap: () {
              //   Get.toNamed("cart");
              // },
            ),
          ),
        ],
      ),
    );
  }
}
