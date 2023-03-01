import 'package:flutter_mvvm_ex1/model/ProductModel.dart';
import 'package:flutter_mvvm_ex1/repositories/ProductRepository.dart';
import 'package:get/get.dart';

class ProductViewModel extends GetxController {
  var productList = <ProductModel>[].obs;
  var cartList = <ProductModel>[].obs;
  var isLoading = true.obs;

  double get totalPrice => cartList.fold(0, (sum, item) => sum + item.price!);
  int get count => cartList.length;

  @override
  void onInit() {
    super.onInit();
    getAllProduct();
  }

  void clearCart() {
    cartList.clear();
  }

  void removeFromCart(ProductModel item) {
    cartList.removeWhere((element) => element.id == item.id);
  }

  void addToCart(ProductModel item) {
    cartList.add(item);
  }

  Future<void> getAllProduct() async {
    var product = await ProductRepository().fetchProducts();
    if (product != null) {
      productList.value = product;
      isLoading.value = false;
    } else {
      isLoading.value = true;
    }
  }
}
