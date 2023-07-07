String baseURL = "https://fakestoreapi.com";

class AppApis {
  static ProductApis productApis = ProductApis();
}

class ProductApis {
  ProductApis();
  String get getAllProducts => "$baseURL/products";
}
