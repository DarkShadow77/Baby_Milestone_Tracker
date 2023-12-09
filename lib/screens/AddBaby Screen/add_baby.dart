import 'package:babylid/models/account.dart';
import 'package:babylid/screens/Main%20Screen/mainScreen.dart';
import 'package:babylid/screens/account_provider.dart';
import 'package:babylid/utils/appcolors.dart';
import 'package:babylid/widgets/textfields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AddBaby extends StatefulWidget {
  const AddBaby({super.key});

  static const routeName = "/add_baby";

  @override
  State<AddBaby> createState() => _AddBabyState();
}

class _AddBabyState extends State<AddBaby> {
  final _nameController = TextEditingController();

  late FocusNode _nodeName;

  int genderValue = 0;
  int relationshipValue = 0;

  bool nameFocused = false;
  bool nameError = false;
  bool dateError = false;
  bool relationshipError = false;

  String name = "";
  String date = "Baby's Birth Date";
  late DateTime dateInput;

  Future _add() async {
    name = _nameController.text.trim();

    setState(() {
      nameError = name.length < 3 ? true : false;
      dateError = date == "Baby's Birth Date" ? true : false;
      relationshipError = relationshipValue == 0 ? true : false;
    });
    if (nameError == false &&
        dateError == false &&
        relationshipError == false) {
      Provider.of<UserProvider>(context, listen: false).saveUser(
        BabyAccount(
          name: name,
          gender: genderValue,
          relationship: relationshipValue,
          dateOfBirth: dateInput,
        ),
      );
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    }
  }

  void _handleFocusChange() {
    name = _nameController.text.trim();

    if (_nodeName.hasFocus != nameFocused) {
      setState(() {
        nameFocused = _nodeName.hasFocus;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nodeName = FocusNode(debugLabel: 'Name');
    _nodeName.addListener(_handleFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Add Baby",
                softWrap: true,
                style: TextStyle(
                  fontSize: 38.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              30.height,
              Text(
                "Record your baby's every growing moment",
                softWrap: true,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey03,
                ),
              ),
              30.height,
              RefillTextField(
                focused: nameFocused,
                error: nameError,
                node: _nodeName,
                number: false,
                textInputType: TextInputType.name,
                controller: _nameController,
                hintText: "Baby's first Name",
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  nameError = value.length < 3 ? true : false;
                },
              ),
              if (nameError) ...[
                15.height,
                Text(
                  "Enter a min. of 2 Char.",
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.red,
                  ),
                ),
              ],
              20.height,
              RefillDropdown(
                text: date,
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2004, 12, 31),
                    maxTime: DateTime.now(),
                    onChanged: (date) {
                      if (kDebugMode) {
                        print('change $date');
                      }
                    },
                    onConfirm: (dateInputs) {
                      if (kDebugMode) {
                        print('confirm $dateInputs');
                      }
                      setState(() {
                        dateInput = dateInputs;
                        date = DateFormat('EEEE, MMMM d, y').format(dateInputs);
                        dateError = date == "Baby's Birth Date" ? true : false;
                      });
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en,
                    theme: DatePickerTheme(
                      headerColor: AppColors.subBlack,
                      backgroundColor: AppColors.black,
                      itemStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                      cancelStyle: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey1,
                      ),
                      doneStyle: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey1,
                      ),
                    ),
                  );
                },
              ),
              if (dateError) ...[
                15.height,
                Text(
                  "Select a Date of Birth",
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.red,
                  ),
                ),
              ],
              30.height,
              Text(
                "Gender",
                softWrap: true,
                style: TextStyle(
                  color: AppColors.subWhite4,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              15.height,
              Row(
                children: [
                  genderButton(text: "Male", index: 0),
                  20.width,
                  genderButton(text: "Female", index: 1),
                  20.width,
                  genderButton(text: "Other", index: 2),
                ],
              ),
              30.height,
              Text(
                "Relationship with this Baby",
                softWrap: true,
                style: TextStyle(
                  color: AppColors.subWhite4,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              15.height,
              Row(
                children: [
                  relationshipButton("Mom", 1),
                  20.width,
                  relationshipButton("Dad", 2),
                  20.width,
                  relationshipButton("Other", 3),
                ],
              ),
              if (relationshipError) ...[
                15.height,
                Text(
                  "Choose a Relationship",
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.red,
                  ),
                ),
              ],
              60.height,
              Button(
                onPress: () {
                  _add();
                },
                text: "Add",
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget genderButton({required String text, required int index}) {
    return Expanded(
      child: Material(
        color: (genderValue == index) ? AppColors.orange : AppColors.subBlack,
        borderRadius: BorderRadius.circular(20),
        elevation: 4,
        child: InkWell(
          onTap: () {
            setState(() {
              genderValue = index;
            });
          },
          splashColor: AppColors.black.withOpacity(.2),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 40.h,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (index == 0) ...[
                  Icon(
                    MdiIcons.genderMale,
                    size: 18.sp,
                    color: AppColors.grey1,
                  ),
                  3.width,
                ],
                if (index == 1) ...[
                  Icon(
                    MdiIcons.genderFemale,
                    size: 18.sp,
                    color: AppColors.grey1,
                  ),
                  3.width,
                ],
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget relationshipButton(String text, int index) {
    return Expanded(
      child: Material(
        color: (relationshipValue == index)
            ? AppColors.orange
            : AppColors.subBlack,
        borderRadius: BorderRadius.circular(20),
        elevation: 4,
        child: InkWell(
          onTap: () {
            setState(() {
              relationshipValue = index;
              relationshipError = relationshipValue == 0 ? true : false;
            });
          },
          splashColor: AppColors.black.withOpacity(.2),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 40.h,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
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
