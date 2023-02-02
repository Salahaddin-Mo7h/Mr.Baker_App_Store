

import 'package:get/get.dart';
import 'package:mr_baker/controllers/auth_controller.dart';
import 'package:mr_baker/controllers/firestore_services.dart';

// this method responsible form initialize our controllers
Future<void> init() async{
  Get.lazyPut(() => DatabaseServices());
  Get.lazyPut(() => AuthController());
}