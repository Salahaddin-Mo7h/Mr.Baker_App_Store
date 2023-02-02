import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class StoreClosed extends StatefulWidget {
   const StoreClosed({Key? key}) : super(key: key);

  @override
  _StoreClosedState createState() => _StoreClosedState();
}

class _StoreClosedState extends State<StoreClosed>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.stop();
        }
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments;
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFFF4B3A),
      body: SafeArea(
        child: SizedBox(
          width: we,
          height: he,
          child: Column(
            children: [
              Lottie.network("https://assets1.lottiefiles.com/packages/lf20_kznecnqj/data.json",
                  width: 300),
              SizedBox(
                height: he * 0.03,
              ),
              FadeIn(
                delay: const Duration(milliseconds: 600),
                child: Center(
                  child: Text(
                    "Hey Dears Our Time is Up",
                    style: GoogleFonts.lato(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeIn(
                delay: const Duration(milliseconds: 800),
                child: const Center(
                  child: Text(
                      'Thank you for Being our customers ❤'),
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeIn(
                delay: const Duration(milliseconds: 800),
                child:  Center(
                  child: Text(
                      ' We will get back to you in tomorrow at', style: GoogleFonts.lato(
                        fontSize: 16, fontWeight: FontWeight.normal)),
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeIn(
                delay:  Duration(milliseconds: 800),
                child:  Center(
                  child: Text("10:00 AM",style: GoogleFonts.aBeeZee(
                      fontSize: 26, fontWeight: FontWeight.normal)),
                ),
              ),
              SizedBox(
                height: he * 0.23,
              ),
              FadeIn(
                  delay: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          await SystemNavigator.pop();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFFF8B3A),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 150)),
                        child: FadeIn(
                          delay: const Duration(milliseconds: 1200),
                          child:  Text(
                            "See You :)",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 26, fontWeight: FontWeight.normal)),
                          ),
                        )),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
