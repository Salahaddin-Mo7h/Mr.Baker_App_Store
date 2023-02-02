
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mr_baker/controllers/auth_controller.dart';
import 'package:mr_baker/core/color.dart';
import 'package:mr_baker/views/routes/routes.dart';
import 'package:mr_baker/views/widgets/auth_form_field.dart';
import 'package:mr_baker/views/widgets/google_button.dart';
import 'package:mr_baker/views/widgets/orange_button.dart';

class RegisterPage extends GetView<AuthController> {
   RegisterPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController nameController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
                      'Create your account',
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
                      'OR REGISTER IN WITH EMAIL',
                      style: TextStyle(
                        color: greyTextColor,
                      ),
                    ),
                  ),
                  AuthFormField(
                    inputType: TextInputType.name,
                    screenSize: screenSize,
                    hintText: 'Full Name',
                    textController: nameController,
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
                    buttonText: 'Register',
                    buttonPress: () async {
                      controller.isLoading.value = true;
                      if (passwordController.text.length < 6) {
                       controller.isLoading.value = false;
                        Get.snackbar('Oopss something went wrong', 'Password min 6 character', backgroundColor: Colors.red, colorText: Colors.white);
                      } else if (!emailController.text.contains('@') && emailController.text.length < 3) {
                        controller.isLoading.value = false;
                        Get.snackbar('Oopss something went wrong', 'Enter your correct email', backgroundColor: Colors.red, colorText: Colors.white);
                      } else if (nameController.text.length < 6) {
                        controller.isLoading.value = false;
                        Get.snackbar('Oopss something went wrong', 'Enter your correct name', backgroundColor: Colors.red, colorText: Colors.white);
                      } else if (!nameController.text.trim().contains(RegExp(r'^[a-zA-Z ]+$'))) {
                        print(nameController.text);
                        controller.isLoading.value = false;
                        Get.snackbar('Oopss something went wrong', 'Enter your correct name', backgroundColor: Colors.red, colorText: Colors.white);
                      } else {
                        String result = await controller.signUpWithEmailandPassword(emailController.text, passwordController.text, nameController.text);
                        if (result != 'registration fail!') {
                          controller.isLoading.value = false;
                          Get.snackbar('Oopss something went wrong', result, backgroundColor: Colors.red, colorText: Colors.white);
                        } else {
                          Get.offAllNamed(AppRoutes.home);
                        }
                      }
                    },
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
