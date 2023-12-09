import 'dart:ui';

import 'package:babylid/utils/appcolors.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    this.currentIndex = 0,
    required this.homePressed,
    required this.addPressed,
    required this.milestonePressed,
  }) : super(key: key);

  final int currentIndex;
  final VoidCallback homePressed;
  final VoidCallback addPressed;
  final VoidCallback milestonePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.fadedBlack,
      constraints: BoxConstraints(
        maxHeight: 60.h + (MediaQuery.of(context).padding.bottom / 2),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
              bottom: (MediaQuery.of(context).padding.bottom / 2),
            ),
            width: double.infinity,
            alignment: Alignment.center,
            decoration:
                const BoxDecoration(color: AppColors.fadedBlack, boxShadow: [
              BoxShadow(
                offset: Offset(1, 0),
                blurRadius: 5,
                spreadRadius: 1,
                color: AppColors.subBlack,
              )
            ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: BottomBarIcons(
                        index: 0,
                        text: "Home",
                        onTap: homePressed,
                        currentIndex: currentIndex,
                        bulk: "assets/image/nav_icons/home_bulk.png",
                        line: "assets/image/nav_icons/home_line.png",
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: BottomBarIcons(
                        index: 1,
                        text: "More",
                        onTap: milestonePressed,
                        currentIndex: currentIndex,
                        bulk: "assets/image/nav_icons/milestone_bulk.png",
                        line: "assets/image/nav_icons/milestone_line.png",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: addPressed,
            child: BottomBarFloatingButton(
              actionTabButtonWidth: 65.w,
              actionTabButtonHeight: 65.h,
            ),
          )
        ],
      ),
    );
  }
}

class BottomBarFloatingButton extends StatelessWidget {
  const BottomBarFloatingButton({
    Key? key,
    required this.actionTabButtonWidth,
    required this.actionTabButtonHeight,
  }) : super(key: key);

  final double actionTabButtonWidth;
  final double actionTabButtonHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: .4,
      child: Container(
        width: actionTabButtonWidth,
        height: actionTabButtonHeight,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(5, 5),
              blurRadius: 5,
              color: Colors.white.withOpacity(0.20),
              inset: true,
            ),
            const BoxShadow(
              offset: Offset(-5, -5),
              blurRadius: 5,
              color: Colors.white,
              inset: true,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xffdadfe7).withOpacity(0.20),
                    const Color(0xfff5f5f9).withOpacity(0.20),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 5),
                    blurRadius: 12,
                    color: const Color(0xff8e9bae).withOpacity(0.10),
                  )
                ],
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Colors.white,
                        Color(0xffaeaeae),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 9),
                        blurRadius: 18,
                        color: const Color(0xff8e9bae).withOpacity(0.20),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 7.h,
                      height: 7.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.blue,
                            AppColors.orange,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(5, 5),
                            blurRadius: 5,
                            color: Colors.white,
                            inset: true,
                          ),
                          BoxShadow(
                            offset: Offset(-5, -5),
                            blurRadius: 5,
                            color: Colors.white,
                            inset: true,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 5.h,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: AppColors.subWhite.withOpacity(.8),
                            shape: BoxShape.circle,
                          ),
                          child: ShaderMask(
                            blendMode: BlendMode.srcATop,
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                AppColors.blue,
                                AppColors.orange,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBarIcons extends StatelessWidget {
  const BottomBarIcons({
    Key? key,
    required this.index,
    required this.bulk,
    required this.line,
    required this.text,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  final int index;
  final String bulk;
  final String line;
  final String text;
  final int currentIndex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 35.h,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Image.asset(
          currentIndex == index ? bulk : line,
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill;

    paint0.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.subBlue,
        AppColors.white,
      ],
    ).createShader(rect);

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.quadraticBezierTo(size.width * 0.0446963, size.height * 0.2137647,
        size.width * 0.1357944, size.height * 0.3016471);
    path0.cubicTo(
        size.width * 0.3641121,
        size.height * 0.3985882,
        size.width * 0.6546028,
        size.height * 0.3976471,
        size.width * 0.8687150,
        size.height * 0.2972941);
    path0.quadraticBezierTo(size.width * 0.9284579, size.height * 0.2695882,
        size.width, size.height * 0.0038824);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
