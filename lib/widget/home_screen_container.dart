import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/constant_colors.dart';

class HomeScreenContainer extends StatelessWidget {
  final String image;
  final String text;

  const HomeScreenContainer({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 131.5,
      width: 171,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: ConstantColors.assentBgTextAndBorder01,
          borderRadius: BorderRadius.circular(10.4),
          border: Border.all(color: ConstantColors.assentBgTextAndBorder01, width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar( backgroundColor: ConstantColors.assentBgTextAndBorder03, child: SvgPicture.asset(image)),
          Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.interTight(
                    textStyle: TextStyle(color: ConstantColors.assentBgTextAndBorder05, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SvgPicture.asset(
                "assets/icons/border/right_line.svg",
                // ignore: deprecated_member_use
                color: ConstantColors.assentBgTextAndBorder04,
              ),
            ],
          )
        ],
      ),
    );
  }
}
