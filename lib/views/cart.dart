
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_baker/controllers/firestore_services.dart';
import 'package:mr_baker/views/routes/routes.dart';
import 'package:mr_baker/views/widgets/empty_item_page.dart';
import 'package:mr_baker/views/widgets/menu_card.dart';
import 'package:mr_baker/views/widgets/orange_button.dart';

class CartPage extends GetView<DatabaseServices> {
   const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Get.size;
    controller.getItemCounts();
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: controller.getUserOrder(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data!.docs.isEmpty) {
                return EmptyItemPage(screenSize: screenSize, pageTitle: 'Orders', imagePath: '');
              }
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Get.toNamed(AppRoutes.home);
                            },
                          ),
                          SizedBox(width: screenSize.width * 0.22),
                          const Text(
                            'Orders',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Obx(() => Text("Total ( ${controller.itemCount.value} )",style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),),),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height* .75,
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return MenuCard(
                              screenSize: screenSize,
                              menuItem: snapshot.data!.docs[index]['orders'],
                              documentType: 'orders',
                              amount: snapshot.data!.docs[index]['amount'],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: OrangeButton(
                            screenSize: screenSize,
                            buttonText: 'Place Order',
                            buttonPress: () async {
                              Get.snackbar('Success', 'Order Placed Successfully!!',
                                  colorText: Colors.white, backgroundColor: Colors.green);
                                  Future.delayed(const Duration(seconds: 2),(){
                                    controller.clearItems();
                                Get.toNamed(AppRoutes.home);
                              });
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}