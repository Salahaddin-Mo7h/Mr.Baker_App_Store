import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_baker/controllers/firestore_services.dart';
import 'package:mr_baker/core/color.dart';
import 'package:mr_baker/core/constant.dart';
import 'package:mr_baker/views/routes/routes.dart';
import 'package:mr_baker/views/widgets/category.dart';
import 'package:mr_baker/views/widgets/drawer.dart';
import 'package:mr_baker/views/widgets/item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

final storeController = Get.find<DatabaseServices>();

class _HomePageState extends State<HomePage> {
  bool sidebarOpen = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  void setSidebarState() {
    setState(() {
      xOffset = sidebarOpen ? 200 : 0;
      yOffset = sidebarOpen ? 130 : 0;
      scaleFactor = sidebarOpen ? 0.7 : 1;
    });
  }

  DatabaseServices services = Get.put(DatabaseServices());
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: orangeColor,
      body: SafeArea(
        child: Stack(
          children: [
            CutomDrawer(
              screenSize: screenSize,
            ),
            Container(
              transform: Matrix4.translationValues(180, 170, 0)
                ..scale(0.7),
              height: screenSize.height * 0.93,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            AnimatedContainer(
              curve: Curves.easeInOut,
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: sidebarOpen ? BorderRadius.circular(30.0) : null,
              ),
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor),
              duration: const Duration(milliseconds: 250),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              sidebarOpen = !sidebarOpen;
                              setSidebarState();
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/menu.svg',
                              color: Colors.black,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 5.0, 10.0, 5.0),
                            child: const Text(
                              'Mr.Baker-Store',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.cart);
                            },
                            icon: Obx(() => Badge(
                              badgeColor: orangeColor,
                              padding: const EdgeInsets.all(5.0),
                              badgeContent: Text(services.total.value.toString()),
                                child: const Icon(Icons.shopping_cart))),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0),
                      decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Obx(() {
                        TimeOfDay now = TimeOfDay.now();
                        DateTime closeTime = services.stores.value.close_at?.toDate()??DateTime.now();
                        DateTime openTime = services.stores.value.open_at?.toDate()??DateTime.now();
                        services.getTotals();
                        Duration difference = (closeTime).difference(DateTime.now());
                        print(difference);
                        int hours = difference.inHours % 24;
                        int minutes = difference.inMinutes % 60;
                        TimeOfDay openingTime = TimeOfDay(hour: openTime.hour,minute: openTime.minute); // or leave as DateTime object
                        TimeOfDay closingTime = TimeOfDay(hour: closeTime.hour,minute: closeTime.minute);
                        int shopOpenTimeInSeconds = openingTime.hour * 60 + openingTime.minute;
                        int shopCloseTimeInSeconds = closingTime.hour * 60 + closingTime.minute;
                        int timeNowInSeconds = now.hour * 60 + now.minute;
                        if (shopOpenTimeInSeconds <= timeNowInSeconds &&
                            timeNowInSeconds <= shopCloseTimeInSeconds) {
                          storeController.isClose.value==false;
                        } else {
                          storeController.isClose.value==true;
                          Future.delayed(const Duration(milliseconds: 100),(){
                            Get.offAllNamed(AppRoutes.storeClosed);
                          });
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              decoration: BoxDecoration(
                                color: blackColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.access_time_sharp,color: Colors.white,),
                                    Text(storeController.isClose.value==false?
                                    hours==0?" Closed in $minutes m"
                                        :"Close in $hours h: $minutes":"Closed",style: GoogleFonts.aBeeZee(
                                        fontSize: 15, fontWeight: FontWeight.normal,color: Colors.white)),
                                  ],
                                ),
                            ),Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(
                                color: blackColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on_rounded,color: Colors.white,),
                                    Text(" 15 min to pick up",style: GoogleFonts.aBeeZee(
                                        fontSize: 15, fontWeight: FontWeight.normal,color: Colors.white)),
                                  ],
                                ),
                              ),
                          ],
                        );
                      }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 0),
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryItem.length,
                        itemBuilder: (context, index) {
                          return CategoryMenu(
                            selected: selectedCategory,
                            position: index,
                            categoryItem: categoryItem[index],
                            categoryPressed: () {
                              setState(() {
                                selectedCategory = index;
                              });
                              setCategoryItem();
                            },
                          );
                        },
                      ),
                    ),
                    StreamBuilder(
                      stream: DatabaseServices.getMenuSnapshot(query),
                      builder: (context, snapshot) {
                        print(storeController.total.toString());
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        return SizedBox(
                          width: screenSize.width,
                          height: screenSize.height * 0.70,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return ItemCard(
                                  screenSize: screenSize,
                                  itemName: snapshot.data.docs[index]['menu_name'],
                                  itemPrice: snapshot.data.docs[index]['price'].toString(),
                                  imagePath: snapshot.data.docs[index]['picture'],
                                  buttonPress: () async {
                                    Get.toNamed(AppRoutes.details,arguments: snapshot.data.docs[index].id);
                                  }, cartButton: () async{
                                DatabaseServices services = DatabaseServices();
                                // add item to cart
                                String result = await services.addToCart(
                                    snapshot.data.docs[index].id, 1);

                                if (result == 'fail!') {
                                  Get.snackbar(
                                      'Item already in cart!!', "Item Founded",
                                      colorText: Colors.white,
                                      backgroundColor: Colors.blue,
                                      icon: const Icon(
                                          Icons.info));
                                }else
                                if (result != 'success') {
                                  Get.snackbar(
                                      'Oops something when wrong', result,
                                      colorText: Colors.white,
                                      backgroundColor: Colors.red,
                                      icon: const Icon(
                                          Icons.warning_rounded));
                                }
                                else {
                                  Get.snackbar(
                                      'Success', 'Success add item to cart',
                                      colorText: Colors.white,
                                      backgroundColor: Colors.green,
                                      icon: const Icon(Icons.check_circle));
                                }
                                  },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}