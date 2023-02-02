import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mr_baker/core/constant.dart';
import 'package:mr_baker/models/stores.dart';

// this controller is responsible for managing firestore data like getting
// or adding items into cart also getting items details.

class DatabaseServices extends GetxController {

  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxInt total = 0.obs;
  RxList<int> items = <int>[].obs;
  RxBool exists = false.obs;
  RxInt itemCount = 0.obs;
  RxString time = "".obs;
  Timestamp? timestamp;
  Rx<Stores> stores = (Stores()).obs;
  RxInt hours = 0.obs;
  RxBool isClose = false.obs;
  @override
  void onInit() {
    getTotals();
    getItemCounts();
    getClosedTime();
    super.onInit();

  }
  // this part responsible form editing users addresses info
  static Future<String> editAddressDetail(String displayName, String address, String noHp) async {
    try {
      await firebaseFirestore.collection('users').doc(userUid).update({
        'displayName': displayName,
        'address': address,
        'no_handphone': noHp,
      });
      return 'success';
    } catch (error) {
      print(error);
      return Future.error(error);
    }
  }

  // this part responsible form getting menu items from firestore
  static Stream<dynamic> getMenuSnapshot(String query) {
    var snapshotCategory = firebaseFirestore.collection('menus').where('category', isEqualTo: query).snapshots();
    var snapshotAll = firebaseFirestore.collection('menus').snapshots();

    return (query == "") ? snapshotAll : snapshotCategory;
  }

  static Future<DocumentSnapshot> detailMenu(String menuId) async {
    try {
      var result = await firebaseFirestore.collection('menus').doc(menuId).get();
      return result;
    } catch (error) {
      print(error);
      return Future.error(error);
    }
  }
 // this part responsible form getting wishlist items in firestore
  static Stream<DocumentSnapshot> getUserWhislist() {
    var result = firebaseFirestore.collection('users').doc(userUid).snapshots();
    return result;
  }

  // this part responsible for adding items to user wishList
  static Future<String> addToWishList(String menuId) async {
    try {
      await firebaseFirestore.collection('users').doc(userUid).update({
        'wishlist': FieldValue.arrayUnion([menuId]),
      });
      return 'success';
    } catch (error) {
      print(error);
      return Future.error(error);
    }
  }

  // this part responsible for removing wishlist items from firestore
  static Future<String> removeFromWishList(String menuId) async {
    try {
      await firebaseFirestore.collection('users').doc(userUid).update({
        'wishlist': FieldValue.arrayRemove([menuId]),
      });
      return 'success';
    } catch (error) {
      print(error);
      return Future.error(error);
    }
  }

  // this part responsible form get user orders from firestore
   Stream<QuerySnapshot> getUserOrder() {
    var result = firebaseFirestore.collection('users').doc(userUid).collection('orders').snapshots();
    return result;
  }

  // this part responsible form add user items to cart
   Future<String> addToCart(String menuId, num amount) async {

    await firebaseFirestore.collection('users').doc(userUid).collection('orders')
         .doc('$menuId$userUid').get().then((value) => {
           if(value.exists){
             exists.value=true}else{
             exists.value=false}});
     if(exists.value==false){
       try {
         await firebaseFirestore.collection('users').doc(userUid).collection('orders').doc('$menuId$userUid').set({
           'userUid': userUid,
           'orders': menuId,
           'amount': amount,
         });
         getItemCounts();
         return 'success';
       } catch (error) {
         print(error);
         return Future.error(error);
       }
     }else{
       return 'fail!';
     }
  }

  // this part responsible form increment exist items in cart
  Future<String> addItemToCart(String menuId, num amount) async {
    try {
      await firebaseFirestore.collection('users').doc(userUid).collection('orders').doc('$menuId$userUid').set({
        'userUid': userUid,
        'orders': menuId,
        'amount': amount,
      });
      getItemCounts();
      return 'success';
    } catch (error) {
      print(error);
      return Future.error(error);
    }
  }


  // this part responsible form removing exist items in cart
   Future<String> removeFromCart(String menuId) async {
    try {
      await firebaseFirestore.collection('users').doc(userUid).collection('orders').doc(menuId+userUid).delete();
      return 'success';
    } catch (error) {
      print(error);
      return Future.error(error);
    }
  }


  //double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);

  // this part responsible form getting total of items that exist in cart
   Future<int> getTotals() async{
    firebaseFirestore.collection('users').doc(userUid).collection('orders').snapshots().forEach((element) {
        var items = element.docs;
        total.value = items.length;
    });
    return total.value;
  }

  // this part responsible form clear items that exist in cart
  Future<void> clearItems() async{
    firebaseFirestore.collection('users').doc(userUid).collection('orders').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
    }});
  }

  // this part responsible form getting opened and closed time of stores
  Future<Stores?> getClosedTime() async{
    Stores? store = Stores();
    var snapshot = await firebaseFirestore.collection('stores').doc('mr.baker').get();
    final data = snapshot.data() as Map<String, dynamic>;
    store.open_at = data['open_at'];
    store.close_at = data['close_at'];
    stores.value = store;
    return stores.value;
  }

  get store => getClosedTime();

  // this part responsible form counting amount of items that added into cart
  Future<int> getItemCounts() async {
    List markers = [];
    await firebaseFirestore.collection('users').doc(userUid).collection('orders').where('amount').get().then((querySnapshot) => {
      for (var doc in querySnapshot.docs) {
        // Rest of your code
        markers.add(doc.data()['amount']),
        itemCount.value = markers.reduce((value, element) => value+element),
      }
    });
    return itemCount.value;
  }
}
