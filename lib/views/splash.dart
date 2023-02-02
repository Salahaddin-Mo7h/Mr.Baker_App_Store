
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_baker/controllers/auth_controller.dart';
import 'package:mr_baker/controllers/firestore_services.dart';
import 'package:mr_baker/views/routes/routes.dart';

class SplashPage extends StatefulWidget {
   SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;
  _loadData() async {
    AuthController authController = Get.put(AuthController());
    DatabaseServices services = Get.put(DatabaseServices());
  }

  @override
  void initState() {
    _loadData();
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1000))
      ..forward();

    animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

  }

  @override
  Widget build(BuildContext context) {
   _loadData();
    Size screenSize = Get.size;
    return Scaffold(
      backgroundColor: const Color(0xFFFF4B3A),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.15, vertical: screenSize.height * 0.1),
        child: Column(
          children: [
            FadeIn(
              delay: const Duration(milliseconds: 600),
              child: const Center(
                child: Text(
                  'Mr.Baker Store ',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                    color: Colors.white,
                  ),
              ),
            ),
            ),
            const SizedBox(height: 30,),
            FadeIn(
              delay: const Duration(milliseconds: 800),
              child: Center(
                child: Text(
                  "All your needs at your fingertips",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Spacer(),
            Lottie.network("https://assets4.lottiefiles.com/packages/lf20_fqqpimwi.json",
                  width: 500),
            SizedBox(height: screenSize.height * 0.05),
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.login);
              },
              child: Container(
                alignment: Alignment.center,
                width: screenSize.width,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Get started',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
