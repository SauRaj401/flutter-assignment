import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:online_store/app/models/products/product.dart';
import 'package:online_store/app/modules/carts/controllers/carts_controller.dart';
import 'package:online_store/app/modules/home/views/product_details_view.dart';
import 'package:online_store/app/utils/helpers.dart';

import '../../../../consts/app_colors.dart';
import '../../../widgets/buttons/custom_rounded_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController homeController = Get.find();
  final cartsController = Get.put(CartsController());

  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPaletteA,
        title: const Text('Products'),
        centerTitle: true,
        //leading:
        actions: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: CustomRoundedButton(
              onTap: () {
                Get.toNamed("carts");
              },
              color: Colors.grey,
              radius: 10,
              width: 40,
              height: 40,
              shouldFill: false,
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.amber,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          cartsController.count.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(
                    color: AppColors
                        .colorPaletteA, // Set the desired color for the search label
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.colorPaletteA,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: AppColors
                          .colorPaletteA, // Set the desired border color when focused
                    ),
                  ),
                ),
                onChanged: (value) {
                  homeController.searchProducts(value);
                },
              ),
            ),
            Expanded(
              child: Obx(
                () => homeController.isLoading.value
                    ? Center(
                        child: Helpers.getLoadingWidget(
                            color: AppColors.colorPaletteA),
                      )
                    : _buildProducts(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildProducts(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: homeController.products.length,
        itemBuilder: (context, index) {
          GetProducts product = homeController.products[index];
          return Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Get.to(() => ProductDetailsView(),
                    arguments: {"product": product});
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      child: Image.network(
                        product.image,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.category,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            children: [
                              RatingStar(
                                rate: product.rating.rate,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                product.rating.rate.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '\$${product.price.toString()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              //color: AppColors.palletB,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RatingStar extends StatelessWidget {
  final double rate;
  final Color color;
  final double size;

  RatingStar({
    required this.rate,
    this.color = Colors.yellow,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rate.floor()) {
          // Full star
          return Icon(
            Icons.star,
            color: color,
            size: size,
          );
        } else if (index < rate.ceil()) {
          // Half star
          return Icon(
            Icons.star_half,
            color: color,
            size: size,
          );
        } else {
          // Empty star
          return Icon(
            Icons.star_border,
            color: color,
            size: size,
          );
        }
      }),
    );
  }
}
