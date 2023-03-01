import 'package:flutter/material.dart';
import 'package:flutter_mvvm_ex1/view/MyHomePage.dart';
import 'package:flutter_mvvm_ex1/view_model/ProductViewModel.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ProductViewModel productViewModel = Get.put(ProductViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        actions: [
          InkWell(
            onTap: () {
              productViewModel.clearCart();
              Get.offAll(const MyHomePage());
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              alignment: Alignment.center,
              child: const Text("Clear All"),
            ),
          )
        ],
      ),
      body: Obx(
        () => Stack(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image: NetworkImage(productViewModel
                                        .cartList[index].image!))),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                  productViewModel.productList[index].title!),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              productViewModel.removeFromCart(
                                  productViewModel.cartList[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
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
                      const Divider()
                    ],
                  ),
                );
              },
              itemCount: productViewModel.cartList.length,
            ),
            Positioned(
              bottom: 100,
              child: Card(
                color: Colors.brown,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "${productViewModel.count} products available",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Total Price: Rs.${productViewModel.totalPrice}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
