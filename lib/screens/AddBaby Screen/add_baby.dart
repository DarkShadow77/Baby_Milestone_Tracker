import 'package:babylid/utils/appcolors.dart';
import 'package:babylid/widgets/textfields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

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

  String name = "";
  String date = "Baby's Birth Date";

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
        child: Padding(
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
                  color: AppColors.grey1,
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
                    onConfirm: (dateInput) {
                      if (kDebugMode) {
                        print('confirm $date');
                      }
                      setState(() {
                        date = dateInput.toString();
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
                  relationshipButton("Male", 1),
                  20.width,
                  relationshipButton("Female", 2),
                  20.width,
                  relationshipButton("Other", 3),
                ],
              ),
              60.height,
              Button(
                onPress: () {},
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
                    size: 14.sp,
                  ),
                  10.width,
                ],
                if (index == 1) ...[
                  Icon(
                    MdiIcons.genderFemale,
                    size: 14.sp,
                  ),
                  10.width,
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
