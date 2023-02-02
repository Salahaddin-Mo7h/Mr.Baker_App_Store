import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_baker/controllers/firestore_services.dart';
import 'package:mr_baker/views/widgets/empty_item_page.dart';
import 'package:mr_baker/views/widgets/menu_card.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: DatabaseServices.getUserWhislist(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data!['wishlist'].length == 0) {
                return EmptyItemPage(
                  screenSize: screenSize,
                  pageTitle: 'Wishlist',
                  imagePath: '',
                );
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
                              Get.back();
                            },
                          ),
                          SizedBox(width: screenSize.width * 0.22),
                          const Text(
                            'Wishlist',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height,
                        child: ListView.builder(
                          itemCount: snapshot.data!['wishlist'].length,
                          itemBuilder: (context, index) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return MenuCard(
                              screenSize: screenSize,
                              menuItem: snapshot.data!['wishlist'][index],
                              documentType: 'wishlist',
                            );
                          },
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
