import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_baker/controllers/firestore_services.dart';
import 'package:mr_baker/core/color.dart';
import 'package:mr_baker/core/constant.dart';
import 'package:mr_baker/views/widgets/information_detail.dart';
import 'package:mr_baker/views/widgets/orange_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;
  String menuId = Get.arguments;
  var userFavorites = [];
  var user;

  void getUserFavorite() async {
    user = await FirebaseFirestore.instance.collection('users').doc(userUid).get();
    setState(() {
      userFavorites = user.data()['wishlist'];
      if (userFavorites.contains(menuId)) {
        isFavorite = true;
      } else {
        isFavorite = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserFavorite();
  }

  DatabaseServices services = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: DatabaseServices.detailMenu(Get.arguments),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Stack(
              children: [
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * 0.4,
                  child: Image.network(
                    snapshot.data!['picture'],
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: screenSize.height * 0.4),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        snapshot.data!['menu_name'],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'KWD ${snapshot.data!['price'].toString()}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: orangeColor,
                        ),
                      ),
                    ),
                    InformationDetail(
                      screenSize: screenSize,
                      infoTitle: 'Delivery Info',
                      infoContent: 'Delivered between monday and thursday from 8pm to 91:32 pm',
                    ),
                    InformationDetail(
                      screenSize: screenSize,
                      infoTitle: 'Return policy',
                      infoContent: 'All our Products are double checked before leaving our stores so by any case you found a broken food please contact our hotline immediately.',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: OrangeButton(
                        screenSize: screenSize,
                        buttonText: 'Add to Cart',
                        buttonPress: () async {
                          String result = await services.addToCart(menuId, 1);
                          if (result != 'success') {
                            Get.snackbar('Item already in cart', "Item Founded", colorText: Colors.white, backgroundColor: Colors.blue,icon: Icon(Icons.info));
                          } else {
                            Get.snackbar('Success', 'Success add item to cart', colorText: Colors.white, backgroundColor: Colors.green);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.4,
                  color: Colors.black.withOpacity(0.1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0,horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Get.back(),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          color: isFavorite ? Colors.red : Colors.white,
                        ),
                        onPressed: () async {
                          if (isFavorite == false) {
                            var result = await DatabaseServices.addToWishList(Get.arguments);
                            if (result != 'success') {
                              Get.snackbar('Oops something when wrong', result, colorText: Colors.white, backgroundColor: Colors.red);
                            }
                            setState(() {
                              isFavorite = true;
                            });
                          } else {
                            var result = await DatabaseServices.removeFromWishList(Get.arguments);
                            if (result != 'success') {
                              Get.snackbar('Oops something when wrong', result, colorText: Colors.white, backgroundColor: Colors.red);
                            }
                            setState(() {
                              isFavorite = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
