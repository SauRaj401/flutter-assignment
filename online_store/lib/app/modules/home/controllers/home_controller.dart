import 'dart:convert';
import 'package:get/get.dart';

import 'package:online_store/app/models/products/product.dart';
import 'package:http/http.dart' as http;

import '../../../services/product_api_service.dart';

class HomeController extends GetxController {
  var products = <GetProducts>[].obs;

  int productPage = 0;
  int productPageSize = 10;
  var isLoading = false.obs;

//to fetch all the products
  getAllProducts() async {
    isLoading.value = true;
    //using try catch to handle error
    try {
      http.Response response = await ProductApiService()
          .getAllProducts(productPage, productPageSize);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var decodedJson = jsonDecode(response.body);
        var productsJson = jsonEncode(decodedJson);
        products.value = GetProducts.getProductsFromJson(productsJson);
        update();
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        var decodedResponse = jsonDecode(response.body);
        Get.showSnackbar(GetSnackBar(
          title: "Warning",
          message: decodedResponse["message"],
          duration: const Duration(seconds: 2),
        ));
      } else {
        throw Exception();
      }
    } catch (e) {
      e.printError();
    }
    isLoading.value = false;
  }

//search product function
  void searchProducts(String searchText) {
    final List<GetProducts> searchResults = [];

    if (searchText.isEmpty) {
      // If the search text is empty, show all products
      searchResults.addAll(products);
    } else {
      final lowercaseSearchText = searchText.toLowerCase();
      searchResults.addAll(products.where((product) {
        final lowercaseTitle = product.title.toLowerCase();
        return lowercaseTitle.contains(lowercaseSearchText);
      }));
    }
    products.value = searchResults;
    products.refresh();
    update();
  }

  @override
  void onInit() {
    getAllProducts();
    super.onInit();
  }
}
