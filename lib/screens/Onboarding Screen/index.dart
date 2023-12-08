import 'package:babylid/screens/AddBaby%20Screen/add_baby.dart';
import 'package:babylid/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  late PageController _imagePageController;
  late PageController _textPageController;

  @override
  void initState() {
    super.initState();

    _imagePageController = PageController(initialPage: 0, viewportFraction: 1);
    _textPageController = PageController(initialPage: 0)
      ..addListener(_onMainScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _imagePageController.dispose();
    _textPageController.dispose();
  }

  void change(int value) {
    setState(() {
      _currentPage = value;
    });
  }

  _goToPage(int page) {
    _imagePageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInCirc);
    _textPageController.animateToPage(page,
        duration: const Duration(milliseconds: 100), curve: Curves.easeInCirc);
  }

  _onMainScroll() {
    _imagePageController.animateTo(_textPageController.offset,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInCirc);
  }

  List<Map<String, dynamic>> onBoardingText = [
    {
      "image": "assets/image/baby1.png",
      "title": "Track Everything!",
      "subtitle":
          "Hundreds of activities for physical, Cognitive\nSpeech and Social-Emotional Development",
    },
    {
      "image": "assets/image/baby2.png",
      "title": "Stimulate Growth!",
      "subtitle":
          "See your baby's milestone achievements & Plans \n to boost the development process",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.black,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                onPageChanged: change,
                controller: _imagePageController,
                allowImplicitScrolling: true,
                scrollDirection: Axis.horizontal,
                itemCount: onBoardingText.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxHeight: 600.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                          image: AssetImage(
                            onBoardingText[index]["image"],
                          ),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            20.height,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onBoardingText.length,
                  (indexDots) {
                    return AnimatedContainer(
                      margin: EdgeInsets.only(right: 5.w),
                      width: _currentPage == indexDots ? 25.w : 7.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _currentPage == indexDots
                            ? AppColors.orange
                            : AppColors.subBlack,
                      ),
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              ),
            ),
            55.height,
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  SizedBox(
                    height: 150.h,
                    child: PageView.builder(
                      onPageChanged: change,
                      controller: _textPageController,
                      allowImplicitScrolling: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: onBoardingText.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                onBoardingText[index]["title"].toString(),
                                maxLines: 1,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 38.sp,
                                  shadows: const [
                                    BoxShadow(
                                      offset: Offset(-1, 1),
                                      blurRadius: 10,
                                      color: AppColors.white,
                                    )
                                  ],
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              20.height,
                              Text(
                                onBoardingText[index]["subtitle"].toString(),
                                maxLines: 2,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  height: 1.6,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey1,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  10.height,
                  if (_currentPage != onBoardingText.length - 1)
                    Button(
                      onPress: () {
                        _goToPage(_currentPage + 1);
                      },
                      text: "Next",
                    ),
                  if (_currentPage == onBoardingText.length - 1)
                    Button(
                      onPress: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AddBaby.routeName);
                      },
                      text: "Get Started",
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPress,
    required this.text,
  });

  final VoidCallback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.orange,
      borderRadius: BorderRadius.circular(20),
      elevation: 4,
      child: InkWell(
        onTap: onPress,
        splashColor: AppColors.black.withOpacity(.2),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 250.w,
          height: 60.h,
          alignment: Alignment.center,
          child: Text(
            text,
            maxLines: 1,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              shadows: [
                BoxShadow(
                  offset: const Offset(-1, 1),
                  blurRadius: 10,
                  color: AppColors.white.withOpacity(.5),
                )
              ],
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
