import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mr_baker/core/color.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.screenSize,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.buttonPress,
    required this.cartButton,
  }) : super(key: key);

  final Size screenSize;
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final Function() cartButton;
  final Function() buttonPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonPress,
      child: Container(
        margin: const EdgeInsets.only(top: 80, left: 15.0),
        height: screenSize.height * 0.4,
        width: screenSize.width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: screenSize.width * 0.90,
              height: screenSize.height * 0.37,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 10,
              top: -60,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: screenSize.height * 0.3,
                width: screenSize.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  // child: Image.network(
                  //   imagePath,
                  //   fit: BoxFit.cover,
                  // ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imagePath,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: -130,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: screenSize.height * 0.3,
                width: screenSize.width * 0.5,
                child: Column(
                  children: [
                    Text(
                      itemName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'KWD $itemPrice',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: screenSize.width * 0.7,
              right: screenSize.width * 0.2,
              child: const Text("Description"),
            ),
            // plus_svg
            Positioned(
                bottom: screenSize.width * 0.2,
                right: screenSize.width * 0.2,
                child: InkWell(
                  onTap: cartButton,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/plus_svg.svg',
                      color: orangeColor,
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
