import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mr_baker/views/routes/routes.dart';

import 'orange_button.dart';

class EmptyItemPage extends StatelessWidget {
  const EmptyItemPage({
    Key? key,
    required this.screenSize,
    required this.pageTitle,
    required this.imagePath,
  }) : super(key: key);

  final Size screenSize;
  final String pageTitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(width: screenSize.width * 0.22),
              Text(
                pageTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
            ],
          ),
          Column(
            children: [
              (imagePath.isEmpty || imagePath == '') ? Container() : SvgPicture.asset(imagePath),
              const SizedBox(height: 10.0),
              Text(
                'No $pageTitle yet',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Hit the orange button\ndown below to Create an order',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
          OrangeButton(
            screenSize: screenSize,
            buttonText: 'Start Ordering',
            buttonPress: () {
              Get.toNamed(AppRoutes.home);
            },
          )
        ],
      ),
    );
  }
}
