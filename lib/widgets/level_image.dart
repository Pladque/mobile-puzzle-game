import 'package:flutter/material.dart';

class LevelImage extends StatelessWidget {
  final String imageDir;
  final double heightDivider;
  final double widthDivider;

  const LevelImage(this.imageDir, this.heightDivider, this.widthDivider,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 45),
        height: MediaQuery.of(context).size.height / heightDivider,
        width: MediaQuery.of(context).size.width / widthDivider,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.color),
            image: AssetImage(
              imageDir,
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
