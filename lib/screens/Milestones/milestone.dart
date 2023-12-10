import 'package:age_calculator/age_calculator.dart';
import 'package:babylid/screens/Milestones/provider.dart';
import 'package:babylid/screens/Milestones/view_milestone.dart';
import 'package:babylid/screens/account_provider.dart';
import 'package:babylid/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class Milestone extends StatefulWidget {
  const Milestone({super.key});

  @override
  State<Milestone> createState() => _MilestoneState();
}

class _MilestoneState extends State<Milestone>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late DateDuration durations;

  void calculateAge(DateTime birthDate) {
    durations = AgeCalculator.age(birthDate, today: DateTime.now());
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).loadUser();
      Provider.of<MilestoneProvider>(context, listen: false).fetchMilestones();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final milestonesList = Provider.of<MilestoneProvider>(context).milestones;

    DateTime birthDate = userProvider.dob!;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            30.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 45.w,
                  height: 45.h,
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
                  child: Center(
                    child: Text(
                      "${userProvider.name.capitalizeFirstLetter()}'s Milestones",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                15.width,
                Image.asset(
                  "assets/image/icons/notification.png",
                  width: 25.w,
                ),
              ],
            ),
            30.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "My Milestones",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: AppColors.subWhite4,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/image/icons/search.png",
                      width: 25.w,
                    ),
                    20.width,
                    Image.asset(
                      "assets/image/icons/filter.png",
                      width: 25.w,
                    ),
                  ],
                ),
              ],
            ),
            10.height,
            Expanded(
              child: milestonesList.isEmpty
                  ? NoDataWidget(
                      controller: controller,
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      physics: const BouncingScrollPhysics(),
                      itemCount: milestonesList.length,
                      itemBuilder: (context, index) {
                        DateTime date = milestonesList[index].date;
                        durations = AgeCalculator.age(birthDate, today: date);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ViewMilestoneScreen(index: index),
                              ),
                            );
                          },
                          child: Container(
                            height: 100.h,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 20.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                            decoration: BoxDecoration(
                                color: AppColors.fadedBlack,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.grey02,
                                    offset: Offset(1, 2),
                                    blurRadius: 3,
                                  )
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        milestonesList[index].type,
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      10.height,
                                      Text(
                                        milestonesList[index].notes,
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.subWhite4,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                20.width,
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (durations.years != 0) ...[
                                        Text(
                                          "${durations.years}",
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 50.sp,
                                            color: AppColors.subWhite4,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        6.width,
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "year",
                                              softWrap: true,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.subWhite4,
                                              ),
                                            ),
                                            5.height,
                                            if (durations.months != 0) ...[
                                              Text(
                                                "${durations.months} month",
                                                softWrap: true,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.subWhite4,
                                                ),
                                              ),
                                            ] else if (durations.days != 0) ...[
                                              Text(
                                                "${durations.days} day",
                                                softWrap: true,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.subWhite4,
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
                                            fontSize: 50.sp,
                                            color: AppColors.subWhite4,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        6.width,
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "month",
                                              softWrap: true,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.subWhite4,
                                              ),
                                            ),
                                            5.height,
                                            if (durations.days != 0)
                                              Text(
                                                "${durations.days} day",
                                                softWrap: true,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.subWhite4,
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
                                            fontSize: 50.sp,
                                            color: AppColors.subWhite4,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        6.width,
                                        Text(
                                          "day",
                                          softWrap: true,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.subWhite4,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/gif/no_datas.json",
              controller: controller,
              repeat: false,
              width: double.infinity.w,
              height: 200.h,
              onLoaded: (composition) {
                controller.duration = const Duration(seconds: 4);
                controller.forward();
              },
            ),
            20.height,
            Text(
              "No Milestone Found",
              maxLines: 1,
              softWrap: true,
              style: TextStyle(
                fontSize: 26.sp,
                color: AppColors.subWhite4,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
