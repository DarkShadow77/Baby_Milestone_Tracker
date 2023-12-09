import 'package:age_calculator/age_calculator.dart';
import 'package:babylid/models/milestones.dart';
import 'package:babylid/screens/Milestones/provider.dart';
import 'package:babylid/screens/account_provider.dart';
import 'package:babylid/utils/appcolors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ViewMilestoneScreen extends StatefulWidget {
  const ViewMilestoneScreen({super.key, required this.index});

  final int index;

  @override
  State<ViewMilestoneScreen> createState() => _ViewMilestoneScreenState();
}

class _ViewMilestoneScreenState extends State<ViewMilestoneScreen> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;

  DateTime _selectedDate = DateTime.now();

  String _milestoneType = "";
  String _additionalNotes = "";
  String date = "Baby's Birth Date";
  String dateFormat = "";

  int index = 0;

  bool dateError = false;

  late DateDuration durations;

  void calculateAge(DateTime birthDate, DateTime selectedDate) {
    durations = AgeCalculator.age(birthDate, today: selectedDate);
    setState(() {
      date = "${durations.years}Y-${durations.months}M-${durations.days}Ds Old";
    });
  }

  @override
  void didChangeDependencies() {
    index = widget.index;

    final milestonesList = Provider.of<MilestoneProvider>(context).milestones;

    _selectedDate = milestonesList[index].date;

    _titleController = TextEditingController(text: milestonesList[index].type);
    _noteController = TextEditingController(text: milestonesList[index].notes);

    super.didChangeDependencies();
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
    final milestonesList = Provider.of<MilestoneProvider>(context).milestones;

    DateTime dateOfBirth = userProvider.dob!;

    calculateAge(dateOfBirth, _selectedDate);

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          milestonesList[index].type,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.black,
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                _milestoneType = _titleController.text.trim();
                _additionalNotes = _noteController.text.trim();
                if (_milestoneType != "" || _additionalNotes != "") {
                  Provider.of<MilestoneProvider>(context, listen: false)
                      .deleteMilestone(index);
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 20.w,
                ),
                child: Image.asset(
                  "assets/image/icons/delete.png",
                  width: 30.w,
                ),
              ),
            ),
          ),
        ],
        shadowColor: AppColors.fadedBlack,
        titleSpacing: 20.w,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MilestoneDropdown(
              text: date,
              onPressed: () async {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: dateOfBirth,
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
                      _selectedDate = dateInputs;
                    });

                    calculateAge(dateOfBirth, _selectedDate);
                  },
                  currentTime: _selectedDate,
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
            Text(
              DateFormat('MMM d, y').format(_selectedDate),
              softWrap: true,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.grey03,
              ),
            ),
            10.height,
            MilestoneTextField(
              controller: _titleController,
              hintText: "Enter the Milestone title",
              onChanged: (value) {
                _milestoneType = value;
              },
            ),
            10.height,
            Expanded(
              child: MilestoneLongTextField(
                controller: _noteController,
                hintText:
                    "Capturing the growing Moments of ${userProvider.name}",
                onChanged: (value) {
                  _additionalNotes = value;
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DateTime now = DateTime.now();
          int timestamp = now.millisecondsSinceEpoch;
          if (_milestoneType != "" || _additionalNotes != "") {
            _milestoneType = _titleController.text.trim();
            _additionalNotes = _noteController.text.trim();
            final newMilestone = BabyMilestone(
              id: timestamp,
              date: _selectedDate,
              type: _milestoneType,
              notes: _additionalNotes,
            );
            Provider.of<MilestoneProvider>(context, listen: false)
                .editMilestone(index, newMilestone);
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        },
        elevation: 12,
        backgroundColor: AppColors.orange,
        splashColor: AppColors.grey03,
        child: Icon(
          Ionicons.checkmark,
          color: AppColors.black,
          size: 30.sp,
        ),
      ),
    );
  }
}

class MilestoneDropdown extends StatelessWidget {
  const MilestoneDropdown({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.black,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              maxLines: 1,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            30.width,
            Icon(
              Ionicons.caret_down_outline,
              color: AppColors.subWhite4,
              size: 15.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class MilestoneTextField extends StatelessWidget {
  const MilestoneTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  final String hintText;
  final String? initialValue;
  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      decoration: const BoxDecoration(
        color: AppColors.black,
        border: Border(
          bottom: BorderSide(
            width: .5,
            color: AppColors.grey03,
          ),
        ),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.subWhite4,
        initialValue: initialValue,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(30),
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: AppColors.black,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.grey02,
            fontSize: 24.sp,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class MilestoneLongTextField extends StatelessWidget {
  const MilestoneLongTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  final String hintText;
  final String? initialValue;
  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      decoration: const BoxDecoration(
        color: AppColors.black,
      ),
      child: TextFormField(
        maxLines: null,
        controller: controller,
        cursorColor: AppColors.subWhite4,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        textCapitalization: TextCapitalization.words,
        style: TextStyle(
          color: AppColors.grey03,
          fontSize: 20.sp,
          height: 1.75,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: AppColors.black,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.grey02,
            fontSize: 20.sp,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
