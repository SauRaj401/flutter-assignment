import 'dart:io';

import 'package:online_store/consts/app_apis.dart';
import 'package:http/http.dart' as http;

class ProductApiService {
  //services is used to ping endpoint.
  Future getAllProducts(int pageNo, int pageSize) async {
    try {
      Uri url = Uri.parse(AppApis.productApis.getAllProducts);
      var response = await http.get(url);

      return response;
    } on SocketException {
      return Future.error('No Internet connection');
    } on FormatException {
      return Future.error('Bad response format');
    } on Exception catch (error) {
      return Future.error(error.toString());
    }
  }
}
