import 'package:babylid/screens/AddBaby%20Screen/add_baby.dart';
import 'package:babylid/screens/Onboarding%20Screen/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (BuildContext context, Widget? child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        scrollBehavior:
            SBehavior().copyWith(physics: const BouncingScrollPhysics()),
        title: 'BabyLid',
        initialRoute: "/",
        routes: {
          "/": (ctx) => const OnBoardingScreen(),
          AddBaby.routeName: (ctx) => const AddBaby(),
        },
        // home: const AutoLoginWidget(),
      ),
    );
  }
}
