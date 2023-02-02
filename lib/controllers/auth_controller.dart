import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:mr_baker/core/constant.dart';
import 'package:mr_baker/views/routes/routes.dart';

class AuthController extends GetxController{

  // this class responsible from managing authentication process in application
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late Rx<User?> firebaseUser;
   RxBool isLoading  = false.obs;

   @override
   void onInit() {
     super.onInit();
     // auth is coming from the constants.dart file but it is basically FirebaseAuth.instance.
     // Since we have to use that many times I just made a constant file and declared there
     firebaseUser = Rx<User?>(_firebaseAuth.currentUser);
     firebaseUser.bindStream(_firebaseAuth.userChanges());
     ever(firebaseUser, setInitialScreen);
   }

   // this method responsible from checking if user at the initial screen already signed in app or not
  setInitialScreen(User? user) {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.toNamed(AppRoutes.splash);
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.toNamed(AppRoutes.home);
    }
   }

   // this part responsible form registering users in our app with a new account
   Future<String> signUpWithEmailandPassword(String email, String password, String name) async {
    try {
      isLoading.value  = true;
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _firebaseAuth.currentUser!.updateProfile(displayName: name, photoURL: defaultPhoto);
      await _firebaseFirestore.collection('users').doc(_firebaseAuth.currentUser!.uid).set({
        'displayName': _firebaseAuth.currentUser!.displayName,
        'address': '',
        'no_handphone': '',
        'wishlist': [],
        'orders': [],
        'history': [],
      });
      return 'registration success!';
    } catch (error) {
      print(error);
      isLoading.value  = false;
      return 'registration fail!';
    }
  }

   // this part responsible form granting registered users the permission to login into our app
   Future<String> loginWithEmailandPassword(String email, String password) async {
    try {
      isLoading.value  = true;
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } catch (error) {
      print(error);
      isLoading.value  = false;
      return 'fail!';
    }
  }

  // this method responsible form closing users sessions in our application
  Future<void> firebaseSignOut() async {
    await _firebaseAuth.signOut();
  }

}