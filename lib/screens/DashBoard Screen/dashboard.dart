import 'package:age_calculator/age_calculator.dart';
import 'package:babylid/main.dart';
import 'package:babylid/screens/Milestones/provider.dart';
import 'package:babylid/screens/account_provider.dart';
import 'package:babylid/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  static const routeName = "/dashboard";

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int weight = prefs.getInt("weight") ?? 0;
  int height = prefs.getInt("height") ?? 0;

  late DateDuration durations;

  void calculateAge(DateTime birthDate) {
    durations = AgeCalculator.age(birthDate, today: DateTime.now());
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).loadUser();
      Provider.of<MilestoneProvider>(context, listen: false).fetchMilestones();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    DateTime date = userProvider.dob!;

    calculateAge(userProvider.dob!);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                30.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 65.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2.sp,
                          color: AppColors.orange,
                        ),
                        color: AppColors.black,
                        image: DecorationImage(
                          image: AssetImage(userProvider.gender == 0
                              ? "assets/image/male.png"
                              : userProvider.gender == 1
                                  ? "assets/image/female.png"
                                  : "assets/image/neutral.png"),
                        ),
                      ),
                    ),
                    15.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${date.day}.${date.month}.${date.year}",
                            softWrap: true,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.grey03,
                            ),
                          ),
                          10.height,
                          Text(
                            userProvider.name.capitalizeFirstLetter(),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    15.width,
                    Image.asset(
                      "assets/image/icons/notification.png",
                      width: 25.w,
                    ),
                    20.width,
                    Image.asset(
                      "assets/image/icons/settings.png",
                      width: 25.w,
                    ),
                  ],
                ),
                Container(
                  height: 100.h,
                  margin: EdgeInsets.symmetric(vertical: 30.h),
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
                  decoration: BoxDecoration(
                      color: AppColors.subOrange,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.grey1,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            if (durations.years != 0) ...[
                              Text(
                                "${durations.years}",
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 70.sp,
                                  color: AppColors.subWhite2,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              6.width,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "years",
                                    softWrap: true,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.subWhite2,
                                    ),
                                  ),
                                  5.height,
                                  if (durations.months != 0) ...[
                                    Text(
                                      "${durations.months} months",
                                      softWrap: true,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.subWhite2,
                                      ),
                                    )
                                  ] else if (durations.days != 0) ...[
                                    Text(
                                      "${durations.days} days",
                                      softWrap: true,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.subWhite2,
                                      ),
                                    ),
                                  ]
                                ],
                              )
                            ] else if (durations.months != 0) ...[
                              Text(
                                "${durations.months}",
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 70.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              6.width,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "months",
                                    softWrap: true,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.subWhite2,
                                    ),
                                  ),
                                  5.height,
                                  if (durations.days != 0)
                                    Text(
                                      "${durations.days} days",
                                      softWrap: true,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.subWhite2,
                                      ),
                                    ),
                                ],
                              )
                            ] else if (durations.days != 0) ...[
                              Text(
                                "${durations.days}",
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 70.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              6.width,
                              Text(
                                "days",
                                softWrap: true,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.subWhite2,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 25.h,
                                  width: 25.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1.5,
                                      color: AppColors.subWhite2,
                                    ),
                                  ),
                                  child: Center(
                                    child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        Ionicons.barbell,
                                        color: AppColors.subWhite2,
                                        size: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                10.width,
                                Text(
                                  "Height ",
                                  softWrap: true,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppColors.subWhite2,
                                  ),
                                ),
                                Text(
                                  "${height}cm",
                                  softWrap: true,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.subWhite2,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 25.h,
                                  width: 25.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1.5,
                                      color: AppColors.subWhite2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Ionicons.barbell,
                                      color: AppColors.subWhite2,
                                      size: 14.sp,
                                    ),
                                  ),
                                ),
                                10.width,
                                Text(
                                  "Weight ",
                                  softWrap: true,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppColors.subWhite2,
                                  ),
                                ),
                                Text(
                                  "${weight}kg",
                                  softWrap: true,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.subWhite2,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
              decoration: const BoxDecoration(
                color: AppColors.fadedBlack,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 5.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: AppColors.subOrange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  30.height,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(4, 4),
                                color: AppColors.white,
                              )
                            ],
                          ),
                          child: Material(
                            color: const Color(0xff91b187),
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                              onTap: () {},
                              splashColor: AppColors.black.withOpacity(.2),
                              borderRadius: BorderRadius.circular(15),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "+ ",
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: "Edit Height",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      20.width,
                      Expanded(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(-4, -4),
                                color: AppColors.white,
                              )
                            ],
                          ),
                          child: Material(
                            color: const Color(0xff53331f),
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                              onTap: () {},
                              splashColor: AppColors.black.withOpacity(.2),
                              borderRadius: BorderRadius.circular(15),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "+ ",
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: "Edit Weight",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 175.h,
                    margin: EdgeInsets.symmetric(vertical: 30.h),
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: const Color(0xff483285),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 175.h,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/image/bg_baby.png"),
                              ),
                            ),
                          ),
                        ),
                        15.width,
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.white.withOpacity(.3),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Tips",
                                          softWrap: true,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.grey1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(),
                                  )
                                ],
                              ),
                              Text(
                                "Newborn Baby Care Advice & Tips",
                                softWrap: true,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  height: 1.5,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.subWhite2,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Learn More",
                                          softWrap: true,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.fadedBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  /*Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xff483285),
                            ),
                          ),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text: "+ ",
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Edit Height",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      8.width,
                      Expanded(
                        child: Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xff91b187),
                            ),
                          ),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text: "+ ",
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Edit Height",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      8.width,
                      Expanded(
                        child: Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1,
                                color: const Color(0xff53331f),
                              )),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text: "+ ",
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Edit Height",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
