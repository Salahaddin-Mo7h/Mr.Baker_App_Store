import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_baker/controllers/firestore_services.dart';
import 'package:mr_baker/core/color.dart';
import 'package:mr_baker/views/routes/routes.dart';

class MenuCard extends StatefulWidget {
  const MenuCard({
    Key? key,
    required this.screenSize,
    required this.menuItem,
    required this.documentType,
    this.amount,
  }) : super(key: key);

  final Size screenSize;
  final String documentType;
  final menuItem;
  final int? amount;

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  int menuAmount = 0;
  final services = Get.put(DatabaseServices());
  @override
  Widget build(BuildContext context) {
    menuAmount = widget.amount??0;
    String menuItem = widget.menuItem;
    return FutureBuilder(
      future: DatabaseServices.detailMenu(menuItem),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.details, arguments: snapshot.data!.id);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 20.0),
              width: widget.screenSize.width,
              height: widget.screenSize.height * 0.17,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network(
                        snapshot.data!['picture'],
                        width: 80.0,
                        height: 80.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!['menu_name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'KWD ${snapshot.data!['price'].toString()}',
                          style: TextStyle(
                            color: orangeColor,
                          ),
                        ),
                        (widget.documentType == 'orders')
                            ? Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    color: orangeColor,
                                  ),
                                  onPressed: () async {
                                    if(menuAmount<2){
                                     await services.removeFromCart(snapshot.data!.id);
                                     services.getItemCounts();
                                    }else{
                                      setState(() {
                                      menuAmount -= 1;
                                    });
                                      var result = await services.addItemToCart(menuItem, menuAmount);
                                      if (result != 'success') {
                                        print('success');
                                      }
                                    }
                                  },
                                ),
                                Text(menuAmount.toString()),
                                IconButton(
                                  icon: Icon(Icons.add, color: orangeColor),
                                  onPressed: () async {
                                    setState(() {
                                      menuAmount += 1;
                                    });
                                    var result = await services.addItemToCart(menuItem, menuAmount);
                                    if (result != 'success') {
                                      print('success');
                                    }
                                  },
                                ),
                              ],
                            )
                            : Container(),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: widget.documentType == 'history'
                          ? null
                          : IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          String result;
                          if (widget.documentType == 'wishlist') {
                            result = await DatabaseServices.removeFromWishList(snapshot.data!.id);
                          } else {
                            result = await services.removeFromCart(snapshot.data!.id);
                          }
                          if (result != 'success') {
                            Get.snackbar('Oops something went wrong', result, colorText: Colors.white, backgroundColor: Colors.red);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
