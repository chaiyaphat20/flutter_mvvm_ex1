import 'package:flutter_mvvm_ex1/Utils/Constants.dart';
import 'package:flutter_mvvm_ex1/model/ProductModel.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  static var client = http.Client();

  Future<List<ProductModel>?> fetchProducts() async {
    var response = await client.get(Uri.parse(BASE_URL));
    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
