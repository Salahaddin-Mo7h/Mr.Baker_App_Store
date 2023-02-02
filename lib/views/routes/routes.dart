import 'package:get/get.dart';
import 'package:mr_baker/views/cart.dart';
import 'package:mr_baker/views/detail_page.dart';
import 'package:mr_baker/views/home.dart';
import 'package:mr_baker/views/login.dart';
import 'package:mr_baker/views/profile_page.dart';
import 'package:mr_baker/views/register.dart';
import 'package:mr_baker/views/splash.dart';
import 'package:mr_baker/views/widgets/closed_widget.dart';
import 'package:mr_baker/views/wishlist_page.dart';

// this class responsible from managing routing in app
class AppRoutes {
  static String splash = "/splash";
  static String home = "/home";
  static String profile = "/profile";
  static const String login = "/login";
  static const String wishList = "/wishlist";
  static const String details = "/details";
  static const String register ="/register";
  static const String cart = "/cart";
  static const String storeClosed = "/storeClosed";

  static String getSplash() => splash;
  static String getHome()=> home;
  static String getProfile()=> profile;
  static String getWishList()=> wishList;
  static String getDetails()=> details;
  static String getLogin() => login;
  static String getStoreClosed() => storeClosed;
  static String getRegister() => register;
  static String getCart() => cart;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () =>  SplashPage()),
    GetPage(name: home, page: ()=>  const HomePage()),
    GetPage(name: details, page: ()=>  DetailPage()),
    GetPage(name: login, page: () =>  LoginPage()),
    GetPage(name: wishList, page: () =>  const WishListPage()),
    GetPage(name: profile, page: () =>  const ProfilePage()),
    GetPage(name: register, page: ()=> RegisterPage()),
    GetPage(name: cart, page: () =>  const CartPage()),
    GetPage(name: storeClosed, page: () =>   StoreClosed())
  ];
}
