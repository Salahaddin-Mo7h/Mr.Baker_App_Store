
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mr_baker/controllers/auth_controller.dart';
import 'package:mr_baker/core/color.dart';
import 'package:mr_baker/views/routes/routes.dart';
import 'package:mr_baker/views/widgets/auth_form_field.dart';
import 'package:mr_baker/views/widgets/google_button.dart';
import 'package:mr_baker/views/widgets/orange_button.dart';

class LoginPage extends GetView<AuthController> {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = Get.size;
    return Obx(() => Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: SingleChildScrollView(
            child: Container(
              width: screenSize.width,
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: screenSize.height * 0.03),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: greyColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenSize.height * 0.04),
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.015),
                  GoogleButton(
                    screenSize: screenSize,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenSize.height * 0.04, top: screenSize.height * 0.03),
                    alignment: Alignment.center,
                    child: Text(
                      'OR LOG IN WITH EMAIL',
                      style: TextStyle(
                        color: greyTextColor,
                      ),
                    ),
                  ),
                  AuthFormField(
                    inputType: TextInputType.emailAddress,
                    screenSize: screenSize,
                    hintText: 'Email address',
                    textController: emailController,
                  ),
                  AuthFormField(
                    inputType: TextInputType.text,
                    isPassword: true,
                    screenSize: screenSize,
                    hintText: 'Password',
                    textController: passwordController,
                  ),
                  SizedBox(height: screenSize.height * 0.04),
                  OrangeButton(
                    screenSize: screenSize,
                    buttonText: 'Login',
                    buttonPress: () async {
                      controller.isLoading.value = true;
                      String result = await controller.loginWithEmailandPassword(emailController.text, passwordController.text);
                      if (result != 'success') {
                        controller.isLoading.value = false;
                        Get.snackbar('Oops Something went wrong', result, colorText: Colors.white, backgroundColor: Colors.red);
                      } else {
                        Get.toNamed(AppRoutes.home);
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenSize.height * 0.16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('ALREADY HAVE AN ACCOUNT? '),
                        TextButton(
                          onPressed: () => Get.toNamed(AppRoutes.register),
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(color: orangeColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
