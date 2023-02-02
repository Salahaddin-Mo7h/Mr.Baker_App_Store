import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mr_baker/controllers/auth_controller.dart';
import 'package:mr_baker/core/color.dart';
import 'package:mr_baker/views/routes/routes.dart';

class CutomDrawer extends StatelessWidget {
   CutomDrawer({
    Key? key,
    required this.screenSize,
  }) : super(key: key);
  final Size screenSize;
   int selectedMenuItem = 0;
   int selectedCategory = 0;
  List<String> menuItem = ['Home','Cart', 'Wishlist','Profile'];
   setPageTitle() {
     switch (selectedMenuItem) {
       case 0:
         Get.toNamed(AppRoutes.home);
         break;
       case 1:
         Get.toNamed(AppRoutes.cart);
         break;
       case 2:
         Get.toNamed(AppRoutes.wishList);
         break;
       case 3:
         Get.toNamed(AppRoutes.profile);
         break;
     }
   }
   List<String> menuIcon = ['assets/icons/home_svg.svg', 'assets/icons/cart.svg', 'assets/icons/heart.svg', 'assets/icons/user.svg'];
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: screenSize.height * 0.2, left: 15.0, bottom: screenSize.height * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: menuItem.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //navigate another page
                      selectedMenuItem = index;
                      setPageTitle();
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(menuIcon[index], color: Colors.white),
                              const SizedBox(width: 10.0),
                              Text(
                                menuItem[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 30.0),
                            width: screenSize.width * 0.3,
                            height: 1,
                            decoration: BoxDecoration(
                              color: greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await authController.firebaseSignOut();
              Get.offAllNamed(AppRoutes.splash);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: const [
                    Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                   SizedBox(width: 5.0),
                   Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
