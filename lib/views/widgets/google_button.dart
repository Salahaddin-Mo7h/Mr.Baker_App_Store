import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mr_baker/core/color.dart';


class GoogleButton extends StatelessWidget {
  const GoogleButton({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Container(
        width: screenSize.width,
        height: 60,
        padding: const EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38),
          border: Border.all(color: greyColor, width: 3),
        ),
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/google logo.svg'),
            const SizedBox(width: 30.0),
            Text(
              'CONTINUE WITH GOOGLE',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
