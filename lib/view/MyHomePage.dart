import 'package:flutter/material.dart';
import 'package:flutter_mvvm_ex1/model/ProductModel.dart';
import 'package:flutter_mvvm_ex1/view/CartPage.dart';
import 'package:flutter_mvvm_ex1/view_model/ProductViewModel.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProductViewModel productViewModel = Get.put(ProductViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() =>
            Text("Total Price: " + productViewModel.totalPrice.toString())),
        actions: [
          InkWell(
            onTap: () => Get.to(CartPage()),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(Icons.shopping_cart),
                  Obx(() => Text(productViewModel.count.toString()))
                ],
              ),
            ),
          )
        ],
      ),
      body: Obx(
        () => productViewModel.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.all(16),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                              productViewModel.productList[index].image!),
                        ),
                        Container(
                          child: Text(
                            "Rs." +
                                productViewModel.productList[index].price!
                                    .toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child:
                              Text(productViewModel.productList[index].title!),
                        ),
                        Obx(() => productViewModel.cartList
                                .contains(productViewModel.productList[index])
                            ? ElevatedButton(
                                onPressed: () {
                                  productViewModel.removeFromCart(
                                      productViewModel.productList[index]);
                                },
                                child: Text("Remove from cart"))
                            : ElevatedButton(
                                onPressed: () {
                                  productViewModel.addToCart(
                                      productViewModel.productList[index]);
                                },
                                child: Text("Add to cart")))
                      ],
                    );
                  },
                  itemCount: productViewModel.productList.length,
                ),
              ),
      ),
    );
  }
}
