

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mr_baker/views/routes/routes.dart';

 // default image for items
String defaultPhoto = 'https://firebasestorage.googleapis.com/v0/b/shop-de183.appspot.com/o/user%2FphotoDefault.png?alt=media&token=6991c172-aa68-493b-a52f-68b91a186310';
// global variable to store users ids
String userUid = FirebaseAuth.instance.currentUser!.uid;

 String query = "";

List<String> categoryItem = ['All', 'Category 1', 'Category 2', 'Category 3'];
int selectedMenuItem = 0;
int selectedCategory = 0;


// this method for inquring items category in firestore
setCategoryItem() {
  switch (selectedCategory) {
    case 0:
      query = "";
      break;
    case 1:
      query = 'category1';
      break;
    case 2:
      query = 'category2';
      break;
    case 3:
      query = 'category3';
      break;
  }
}
